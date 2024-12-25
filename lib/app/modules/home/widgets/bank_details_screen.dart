import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/global_enums.dart';



class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);

  Future<WithdrawalStatus> performWithdrawal() async {
    try {
      // Perform the withdrawal operation here
      // Deduct the withdrawal amount from the user's balance
      // Update transaction history
      // Handle any other necessary operations
      return WithdrawalStatus.success; // If withdrawal is successful
    } catch (error) {
      // Handle withdrawal failure
      return WithdrawalStatus.failure; // If withdrawal fails
    }
  }
  bool validateUserInput() {
    // Perform input validation here
    // If input is valid, return true; otherwise, return false
    // You can show error messages to the user if validation fails
    return true; // For simplicity, return true if validation succeeds
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text("Bank Details",style: TextStyle(color: AppColors.colorWhite)),
        backgroundColor: AppColors.gameAppBarColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Account Holder Name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Account Holder Name",style: TextStyle(color: Colors.white)),
                SizedBox(height: 5,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter Account Holder Name",
                    labelStyle: TextStyle(color: Colors.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Account Number
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Account Number",style: TextStyle(color: Colors.white)),
                SizedBox(height: 5,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter Account Number",
                    labelStyle: TextStyle(color: Colors.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Confirm Account Number
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Confirm Account Number",style: TextStyle(color: Colors.white)),
                SizedBox(height: 5,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter Confirm Account Number",
                    labelStyle: TextStyle(color: Colors.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // IFSC Code
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("IFSC Code",style: TextStyle(color: Colors.white)),
                SizedBox(height: 5,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter IFSC Code",
                    labelStyle: TextStyle(color: Colors.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Bank Name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bank Name" ,style: TextStyle(color: Colors.white),),
                SizedBox(height: 5,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter Bank Name",
                    labelStyle: TextStyle(color: Colors.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Branch Address
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Branch Address",style: TextStyle(color: Colors.white)),
                SizedBox(height: 5,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter Branch Address",
                    labelStyle: TextStyle(color: Colors.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 32),

            // Submit Request Button
            ElevatedButton(
              onPressed: () async{
                if (validateUserInput()) {
                  // Perform the withdrawal logic
                  final withdrawalResult = await performWithdrawal();
                  if (withdrawalResult == WithdrawalStatus.success) {
                    // Withdrawal successful
                    // Show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Withdrawal request successful."),
                      ),
                    );

                    // Navigate back to the wallet statement or another relevant screen
                    Get.back();
                  } else {
                    // Withdrawal failed
                    // Show an error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Withdrawal request failed. Please try again."),
                      ),
                    );
                  }
                }
              },
              child: Text("Submit Request"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
