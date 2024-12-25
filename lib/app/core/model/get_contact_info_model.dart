class ResponseModel {
  final int statusCode;
  final String description;
  final List<ContactData> data;

  ResponseModel({required this.statusCode, required this.description, required this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    var responseData = json['data'] as List<dynamic>? ?? [];
    var contactDataList = responseData.map((dataItem) => ContactData.fromJson(dataItem)).toList();
    return ResponseModel(
      statusCode: json['response']['statusCode'],
      description: json['response']['description'],
      data: contactDataList,
    );
  }
}

class ContactData {
  final int? id;
  final String? adminid;
  final String? mobileno;
  final String? mobileno2;
  final String? landline;
  final String? landline2;
  final String? email;
  final String? email2;
  final String? whatsappno;
  final String? twitter;
  final String? facebook;
  final String? instagram;
  final String? latitude;
  final String? longitude;
  final String? address;
  final String? datetime;
  final bool? alreadyhavedata;

  ContactData({
    this.id,
    this.adminid,
    this.mobileno,
    this.mobileno2,
    this.landline,
    this.landline2,
    this.email,
    this.email2,
    this.whatsappno,
    this.twitter,
    this.facebook,
    this.instagram,
    this.latitude,
    this.longitude,
    this.address,
    this.datetime,
    this.alreadyhavedata,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) {
    return ContactData(
      id: json['id'] ?? 0,
      adminid: json['adminid'] ?? '',
      mobileno: json['mobileno'] ?? '',
      mobileno2: json['mobileno2'] ?? '',
      landline: json['landline'] ?? '',
      landline2: json['landline2'] ?? '',
      email: json['email'] ?? '',
      email2: json['email2'] ?? '',
      whatsappno: json['whatsappno'] ?? '',
      twitter: json['twitter'] ?? '',
      facebook: json['facebook'] ?? '',
      instagram: json['instagram']?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      address: json['address'] ?? '',
      datetime: json['datetime']?? '',
      alreadyhavedata: json['alreadyhavedata'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adminid': adminid,
      'mobileno': mobileno,
      'mobileno2': mobileno2,
      'landline': landline,
      'landline2': landline2,
      'email': email,
      'email2': email2,
      'whatsappno': whatsappno,
      'twitter': twitter,
      'facebook': facebook,
      'instagram': instagram,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'datetime': datetime,
      'alreadyhavedata': alreadyhavedata,
    };
  }
}
