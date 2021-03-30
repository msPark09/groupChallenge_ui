class LoginResponse {
  String token;
  String loginCheckFlag;
  bool isSuccess;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    loginCheckFlag = json['loginCheckFlag'];
    isSuccess = json['isSuccess'];
  }
}
