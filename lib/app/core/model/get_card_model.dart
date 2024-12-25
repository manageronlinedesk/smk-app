
class RootResponse {
  int? statusCode;
  String? description;
  List<CardResponse>? data;

  RootResponse({this.statusCode, this.description, this.data});

  factory RootResponse.fromJson(Map<String, dynamic> json) => RootResponse(
    statusCode: json['statusCode'],
    description: json['description'],
    data: json['data'] == null
        ? null
        : List<CardResponse>.from(
        json['data'].map((x) => CardResponse.fromJson(x))),
  );
}

class CardResponse {
  int? id;
  String? cardid;
  String? title;
  String? opentime;
  String? closetime;
  int? minbid;
  int? maxbid;
  bool? isactive;
  List<InnerCard>? innercards;
  String? result1;
  String? result2;
  String? result3;

  CardResponse({
    this.id,
    this.cardid,
    this.title,
    this.opentime,
    this.closetime,
    this.minbid,
    this.maxbid,
    this.isactive,
    this.innercards,
    this.result1,
    this.result2,
    this.result3,
  }) {
    // Check if result1 is "0", then replace it with "***"
    if (result1 == "0") {
      result1 = "***";
    }
    // Check if result1 is "0", then replace it with "***"
    if (result3 == "0") {
      result3 = "***";
    }
  }

  factory CardResponse.fromJson(Map<String, dynamic> json) => CardResponse(
    id: json['id'],
    cardid: json['cardid'],
    title: json['title'],
    opentime: json['opentime'],
    closetime: json['closetime'],
    minbid: json['minbid'],
    maxbid: json['maxbid'],
    isactive: json['isactive'],
    innercards: json['innercards'] == null
        ? null
        : List<InnerCard>.from(
        json['innercards'].map((x) => InnerCard.fromJson(x))),
    result1: json['result1'],
    result2: json['result2'],
    result3: json['result3'],
  );
}


class InnerCard {
  int? id;
  String? innerCardId;
  String? title;
  int? cardOrder;
  bool? isActive;

  InnerCard({
    this.id,
    this.innerCardId,
    this.title,
    this.cardOrder,
    this.isActive,
  });

  factory InnerCard.fromJson(Map<String, dynamic> json) => InnerCard(
    id: json['id'],
    innerCardId: json['innerCardId'],
    title: json['title'],
    cardOrder: json['cardOrder'],
    isActive: json['isActive'],
  );
}
