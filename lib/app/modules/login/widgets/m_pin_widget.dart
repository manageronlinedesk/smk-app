
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/values/app_colors.dart';
import 'package:flutter_getx_template/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/login_controller.dart';

class MPINScreen extends StatefulWidget {
  @override
  _MPINScreenState createState() => _MPINScreenState();
}

class _MPINScreenState extends State<MPINScreen> {
  LoginController loginController = Get.put(LoginController());

  Widget _buildMPINBox(int digit) {

    return Container(
      width: 40,
      height: 50,
      alignment: Alignment.center,
      child: Obx(() =>  Text(
        '${digit < loginController.mPin.value.length ? '*' : ''}',
        style: TextStyle(color: AppColors.colorWhite, fontSize: 30),
      ),),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildNumPad() {
    return SizedBox(
      height: 400,
      child: GridView.builder(
        // padding: const EdgeInsets.all(20), // Add padding around the grid
        itemCount: 12, // 0-9 + delete + blank space
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.6,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == 11) {
            return IconButton(
              onPressed: () {
                if (loginController.mPin.isNotEmpty) {
                  setState(() {
                    loginController.mPin.value = loginController.mPin.value.substring(0, loginController.mPin.value.length - 1);
                  });
                }
              },
              icon: Icon(Icons.backspace, color: Colors.white),
            );
          }
          // Handle empty space
          else if (index == 9) {
            return TextButton(
              onPressed: () {
                print("done");
              },
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            );
          }
          // Handle numeric buttons
          else {
            String buttonText = index == 10 ? '0' : (index + 1).toString();
            return Container(
              padding:
                  const EdgeInsets.all(5), // Add padding around each button
              child: MaterialButton(
                onPressed: () {
                  if (loginController.mPin.value.length < 4) {
                    setState(() {
                      loginController.mPin.value += buttonText;
                      if (loginController.mPin.value.length == 4) {
                        // MPIN is complete, make the API call
                        loginController.loginWithMPIN(context: context, mpin: loginController.mPin.value);
                      }
                    });
                  }
                },
                child: Text(
                  buttonText,
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                shape: CircleBorder(),
                color: AppColors.colorWhite,
                height: 90,
                minWidth: 90,
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gameAppBarColor,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(),
            // Spacer(),
            Column(
              children: [
                const Text('Enter MPIN', style: TextStyle(fontSize: 20, color: Colors.white),),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) => _buildMPINBox(index)),
                  ),
                ),
                _buildNumPad(),
              ],
            ),
            // SizedBox(height: 20,),
            TextButton(
              onPressed: () async {
                const message = "Welcome to the Kalyan Live Matka app customer support. If you have any queries, please let me know";
                String? whatAppNumber = await loginController.getWhatsAppNumber();
                if(whatAppNumber == '' || whatAppNumber == null){
                  bool isFetched = await loginController.fetchAndSaveContactData();
                  if (!isFetched) {
                    // Show error message and exit the method
                    loginController.showToast(context: Get.context!,message: "Error: Check Internet Connection");
                    return;
                  }
                }
                final phoneNumber =  await loginController.getWhatsAppNumber();
                final String url = "https://wa.me/+91$phoneNumber?text=${Uri.encodeComponent(message)}";

                if (await launch(url)) {

                await launch(url);
                } else {
                  print('Could not launch WhatsApp.');                }
              },
              child:  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('images/whatsapp1.png', width: 34, color: Colors.greenAccent),
                  SizedBox(width: 10),
                  Text(
                    'Contact with Us',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
