import 'package:argon_flutter/model/dto/user_info.dto.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class AuthService {
  // final field
  final Api _api;

  // 생성자
  AuthService({Api api}) : _api = api;

  // login
  Future<Response> login(UserInfoDto loginUser) async {
    var response = await _api.login(loginUser);
    return response;
  }

  // authenticate 인증 확인
  Future<Response> authenticate() async {
    var response = await _api.authenticate();
    return response;
  }

  Future<Response> findFcmToken(UserInfoDto loginUser) async {
    var response = await _api.findFcmToken(loginUser.userId);
    return response;
  }

  // fcm token 등록
  Future<Response> updateFcmToken(UserInfoDto loginUser) async {
    var response = await _api.updateFcmToken(loginUser);
    return response;
  }

  // store jwt token
  Future<void> storeToken(String token) async {
    // shared preferences 에 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  // clear jwt token
  Future<void> clearToken() async {
    // shared preferences 에 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', null);
  }

  // get jwt token
  Future<String> getToken() async {
    // shared preferences 값을 읽어온다.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // store FCM token
  Future<void> storeFcmToken(String fcmToken) async {
    // shared preferences 에 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', fcmToken);
  }

  // get FCM token
  Future<String> getFcmToken() async {
    // shared preferences 값을 읽어온다.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcm_token');
  }

  // store UserInfo (username, name, auth ...)
  Future<void> storeUserInfo(Map<String, dynamic> payLoad) async {
    print('★★★★★ token PayLoad => ${payLoad.toString()}');

    // shared preferences 에 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('id', payLoad['userId']); // 사용자ID
    await prefs.setString('email', payLoad['email']); // 사용자ID
    await prefs.setString('name', payLoad['name']); // 사용자명
  }

  // store UserInfo (username, name, auth ...)
  Future<Map<String, dynamic>> getUserInfo() async {
    var userInfoMap = Map<String, dynamic>();

    // shared preferences 에 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userInfoMap.putIfAbsent('userId', () => prefs.getString('id'));
    userInfoMap.putIfAbsent('email', () => prefs.getString('email'));
    userInfoMap.putIfAbsent('name', () => prefs.getString('name'));

    print('★★★★★ userInfoMap => ${userInfoMap.toString()}');
    return userInfoMap;
  }
}
