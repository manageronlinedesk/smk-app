abstract class ApiConstants {
  // Authentication
  static const String register = "api/users";
  static const String sendOtp = "api/otp/sendOtp";
  static const String verifyOTP = "api/otp/verifyOtp";
  static const String login = "api/login";
  static const String bidApply = "api/bidHistory/add";
  static const String sangamApply = "api/bidHistory/sangam";
  static const String getBidHistory = "api/bidHistory/getBids";
  static const String getGameRates = "api/gameRates";

  static const String addAmount = "api/amount/addAmount";
  static const String withdrawAmountReq = "api/amount/requestAmount";
  static const String configSetting = "api/config";
  static const String getResultChart = "api/card-result-history";
  static const String getWinHistory = "api/win-history";
  static const String contactInfo = "api/get-contact-details";
  static const String properties = "properties";
  static const String getAllCard = "api/getCards";
  static const String getSpecificUser = "api/getSpecificUser";
  static const String changeMpin = "api/change-mpin";
  static const String changeMpinByMobile = "api/change-mpin-by-mobile";
  static const String amountHistory = "api/amount/history";
  static const String checkUserExist = "api/check-user-exist";
}
