
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/values/app_colors.dart';
import '../controllers/home_controller.dart';


class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);

  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',style: TextStyle(color: AppColors.colorWhite)),
        iconTheme: const IconThemeData(color: AppColors.colorWhite),
        backgroundColor: AppColors.gameAppBarColor,
      ),
      body: Column(
          children:[
            Container(
              alignment: Alignment.center,
              width: Get.width,
              height: Get.height/7,

              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: AppColors.gameAppBarColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              // Blue background color
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 20),

                  Text(
                    controller.name.value, // Replace with actual mobile number
                    style: TextStyle(fontSize: 16 ,color: AppColors.colorWhite),
                  ),

                  Spacer(), // Add space to push the IconButton to the right
                  IconButton(
                    onPressed: () {
                      // Add edit functionality here
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.white, // White icon color
                  ),
                ],
              ),

            ),
            // SizedBox(height: 123,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Padding(
                  padding: EdgeInsets.only(left: 20,bottom: 10), // Add your desired padding values here
                  child: Text("Name",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: AppColors.primary)),
                    child: TextField(
                      // controller: controller.name.value.isNotEmpty ? controller.name.value : null,
                      decoration: const InputDecoration(
                          hintText: 'Name',
                          border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10)
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 20,bottom: 10), // Add your desired padding values here
                  child: Text("Email",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),

                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: AppColors.primary)),
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: 'Email',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10)
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            )

          ]

      ),
    );
  }
}


