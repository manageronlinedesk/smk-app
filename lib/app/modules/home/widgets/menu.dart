import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/modules/home/widgets/profile.dart';
import 'package:flutter_getx_template/app/modules/home/widgets/wallet_statement.dart';
import 'package:flutter_getx_template/app/modules/home/widgets/withdrawal_funds.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/app_pages.dart';
import '../../bid_history/views/bid_history_view.dart';
import '../../game_rates/views/game_rates_view.dart';
import '../../login/widgets/change_password.dart';
import '../../win_history/views/win_history_view.dart';
import '../controllers/home_controller.dart';
import 'add_funds.dart';
import 'contact_us.dart';


class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController controller = HomeController();
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
          children: [
            menuTitle(title: 'Home', icon: Icons.home, onPressed: () {

              Navigator.pop(context);
            }),
            menuTitle(
                title: 'Profile', icon: Icons.verified_user, onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            }),
            menuTitle(title: 'Add Funds', icon: Icons.wallet, onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddFunds()),
              );
            }),
            menuTitle(
                title: 'Withdraw Funds',
                icon: Icons.wallet_giftcard,
                onPressed: () {

                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WithdrawFunds()),
                  );
                }),
            menuTitle(
                title: 'Wallet Statement',
                icon: Icons.wallet_membership,

                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WalletStatement()),
                  );
                }),
            menuTitle(title: 'Bid History', icon: Icons.history, onPressed: () {
              Get.toNamed('/bid-history');
            }),
            menuTitle(
                title: 'Win History',
                icon: Icons.chrome_reader_mode_sharp,
                onPressed: () {
                  Get.toNamed(Routes.WIN_HISTORY);
                }),
              menuTitle(
                  title: 'Game Rates',
                  icon: Icons.rate_review_sharp,
                  onPressed: () {
                    Get.toNamed(Routes.GAME_RATES_VIEW);
                  }),
            menuTitle(title: 'Help and Info', icon: Icons.help, onPressed: () {}),
            menuTitle(title: 'Contact Us', icon: Icons.support, onPressed: () {
              Get.to(ContactUsScreen());
            }),


            menuTitle(title: 'Share With Friends', icon: Icons.share, onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String appLink = prefs.getString('applink') ?? 'http://default-link.com'; // Replace with a default link if not set
              String appMsg = prefs.getString('appmsg') ?? 'Check out this amazing app!'; // Replace with a default message if not set

              final String message =  "$appMsg $appLink";
              final String url = "https://wa.me/?text=${Uri.encodeComponent(message)}";


              if (await launch(url)) {
                await launch(url);
              } else {
                print('Could not launch WhatsApp.');
              }
            }),
            menuTitle(title: 'Rate App', icon: Icons.rate_review, onPressed: () {}),
            menuTitle(title: 'Change Password', icon: Icons.lock, onPressed: () {
              Get.to(ChangePasswordScreen());
            }),

            menuTitle(title: 'Logout', icon: Icons.logout, onPressed: () async {
              await controller.clearUserData();
              Get.offAllNamed(Routes.LOGIN);
            }),
          ]),
    );
  }
}

menuTitle(
    {required String title,
      required IconData icon,
      required VoidCallback onPressed}) {

  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.only(bottom: 13),

      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 28,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            )
          ]),
    ),
  );
}
