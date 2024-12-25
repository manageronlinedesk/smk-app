import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/values/app_values.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upi_india/upi_india.dart';

import '../../../core/values/app_colors.dart';
import '../../../data/remote/api_data_source_impl.dart';
import '../controllers/home_controller.dart';

class UpiOptions extends StatefulWidget {
  final double amount;

  const UpiOptions({Key? key, required this.amount}) : super(key: key);

  @override
  _AddFundsState createState() => _AddFundsState();

}

class _AddFundsState extends State<UpiOptions> {
  HomeController controller = Get.put(HomeController());
  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<Map<String, String>> getSavedUpiDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String upiId = prefs.getString('upiid') ?? 'alishalahoribangles.ibz1@icici'; // Replace with default/error value
    String receiverName = prefs.getString('accountholdername') ?? 'Shyam  baba trust'; // Add the key used to save receiver's name
    return {'upiId': upiId, 'accountholdername': receiverName};
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    var upiDetails = await getSavedUpiDetails(); // Retrieve UPI details

    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: upiDetails['upiId']!,
      receiverName: upiDetails['accountholdername']!,
      transactionRefId: 'UniqueTransactionId',
      transactionNote: 'Description of the transaction',
      amount: widget.amount, // Replace with the actual amount to be added
      // amount: double.parse(controller.pointsController.text), // Replace with the actual amount to be added
      flexibleAmount: false,
    );
  }
  Future<UpiResponse> initiateWithdrawal(UpiApp app, double amount, String userUpiId, String userName) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: userUpiId,  // Dynamic UPI ID from user's profile
      receiverName: userName,    // User's name
      transactionRefId: 'UniqueWithdrawalId${DateTime.now().millisecondsSinceEpoch}',  // Unique reference
      transactionNote: 'Withdrawal from Wallet',
      amount: widget.amount,
      flexibleAmount: false,
    );
  }



  Widget displayUpiApps() {
    if (apps == null) {
      return Center(child: CircularProgressIndicator());
    } else if (apps!.length == 0) {
      return Center(
        child: Text(
          "No apps found to handle the transaction.",
          style: header,
        ),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on the device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'The requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'The requested app cannot handle the transaction';
      default:
        return 'An unknown error has occurred';
    }
  }

  void _checkTxnStatus(UpiResponse response) {
    String? status = response.status;
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        _onSuccess(response);
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }
  Future<void> _onSuccess(UpiResponse response) async {
    if (response.status != UpiPaymentStatus.SUCCESS) {
      print('Not a successful transaction');
      return;
    }

    String paymentId = response.transactionId ?? 'N/A';
    double amount = widget.amount;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? 'N/A';

    try {
      await ApiDataSourceImpl().addAmount(
        adminId: AppValues.adminId,
        userId: userId,
        amount: amount,
        paymentId: paymentId,
      );
      // Handle success
      print('API call successful');
    } catch (error) {
      // Handle error
      print('API call failed: $error');
    }
  }
  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
            child: Text(
              body,
              style: value,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI Payment' ,style: TextStyle(color: AppColors.colorWhite), ),
        iconTheme: const IconThemeData(color: Colors.white), // Set the icon color here

        backgroundColor: AppColors.gameAppBarColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: displayUpiApps(),
          ),
          Expanded(
            child: FutureBuilder(
              future: _transaction,
              builder: (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        _upiErrorHandler(snapshot.error.runtimeType),
                        style: header,
                      ),
                    );
                  }

                  UpiResponse _upiResponse = snapshot.data!;
                  String txnId = _upiResponse.transactionId ?? 'N/A';
                  String resCode = _upiResponse.responseCode ?? 'N/A';
                  String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                  String status = _upiResponse.status ?? 'N/A';
                  String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
                  _checkTxnStatus(_upiResponse);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        displayTransactionData('Transaction Id', txnId),
                        displayTransactionData('Response Code', resCode),
                        displayTransactionData('Reference Id', txnRef),
                        displayTransactionData('Status', status.toUpperCase()),
                        displayTransactionData('Approval No', approvalRef),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

