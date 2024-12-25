import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../values/app_colors.dart';

class ConfirmBidDialog extends StatelessWidget {
  final int totalBids;
  final double digit;
  final double totalBidAmount;
  final double walletAmountBefore;
  final double walletAmountAfter;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  ConfirmBidDialog({
    required this.totalBids,
    required this.digit,
    required this.totalBidAmount,
    required this.walletAmountBefore,
    required this.walletAmountAfter,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Confirm Your Bid" ,style: TextStyle(fontWeight: FontWeight.bold))),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text("Total Bids: $totalBids"),
            Text("Digit: $digit"),
            Text("Total Bid Amount: \u20B9$totalBidAmount"),
            Text("Wallet Amount Before: \u20B9$walletAmountBefore"),
            Text("Wallet Amount After : \u20B9$walletAmountAfter"),
            SizedBox(height: 10),
            Center(child: Text("Note: Once you place a bid, it cannot be cancelled in any situation.", style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Cancel",style: TextStyle(color: AppColors.gameAppBarColor)),
          onPressed: onCancel,
        ),
        TextButton(
          child: Text("Confirm" ,style: TextStyle(color: AppColors.gameAppBarColor),),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
