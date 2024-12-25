class WinHistoroyResponseModel {
  final int statusCode;
  final String description;
  final int totalData;
  final List<WinBidData> data;

  WinHistoroyResponseModel({
    required this.statusCode,
    required this.description,
    required this.totalData,
    required this.data,
  });

  factory WinHistoroyResponseModel.fromJson(Map<String, dynamic> json) {
    var responseData = json['data'] as List<dynamic>? ?? [];
    var bidDataList = responseData.map((dataItem) => WinBidData.fromJson(dataItem)).toList();
    return WinHistoroyResponseModel(
      statusCode: json['response']['statusCode'],
      description: json['response']['description'],
      totalData: json['totalData'],
      data: bidDataList,
    );
  }
}

class WinBidData {
  final int? id;
  final String? adminId;
  final String? cardId;
  final String? innerCardId;
  final String? userId;
  final int? amount;
  final int? digit;
  final bool? isOpen;
  final String? datetime;
  final bool? status;
  final String? name;
  final String? mobileNo;
  final String? title;
  final String? gameType;
  final String? counts;
  final int? totalPages;

  WinBidData({
     this.id,
     this.adminId,
     this.cardId,
     this.innerCardId,
     this.userId,
    this.amount,
    this.digit,
    this.isOpen,
    this.datetime,
    this.status,
    this.name,
    this.mobileNo,
    this.title,
    this.gameType,
    this.counts,
    this.totalPages,
  });

  factory WinBidData.fromJson(Map<String, dynamic> json) {
    return WinBidData(
      id: json['id'] ?? 0,
      adminId: json['adminid'] ?? '',
      cardId: json['cardid'] ?? '',
      innerCardId: json['innercardid'] ?? '',
      userId: json['userid'] ?? '',
      amount: json['amount'],
      digit: json['digit'],
      isOpen: json['isopen'],
      datetime: json['datetime'] ?? '',
      status: json['status'],
      name: json['name'] ?? '',
      mobileNo: json['mobileno'] ?? '',
      title: json['title'] ?? '',
      gameType: json['gametype'] ?? '',
      counts: json['counts'] ?? '',
      totalPages: json['totalpages'],
    );
  }
}
