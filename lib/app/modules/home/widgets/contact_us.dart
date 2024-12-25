import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getx_template/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/values/app_colors.dart';
import '../../login/controllers/login_controller.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us', style: TextStyle(color: AppColors.colorWhite)),
        iconTheme: IconThemeData(color: AppColors.colorWhite),
        backgroundColor: AppColors.gameAppBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildContactRow(Icons.phone, controller.mobileno.value, 'Mobile No 1'),
            _buildContactRow(Icons.phone_android, controller.mobileno2.value, 'Mobile No 2'),
            _buildContactRow(Icons.message, controller.twitter.value, 'Telegram'),
            _buildContactRow(Icons.share, controller.whatsAppNO.value, 'WhatsApp'),
            _buildContactRow(Icons.contact_mail_sharp, controller.instagram.value, 'Instagram'),
            _buildContactRow(Icons.facebook, controller.faceBook.value, 'Facebook'),
            _buildContactRow(Icons.email, controller.email.value, 'Email'),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String contactInfo, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gameAppBarColor, size: 24),
          SizedBox(width: 10), // Spacing between icon and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.black, fontSize: 12)),
                Text(contactInfo, style: TextStyle(color: Colors.black, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
