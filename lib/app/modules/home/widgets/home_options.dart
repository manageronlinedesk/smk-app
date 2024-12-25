import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/model/get_contact_info_model.dart';
import 'package:flutter_getx_template/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_getx_template/app/modules/home/widgets/withdrawal_funds.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../login/controllers/login_controller.dart';
import 'add_funds.dart';

class HomeOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        GestureDetector(
          onTap: () async {
            String? whatAppNumber = await controller.getWhatsAppNumber();
            final phoneNumber = whatAppNumber;
            const message = "Welcome to the Kalyan Live Matka app customer support. If you have any queries, please let me know";

            final String url = "https://wa.me/+91$phoneNumber?text=${Uri.encodeComponent(message)}";
            if (await launch(url)) {

              await launch(url);
            } else {
              controller.showToast(context: context, message: "WhatsApp is not Installed");
            }
          },
          child: boxOption(title: 'WhatsApp', iconData: Icons.share,),
        ),
        boxOption(title: 'Starline', iconData: Icons.star),
        GestureDetector(
          onTap: (){
            Get.to(AddFunds());
          },
          child: boxOption(title: 'Add Point', iconData: Icons.add),
        ),
        GestureDetector(
          onTap: (){

            Get.to(WithdrawFunds());
          },
          child: boxOption(title: 'Widthdraw', iconData: Icons.money),
        ),



      ]),
    );
  }
}

Widget boxOption({required String title, required IconData iconData}) {
  return Container(
    alignment: Alignment.center,
    width: Get.width / 4 - 10,
    height: 70,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(255, 0, 75, 136),
    ),
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Icon(
        iconData,
        color: Colors.white,
      ),
      Text(
        title.toUpperCase(),
        maxLines: 2,
        style: TextStyle(color: Colors.white, fontSize: 12),
      )
    ]),
  );
}
