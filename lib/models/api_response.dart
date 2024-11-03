class ApiResponse<T> {
  num? errorCode;
  String? errorMsg;
  T? data;

  ApiResponse({
    this.errorCode,
    this.errorMsg,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, Function(dynamic) fromJsonT) {
    return ApiResponse(
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
      data: fromJsonT(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['errorCode'] = errorCode;
    map['errorMsg'] = errorMsg;
    return map;
  }
}
