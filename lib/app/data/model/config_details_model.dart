class ConfigDetails {
  String? accountholdername;
  String? accountnumber;
  String? ifsccode;
  String? upiid;
  String? applink;  // Nullable fields
  String? appmsg;
  double? mindeposit;
  double? maxdeposit;
  double? minwithdraw;
  double? maxwithdraw;
  double? minbidamount;
  double? maxbidamount;
  String? starttime;
  String? endtime;
  bool has_admin_config;
  bool has_app_config;
  bool has_amount_config;

  ConfigDetails({
     this.accountholdername,
     this.accountnumber,
     this.ifsccode,
     this.upiid,
    this.applink,
    this.appmsg,
    this.mindeposit,
    this.maxdeposit,
    this.minwithdraw,
    this.maxwithdraw,
    this.minbidamount,
    this.maxbidamount,
    this.starttime,
    this.endtime,
    required this.has_admin_config,
    required this.has_app_config,
    required this.has_amount_config,
  });

  factory ConfigDetails.fromJson(Map<String, dynamic> json) => ConfigDetails(
    accountholdername: json['data'].isNotEmpty ? json['data'][0]['accountholdername'] ?? '' : '',
    accountnumber: json['data'].isNotEmpty ? json['data'][0]['accountnumber']?? '' : '',
    ifsccode: json['data'].isNotEmpty ? json['data'][0]['ifsccode'] ?? '' : '',
    upiid: json['data'].isNotEmpty ?json['data'][0]['upiid'] ?? '' : '',
    applink: json['data'].isNotEmpty ? json['data'][0]['applink'] ?? '' : '',
    appmsg: json['data'].isNotEmpty ? json['data'][0]['appmsg']?? '' : '',
    starttime: json['data'].isNotEmpty ?json['data'][0]['starttime']?? '' : '',
    endtime: json['data'].isNotEmpty ? json['data'][0]['endtime']?? '' : '',
    mindeposit: json['data'].isNotEmpty ? json['data'][0]['mindeposit']?.toDouble() : 0,
    maxdeposit: json['data'].isNotEmpty ? json['data'][0]['maxdeposit']?.toDouble() : 0,
    minwithdraw: json['data'].isNotEmpty ? json['data'][0]['minwithdraw']?.toDouble() : 0,
    maxwithdraw: json['data'].isNotEmpty ? json['data'][0]['maxwithdraw']?.toDouble() : 0,
    minbidamount: json['data'].isNotEmpty ? json['data'][0]['minbidamount']?.toDouble() : 0,
    maxbidamount: json['data'].isNotEmpty ?json['data'][0]['maxbidamount']?.toDouble() : 0,
    has_admin_config: json['data'].isNotEmpty ? json['data'][0]['has_admin_config'] ?? false : false,
    has_app_config: json['data'].isNotEmpty ? json['data'][0]['has_app_config'] ?? false : false,
    has_amount_config: json['data'].isNotEmpty ? json['data'][0]['has_amount_config'] ?? false : false,
  );

  Map<String, dynamic> toJson() => {
    'accountholdername': accountholdername,
    'accountnumber': accountnumber,
    'ifsccode': ifsccode,
    'upiid': upiid,
    'applink': applink,
    'appmsg': appmsg,
    'mindeposit': mindeposit,
    'maxdeposit': maxdeposit,
    'minwithdraw': minwithdraw,
    'maxwithdraw': maxwithdraw,
    'minbidamount': minbidamount,
    'maxbidamount': maxbidamount,
    'starttime': starttime,
    'endtime': endtime,
    'has_admin_config': has_admin_config,
    'has_app_config': has_app_config,
    'has_amount_config': has_amount_config,
  };
}
