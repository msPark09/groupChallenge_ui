class UserInfoDto {
  String userId;
  String password;

  String userName;
  int currentWight;
  int goalWight;

  // TODO
  // group

  String fcmToken;

  UserInfoDto(
      {this.userId,
      this.password,
      this.userName,
      this.currentWight,
      this.goalWight,
      this.fcmToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['password'] = this.password;
    data['userName'] = this.userName;
    data['currentWight'] = this.currentWight;
    data['goalWight'] = this.goalWight;
    data['fcmToken'] = this.fcmToken;

    return data;
  }

  UserInfoDto.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    password = json['password'];
    userName = json['userName'];
    currentWight = json['currentWight'];
    goalWight = json['goalWight'];
    fcmToken = json['fcmToken'];
  }
}
