class GameRates {
  final Response response;
  final List<DataItem> data;

  GameRates({required this.response, required this.data});

  factory GameRates.fromJson(Map<String, dynamic> json) {
    return GameRates(
      response: Response.fromJson(json['response']),
      data: List<DataItem>.from(json['data'].map((x) => DataItem.fromJson(x))),
    );
  }
}

class Response {
  final int statusCode;
  final String description;

  Response({required this.statusCode, required this.description});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      statusCode: json['statusCode'],
      description: json['description'],
    );
  }
}

class DataItem {
  final int id;
  final String adminid;
  final int? singledigit1;
  final int? singledigit2;
  final int? jodidigit1;
  final int? jodidigit2;
  final int? singlepanna1;
  final int? singlepanna2;
  final int? doublepanna1;
  final int? doublepanna2;
  final int? triplepanna1;
  final int? triplepanna2;
  final int? halfsangam1;
  final int? halfsangam2;
  final int? fullsangam1;
  final int? fullsangam2;
  final String datetime;

  DataItem({
    required this.id,
    required this.adminid,
    this.singledigit1,
    this.singledigit2,
    this.jodidigit1,
    this.jodidigit2,
    this.singlepanna1,
    this.singlepanna2,
    this.doublepanna1,
    this.doublepanna2,
    this.triplepanna1,
    this.triplepanna2,
    this.halfsangam1,
    this.halfsangam2,
    this.fullsangam1,
    this.fullsangam2,
    required this.datetime,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      id: json['id'],
      adminid: json['adminid'] ?? '',
      singledigit1: json['singledigit1'] ?? 0 ,
      singledigit2: json['singledigit2'] ?? 0 ,
      jodidigit1: json['jodidigit1'] ?? 0 ,
      jodidigit2: json['jodidigit2'] ?? 0 ,
      singlepanna1: json['singlepanna1'] ?? 0 ,
      singlepanna2: json['singlepanna2'] ?? 0 ,
      doublepanna1: json['doublepanna1'] ?? 0 ,
      doublepanna2: json['doublepanna2'] ?? 0 ,
      triplepanna1: json['triplepanna1'] ?? 0 ,
      triplepanna2: json['triplepanna2'] ?? 0 ,
      halfsangam1: json['halfsangam1'] ?? 0 ,
      halfsangam2: json['halfsangam2'] ?? 0 ,
      fullsangam1: json['fullsangam1'] ?? 0 ,
      fullsangam2: json['fullsangam2'] ?? 0 ,
      datetime: json['datetime'] ?? '',
    );
  }
}
