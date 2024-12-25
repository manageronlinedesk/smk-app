class WithdrawResponse {
  final int statusCode;
  final String description;
  final List<dynamic> data; // Depending on the type of data you expect

  WithdrawResponse({
    required this.statusCode,
    required this.description,
    required this.data,
  });

  factory WithdrawResponse.fromJson(Map<String, dynamic> json) {
    return WithdrawResponse(
      statusCode: json['statusCode'],
      description: json['description'],
      data: json['data'] ?? [], // Default value for data in case it's null
    );
  }
}

class PaymentPayload {
  String? adminId;
  String? cardId;
  String? innerCardId;
  String? userId;
  String? amount;
  String? digit;
  String? isOpen;

  PaymentPayload({
    this.adminId,
    this.cardId,
    this.innerCardId,
    this.userId,
    this.amount,
    this.digit,
    this.isOpen,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['adminId'] = this.adminId;
    data['cardId'] = this.cardId;
    data['innerCardId'] = this.innerCardId;
    data['userId'] = this.userId;
    data['amount'] = this.amount;
    data['digit'] = this.digit;
    data['isOpen'] = this.isOpen;
    return data;
  }

  factory PaymentPayload.fromJson(Map<String, dynamic> json) {
    return PaymentPayload(
      adminId: json['adminId'],
      cardId: json['cardId'],
      innerCardId: json['innerCardId'],
      userId: json['userId'],
      amount: json['amount'],
      digit: json['digit'],
      isOpen: json['isOpen'],
    );
  }
}
