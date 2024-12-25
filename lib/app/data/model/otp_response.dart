class OtpResponse {
  int? statusCode;
  String? description;
  TwoFactorResponse? twoFactorResponse;
  ErrorResponse? error;

  OtpResponse({
    required this.statusCode,
    required this.description,
    this.twoFactorResponse,
    this.error,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      statusCode: json['statusCode'] ?? 0,
      description: json['description'] ?? '',
      twoFactorResponse: json.containsKey('2factorResponse')
          ? TwoFactorResponse.fromJson(json['2factorResponse'])
          : null,
      error: json.containsKey('error') ? ErrorResponse.fromJson(json['error']) : null,
    );
  }

}

class TwoFactorResponse {
  String status;
  String details;

  TwoFactorResponse({
    required this.status,
    required this.details,
  });

  factory TwoFactorResponse.fromJson(Map<String, dynamic> json) {
    return TwoFactorResponse(
      status: json['Status'],
      details: json['Details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Details': details,
    };
  }
}

class ErrorResponse {
  String error;

  ErrorResponse({
    required this.error,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
    };
  }
}
