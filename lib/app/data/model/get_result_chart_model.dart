class ChartResponseModel {
  final int statusCode;
  final String description;
  final List<CardHistory> data;

  ChartResponseModel({required this.statusCode, required this.description, required this.data});

  factory ChartResponseModel.fromJson(Map<String, dynamic> json) {
    var responseData = json['data'] as List<dynamic>? ?? [];
    var contactDataList = responseData.map((dataItem) => CardHistory.fromJson(dataItem)).toList();
    return ChartResponseModel(
      statusCode: json['response']['statusCode'],
      description: json['response']['description'],
      data: contactDataList,
    );
  }
}


class CardHistory {
  final int? id;
  final String? resultId;
  final String? cardId;
  final String? adminId;
  final int? result1;
  final int? result2;
  final int? result3;
  final DateTime? datetime;

  CardHistory({
     this.id,
     this.resultId,
     this.cardId,
     this.adminId,
    this.result1,
    this.result2,
    this.result3,
     this.datetime,
  });

  factory CardHistory.fromJson(Map<String, dynamic> json) {
    return CardHistory(
      id: json['id'] ?? 0,
      resultId: json['resultid'] ?? '',
      cardId: json['cardid'] ?? '',
      adminId: json['adminid'] ?? '',
      result1: json['result1'] != null ? int.tryParse(json['result1'].toString()) : null,
      result2: json['result2'] != null ? int.tryParse(json['result2'].toString()) : null,
      result3: json['result3'] != null ? int.tryParse(json['result3'].toString()) : null,
      datetime: json['datetime'] != null ? DateTime.parse(json['datetime']) : null,
    );
  }


}
