import 'package:dio/dio.dart';
import 'package:flutter_getx_template/app/data/model/customer.dart';
import 'package:flutter_getx_template/app/data/remote/api_data_source.dart';
import 'package:flutter_getx_template/app/modules/home/model/amount_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/model/bid_place_model.dart';
import '../../core/model/get_card_model.dart';
import '../../core/model/get_contact_info_model.dart';
import '../../core/model/sangam_bid_place_model.dart';
import '../../core/values/api.constants.dart';
import '../../core/values/app_values.dart';
import '../model/config_details_model.dart';
import '../model/game_rates_model.dart';
import '../model/get_bid_history_model.dart';
import '../model/get_result_chart_model.dart';
import '../model/otp_response.dart';
import '../model/win_history_model.dart';
import '/app/core/base/base_remote_source.dart';
import '/app/network/dio_provider.dart';

class ApiDataSourceImpl extends BaseRemoteSource implements ApiDataSource {

  @override
  Future<Customer> register({required Customer customer}) {
    var endpoint = DioProvider.baseUrl + ApiConstants.register;
    var dioCall = dioClient.post(endpoint, data: customer.toJson());

    try {
      return callApiWithErrorParser(dioCall).then((response) => Customer.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Customer> getSpecificUser({required userId})async {
    var endpoint = DioProvider.baseUrl + ApiConstants.getSpecificUser;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('AuthToken');
    Options options = Options(
      headers: {
        'Authorization': token,
      },
    );
    var dioCall = dioClient.post(endpoint,
        data: {
          "userId": userId,
        },
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => Customer.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Customer> login({required Customer customer}) {
    var endpoint = DioProvider.baseUrl + ApiConstants.login;
    var dioCall = dioClient.post(endpoint, data: {"username": customer.data[0].mobileNo, "adminId": AppValues.adminId, "password": customer.data[0].mPin});

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => Customer.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OtpResponse> sendOtp({required mobileNumber}) {
    var endpoint = DioProvider.baseUrl + ApiConstants.sendOtp;
    var dioCall = dioClient.post(endpoint, data: {"mobileNo": mobileNumber});

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => OtpResponse.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OtpResponse> verifyOtp({required mobileNumber, required otpCode}) {
    var endpoint = DioProvider.baseUrl + ApiConstants.verifyOTP;
    var dioCall = dioClient.post(endpoint, data: {"mobileNo": mobileNumber, "otpCode": otpCode});

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => OtpResponse.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Customer> bidPlace({required authToken, required PaymentPayload bidDetails}) async {
    var endpoint = DioProvider.baseUrl + ApiConstants.bidApply;
    Options options = Options(
      headers: {
        'Authorization': authToken,
      },
    );
    var dioCall = dioClient.post(endpoint,
        data: bidDetails,
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => Customer.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  Future<Customer> sangamPlace({required authToken, required SangamBidPayload bidDetails}) async {
    var endpoint = DioProvider.baseUrl + ApiConstants.sangamApply;
    Options options = Options(
      headers: {
        'Authorization': authToken,
      },
    );
    var dioCall = dioClient.post(endpoint,
        data: bidDetails,
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => Customer.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BidHistoryResponseModel> getBidHistory({required authToken,  required String userId , required pageIndex }) async {
    var endpoint = DioProvider.baseUrl + ApiConstants.getBidHistory;
    Options options = Options(
      headers: {
        'Authorization': authToken,
      },
    );
    var dioCall = dioClient.post(endpoint,
        data: {
          "adminId": userId,
          "pageIndex": pageIndex
        },
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => BidHistoryResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }
  Future<GameRates> getGameRates({ required String adminId}) async {
    var endpoint = DioProvider.baseUrl + ApiConstants.getGameRates;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('AuthToken');
    Options options = Options(
      headers: {
        'Authorization': token,
      },

    );
    var dioCall = dioClient.post(endpoint,
        data: {
          "adminId": adminId,
        },
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => GameRates.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ConfigDetails> getConfigSetting({ required String adminId}) async {
    var endpoint = DioProvider.baseUrl + ApiConstants.configSetting;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('AuthToken');
    Options options = Options(
      headers: {
        'Authorization': token,
      },

    );
    var dioCall = dioClient.post(endpoint,
        data: {
          "adminId": adminId,
        },
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => ConfigDetails.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ChartResponseModel > getResultChart({ required String adminId , required String cardId}) async {
    var endpoint = DioProvider.baseUrl + ApiConstants.getResultChart;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('AuthToken');
    Options options = Options(
      headers: {
        'Authorization': token,
      },

    );
    var dioCall = dioClient.post(endpoint,
        data: {
          "adminId": adminId,
          "cardId":cardId
        },
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => ChartResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WinHistoroyResponseModel > getWinHistory({required userId, required pageIndex}) async {
    var endpoint = DioProvider.baseUrl + ApiConstants.getWinHistory;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('AuthToken');
    Options options = Options(
      headers: {
        'Authorization': token,
      },

    );
    var dioCall = dioClient.post(endpoint,
        data: {
          "adminId": userId,
          "pageIndex": pageIndex,
        },
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => WinHistoroyResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel > getContactInfo({ required String adminId}) async {
    var endpoint = DioProvider.baseUrl + ApiConstants.contactInfo;

    var dioCall = dioClient.post(endpoint,
        data: {
          "adminId": adminId,
        },
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => ResponseModel .fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addAmount({required adminId, required userId, required double amount, required paymentId}) async {
    var endpoint = DioProvider.baseUrl + ApiConstants.addAmount;

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('AuthToken');
    Options options = Options(
      headers: {
        'Authorization': token,
      },

    );
    var dioCall = dioClient.post(endpoint,
        data: {"adminId": adminId ,"userId": userId, "amount": amount,"paymentId": paymentId},
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => PaymentPayload.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }
  Future<Customer> withdrawAmountReq({required adminId, required userId, required double amount, required mobileNo, required paymentType}) async {
    var endpoint = DioProvider.baseUrl + ApiConstants.withdrawAmountReq;

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('AuthToken');
    Options options = Options(
      headers: {
        'Authorization': token,
      },

    );
    var dioCall = dioClient.post(endpoint,
        data: {"adminId": adminId ,"userId": userId, "amount": amount, "mobileNo": mobileNo, "paymentType": paymentType},
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => Customer.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<RootResponse> getAllCard( {required authToken, required String id} ) async {
    var endpoint =  DioProvider.baseUrl +  ApiConstants.getAllCard;
    Options options = Options(
      headers: {
        'Authorization': authToken,
      },
    );
    var dioCall = dioClient.post(endpoint,
        data: {
      "adminId": id,
        },
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => RootResponse.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Customer> changeMpin({required userId, required mpin}) async {
    var endpoint =  DioProvider.baseUrl +  ApiConstants.changeMpin;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('AuthToken');
    Options options = Options(
      headers: {
        'Authorization': token,
      },
    );
    var dioCall = dioClient.post(endpoint,
        data: {
          "userId": userId,
          "mpin": mpin,
        },
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => Customer.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Customer> changeMpinByMobile({required mobileNumber, required mPin}) async {
    var endpoint =  DioProvider.baseUrl +  ApiConstants.changeMpinByMobile;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('AuthToken');
    Options options = Options(
      headers: {
        'Authorization': token,
      },
    );
    var dioCall = dioClient.post(endpoint,
        data: {
          "mobileNo": mobileNumber,
          "mpin": mPin,
        },
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => Customer.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AmountHistoryModel> getAmountHistory({required adminId, required userId, required pageIndex}) async {
    var endpoint =  DioProvider.baseUrl +  ApiConstants.amountHistory;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('AuthToken');
    Options options = Options(
      headers: {
        'Authorization': token,
      },
    );
    var dioCall = dioClient.post(endpoint,
        data: {
          "adminId": adminId,
          "userId": userId,
          "pageIndex": pageIndex
        },
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => AmountHistoryModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Customer> checkUserExist({required mobileNumber}) async {
    var endpoint =  DioProvider.baseUrl +  ApiConstants.checkUserExist;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('AuthToken');
    Options options = Options(
      headers: {
        'Authorization': token,
      },
    );
    var dioCall = dioClient.post(endpoint,
        data: {
          "mobileNo": mobileNumber,
        },
        options: options
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => Customer.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

}
