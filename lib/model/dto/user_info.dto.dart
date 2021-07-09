import 'package:argon_flutter/model/dto/attched-file.dto.dart';

class UserInfoDto {
  String userId;
  String userName;
  String password;
  String email;
  String sayWord; // 한마디
  AttachedFileDto profileImageUrl; // 프로필이미지 파일

  String fcmToken;

  UserInfoDto(
      {this.userId,
      this.userName,
      this.password,
      this.email,
      this.sayWord,
      this.fcmToken,
      this.profileImageUrl});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['sayWord'] = this.sayWord;
    data['fcmToken'] = this.fcmToken;
    data['profileImageUrl'] =
        this.profileImageUrl != null ? this.profileImageUrl.toJson() : null;

    return data;
  }

  UserInfoDto.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    password = json['password'];
    email = json['email'];
    sayWord = json['sayWord'];
    fcmToken = json['fcmToken'];
    profileImageUrl = AttachedFileDto.fromJson(json['profileImageUrl']);
  }
}
