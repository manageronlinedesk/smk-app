class AmountHistoryResponseStatus {
  final int statusCode;
  final String description;

  AmountHistoryResponseStatus({
    required this.statusCode,
    required this.description,
  });

  factory AmountHistoryResponseStatus.fromJson(Map<String, dynamic> json) {
    return AmountHistoryResponseStatus(
      statusCode: json['statusCode'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'description': description,
    };
  }
}

class PaymentData {
  final int? id;
  final String? userId;
  final String? paymentId;
  final String? adminId;
  final int? amount;
  final bool? isRequested;
  final bool? isPaid;
  final bool? isRequestCancelled;
  final String? datetime;
  final String? paymentType;
  final String? mobileNo;

  PaymentData({
    required this.id,
    required this.userId,
    required this.paymentId,
    required this.adminId,
    required this.amount,
    required this.isRequested,
    required this.isPaid,
    required this.isRequestCancelled,
    required this.datetime,
    this.paymentType,
    this.mobileNo,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      id: json['id'] ?? 0,
      userId: json['userid'] ?? "",
      paymentId: json['paymentid'] ?? "",
      adminId: json['adminid'] ?? "",
      amount: json['amount'] ?? 0,
      isRequested: json['isrequested'] ?? false,
      isPaid: json['ispaid'] ?? false,
      isRequestCancelled: json['isrequestcancelled'] ?? false,
      datetime: json['datetime'] ?? "",
      paymentType: json['paymenttype'],
      mobileNo: json['mobileno'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userId,
      'paymentid': paymentId,
      'adminid': adminId,
      'amount': amount,
      'isrequested': isRequested,
      'ispaid': isPaid,
      'isrequestcancelled': isRequestCancelled,
      'datetime': datetime,
      'paymenttype': paymentType,
      'mobileno': mobileNo,
    };
  }
}

class AmountHistoryModel {
  final AmountHistoryResponseStatus response;
  final List<PaymentData> data;

  AmountHistoryModel({
    required this.response,
    required this.data,
  });

  factory AmountHistoryModel.fromJson(Map<String, dynamic> json) {
    return AmountHistoryModel(
      response: AmountHistoryResponseStatus.fromJson(json['response']),
      data: List<PaymentData>.from(json['data'].map((data) => PaymentData.fromJson(data))),
    );
  }
}
