class Customer {
  final ApiResponse response;
  String? token;
  List<UserData> data;

  Customer({
    required this.token,
    required this.response,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return data[0].toJson();
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      response: ApiResponse.fromJson(json['response']) ,
      token: json['token'] ?? '',
      data: List<UserData>.from(
        (json['data'] as List<dynamic>? ?? []).map(
              (userData) => UserData.fromJson(userData),
        ),
      ),
    );
  }


}


class ApiResponse {
  final int statusCode;
  final String description;

  ApiResponse({required this.statusCode, required this.description});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      statusCode: json['statusCode'] ?? 0,
      description: json['description'] ?? '',
    );
  }
}


class UserData {
  int id;
  String userId;
  String adminId;
  String name;
  String email;
  String mobileNo;
  String password;
  String address;
  int userType;
  String? mPin;
  String accountBalance;
  int accountStatus;
  int isMobileVerified;
  String paymentId;
  String datetime;

  UserData({
    required this.id,
    required this.userId,
    required this.adminId,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.password,
    required this.address,
    required this.userType,
    required this.mPin,
    required this.accountBalance,
    required this.accountStatus,
    required this.isMobileVerified,
    required this.paymentId,
    required this.datetime,
  });

  Map<String, dynamic> toJson() {
    return {
      "adminId": adminId,
      "name": name,
      "email": email,
      "mobileNo": mobileNo,
      "password": password,
      "address": address,
      "userType": userType,
      "mPin": mPin,
      "accountStatus": accountStatus,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: int.tryParse(json['id'].toString()) ?? 0,
      userId: json['userid'] ?? '',
      adminId: json['adminid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobileNo: json['mobileno'] ?? '',
      password: json['password'] ?? '',
      address: json['address'] ?? '',
      userType: json['usertype'] ?? 0,
      mPin: json['mpin'] ?? '',
      accountBalance: json['accountbalance'] ?? '',
      accountStatus: json['accountstatus'] ?? 0,
      isMobileVerified: json['ismobileverified'] ?? 0,
      paymentId: json['paymentid'] ?? '',
      datetime: json['datetime'] ?? '',
    );
  }
}
