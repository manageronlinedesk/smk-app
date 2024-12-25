class BidHistoryResponseModel {
  // final int statusCode;
  // final String description;
  final ApiResponse response;
  final int totalData;
  final List<BidData> data;

  BidHistoryResponseModel({
    // required this.statusCode,
    // required this.description,
    required this.response,
    required this.totalData,
    required this.data,
  });

  factory BidHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<BidData> dataList = list.map((i) => BidData.fromJson(i)).toList();

    return BidHistoryResponseModel(
      // statusCode: json['statusCode'],
      // description: json['description'],
      response: ApiResponse.fromJson(json['response']),
      totalData: json['totalData'],
      data: dataList,
    );
  }
}
class ApiResponse {
  final int statusCode;
  final String description;

  ApiResponse({required this.statusCode, required this.description});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      statusCode: json['statusCode'],
      description: json['description'],
    );
  }
}


class BidData {
  final int? id;
  final String? adminid;
  final String? cardid;
  final String? innercardid;
  final String? userid;
  final int? amount;
  final int? digit;
  final bool? isopen;
  final DateTime? datetime;
  final bool? status;
  final String? name;
  final String? mobileno;
  final String? title;
  final String? gametype;
  final String? counts;
  final int? totalpages;

  BidData({
    required this.id,
    this.adminid,
    this.cardid,
    this.innercardid,
    this.userid,
    required this.amount,
    required this.digit,
    this.isopen,
    this.datetime,
    this.status,
    this.name,
    this.mobileno,
    this.title,
    this.gametype,
    this.counts,
    this.totalpages,
  });

  factory BidData.fromJson(Map<String, dynamic> json) {
    return BidData(
      id: json['id'],
      adminid: json['adminid'],
      cardid: json['cardid'],
      innercardid: json['innercardid'],
      userid: json['userid'],
      amount: json['amount'],
      digit: json['digit'],
      isopen: json['isopen'],
      datetime: json['datetime'] != null ? DateTime.parse(json['datetime']) : null,
      status: json['status'],
      name: json['name'],
      mobileno: json['mobileno'],
      title: json['title'],
      gametype: json['gametype'],
      counts: json['counts'],
      totalpages: json['totalpages'],
    );
  }
}
