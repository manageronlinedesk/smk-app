import 'package:get/get.dart';

import '../modules/bid_history/bindings/bid_history_binding.dart';
import '../modules/bid_history/views/bid_history_view.dart';

import '../modules/game_rates/bindings/game_rates_binding.dart';
import '../modules/game_rates/views/game_rates_view.dart';
import '../modules/game_screens/bindings/game_screens_binding.dart';
import '../modules/game_screens/views/game_screens_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/otpscreen/bindings/otp_screen_binding.dart';
import '../modules/otpscreen/views/otp_screen_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/waiting_screen/bindings/waiting_screen_binding.dart';
import '../modules/waiting_screen/views/waiting_screen_view.dart';
import '../modules/win_history/bindings/win_history_binding.dart';
import '../modules/win_history/views/win_history_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WAITING_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.OTPSCREEN,
      page: () => const OtpScreenView(),
      binding: OtpScreenBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GAME_SCREENS,
      page: () => const GameScreensView(
        isOpenTimeActive: false,
        openingTime: '',
        closingTime: '',
        innerCards: [],
        cardId: '',
      ),
      binding: GameScreensBinding(),
    ),
    GetPage(
      name: _Paths.WIN_HISTORY,
      page: () => const WinHistoryView(),
      binding: WinHistoryBinding(),
    ),
    GetPage(
      name: _Paths.GAME_RATES_VIEW,
      page: () => const GameRatesView(),
      binding: GameRatesBinding(),
    ),
    GetPage(
      name: _Paths.BID_HISTORY,
      page: () => const BidHistoryView(),
      binding: BidHistoryBinding(),
      ),

     GetPage(
      name: _Paths.WAITING_SCREEN,
      page: () => const WaitingScreenView(),
      binding: WaitingScreenBinding(),
    ),
  ];
}
