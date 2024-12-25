class SangamBidPayload {
  String? adminId;
  String? cardId;
  String? innerCardId;
  String? userId;
  String? amount;
  String? isFullSangam;
  String? openPanna;
  String? closePanna;
  String? isOpen;


  SangamBidPayload({
    this.adminId,
    this.cardId,
    this.innerCardId,
    this.userId,
    this.amount,
    this.isFullSangam,
    this.isOpen,
    this.closePanna,
    this.openPanna
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['adminId'] = this.adminId;
    data['cardId'] = this.cardId;
    data['innerCardId'] = this.innerCardId;
    data['userId'] = this.userId;
    data['amount'] = this.amount;
    data['isFullSangam'] = this.isFullSangam;
    data['isOpen'] = this.isOpen;
    data['openPanna'] = this.openPanna;
    data['closePanna'] = this.closePanna;
    return data;
  }

  factory SangamBidPayload.fromJson(Map<String, dynamic> json) {
    return SangamBidPayload(
      adminId: json['adminId'],
      cardId: json['cardId'],
      innerCardId: json['innerCardId'],
      userId: json['userId'],
      amount: json['amount'],
      isFullSangam: json['isFullSangam'],
      isOpen: json['isOpen'],
      openPanna: json['openPanna'],
      closePanna: json['closePanna'],
    );
  }
}
