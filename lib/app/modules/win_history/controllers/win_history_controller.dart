import 'package:flutter_getx_template/app/core/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/win_history_model.dart';

class WinHistoryController extends BaseController {
  //TODO: Implement WinHistoryController

  final count = 0.obs;


  RxList<WinBidData> winHistoryList = <WinBidData>[].obs;

  RxInt currentPage = 1.obs;
  RxBool isLoading = true.obs;
  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  Future<bool> onRefresh() async {
    currentPage.value = 1;
    WinHistoroyResponseModel? response = await fetchWinHistory(pageIndex: currentPage.value);

    if (response == null) {
      refreshController.refreshFailed();
      return true;
    } else if (response.data.isNotEmpty) {
      winHistoryList.assignAll(response.data);
      refreshController.refreshCompleted();
      return true;
    } else {
      refreshController.refreshCompleted();
      return true;
    }
  }

  onLoading() async {
    currentPage.value++;
    WinHistoroyResponseModel? response = await fetchWinHistory(pageIndex: currentPage.value);

    if (response == null) {
      refreshController.loadFailed();
    } else if (response.data.isNotEmpty) {
      winHistoryList.addAll(response.data);
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
      await Future.delayed(const Duration(seconds: 1));
      refreshController.loadComplete();
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    bool isInitialRefreshComplete = await onRefresh();
    isLoading.value = !isInitialRefreshComplete;
  }

  Future<WinHistoroyResponseModel?> fetchWinHistory({pageIndex}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = await getAuthToken();
    String? userId = prefs.getString('userId');
    try {
      WinHistoroyResponseModel response = (await apiDataSource.getWinHistory(userId: userId.toString(), pageIndex: pageIndex));
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }



  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
