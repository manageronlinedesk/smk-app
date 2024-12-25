import 'package:flutter_getx_template/app/data/model/customer.dart';
import '../../core/model/bid_place_model.dart';
import '../../core/model/get_card_model.dart';
import '../../core/model/get_contact_info_model.dart';
import '../../core/model/sangam_bid_place_model.dart';
import '../../modules/home/model/amount_history_model.dart';
import '../model/config_details_model.dart';
import '../model/game_rates_model.dart';
import '../model/get_bid_history_model.dart';
import '../model/get_result_chart_model.dart';
import '../model/otp_response.dart';
import '../model/win_history_model.dart';

abstract class ApiDataSource {
  // Authentication
  Future<Customer> register({required Customer customer});
  Future<Customer> login({required Customer customer});
  Future<OtpResponse> sendOtp({required mobileNumber});
  Future<OtpResponse> verifyOtp({required mobileNumber, required otpCode});
  Future<Customer> changeMpin({required userId, required mpin});
  Future<Customer> changeMpinByMobile({required mobileNumber, required mPin});
  Future<Customer> checkUserExist({required mobileNumber});

    // Getting Data
  Future<RootResponse> getAllCard({required authToken, required String id});
  Future<GameRates> getGameRates({required String adminId });
  Future<Customer> getSpecificUser({required userId});
  Future<ConfigDetails> getConfigSetting({required String adminId });
  Future<ResponseModel > getContactInfo({required String adminId });
  Future<ChartResponseModel > getResultChart({required String adminId ,required String cardId });

  // Getting History
  Future<BidHistoryResponseModel> getBidHistory({required authToken,  required String userId , required pageIndex});
  Future<WinHistoroyResponseModel > getWinHistory({required userId, required pageIndex});
  Future<AmountHistoryModel> getAmountHistory({required adminId, required userId, required pageIndex});

  // Place Bid
  Future<Customer> bidPlace({required authToken, required PaymentPayload bidDetails});
  Future<Customer> sangamPlace({required authToken, required SangamBidPayload bidDetails});

  // Amount Request or Add
  Future<void> addAmount({required adminId, required userId, required double amount, required paymentId });
  Future<Customer> withdrawAmountReq({required adminId, required userId, required double amount, required mobileNo, required paymentType});
}
