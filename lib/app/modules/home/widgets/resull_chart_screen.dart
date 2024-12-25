import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/values/app_colors.dart';
import 'package:intl/intl.dart';

import '../../../data/model/get_result_chart_model.dart';

class ResultScreen extends StatelessWidget {
  final List<CardHistory> historyList;

  ResultScreen({required this.historyList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Result History',
          style: TextStyle(color: AppColors.colorWhite),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primary,
      ),
      body: Builder(
        builder: (BuildContext context) {
          if (historyList.isEmpty) {
            return Center(
              child: Text(
                'No Data Available',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            );
          } else {
            return ListView(
              children: [
                for (int i = 0; i < historyList.length; i += 4)
                  Row(
                    children: [
                      for (int j = i;
                      j < i + 4 && j < historyList.length;
                      j++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: _buildColumnBlock(historyList[j]),
                          ),
                        ),
                    ],
                  ),
                SizedBox(height: 10),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildColumnBlock(CardHistory? history) {
    return history != null
        ? Card(
            color: AppColors.colorWhite,
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColors.gameAppBarColor)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  child: Column(children: [
                SizedBox(height: 5),
                Text('${DateFormat('EEEE').format(history.datetime!)}',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gameAppBarColor)),
                Text('${DateFormat('dd MMM yyyy').format(history.datetime!)}',
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w300,
                        color: Colors.black)),
                Divider(color: AppColors.gameAppBarColor),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...history.result1
                                .toString()
                                .padLeft(3, '0')
                                .split('')
                                .map((digit) => Text(digit,
                                    style: TextStyle(color: Colors.red)))
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(''),
                            Text('${history.result2}',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green)),
                            Text('')
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...history.result3
                                .toString()
                                .padLeft(3, '0')
                                .split('')
                                .map((digit) => Text(digit,
                                    style: TextStyle(color: Colors.red)))
                          ])
                    ])
              ]))
            ]))
        : Expanded(child: Container());
  }
}
