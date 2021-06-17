class ApiResponseModel {
  String message;
  String error;
  bool isSent;
  String token;
  ApiResponseModel({this.message, this.error, this.isSent, this.token});

  ApiResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    isSent = json['isSent'];
    token = json['token'];
  }
}
