import 'dart:async';

import 'package:argon_flutter/constants/app_constants.dart';
import 'package:argon_flutter/model/base.model.dart';
import 'package:argon_flutter/model/base_handler.dart';
import 'package:argon_flutter/model/dto/user_info.dto.dart';
import 'package:argon_flutter/service/auth.service.dart';
import 'package:argon_flutter/service/helper/jwt.helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class AuthModel extends BaseModel with BaseHandler {
  final JwtHelper _jwt;
  final AuthService _auth;

  AuthModel({@required JwtHelper jwtHelper, @required AuthService authService})
      : _jwt = jwtHelper,
        _auth = authService;

  String username; // 사용자 ID
  bool isLoggedIn = false;

/** 
 * 유효한 로그인 상태인지 확인
*/
  Future<void> loggedIn(context, scaffoldKey) async {
    // 화면을 바로 draw한 후
    // 유효한 로그인 상태인지 확인한다.
    setBusy(true);
    var token = await _auth.getToken();
    print('★★★★★ AuthModel prefs token => $token');
    String path = RoutePaths.Login;

    if (token != null && !_jwt.expired(token)) {
      Response response = await _auth.authenticate(); // 유효한 token 서버 인증
      if (response.statusCode == 200) {
        path = RoutePaths.Profile;
      }
    }

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(path, (Route<dynamic> route) => false);
    });

    if (token != null && !_jwt.expired(token)) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }

    setBusy(false);
  }

/**
 * 로그인 후 유저내용 가져오기
 */
  Future<void> loadUsernameAndExtraInfo(scaffoldKey) async {
    setBusy(true);

    // 로그인화면으로 이동했으므로 token이 저장되어 있다면 clear처리함.
    await _auth.clearToken();

    var userInfo = await _auth.getUserInfo();
    username = userInfo['name'];

    setBusy(false);
  }

/**
 * 로그인
 */
  Future<bool> login(
      String emailText, String passwordText, scaffoldKey, context) async {
    setBusy(true);

    var loginUser = UserInfoDto();

    loginUser.userId = emailText;
    loginUser.password = passwordText;

    print('>>>>> ${loginUser.toJson()}');

    // var response = await _auth.login(loginUser);
    // var checkResult = false;

    // if (response.statusCode == 200) {
    //   var fetched = json.decode(response.body);
    //   var loginResponse = LoginResponse.fromJson(fetched);

    //   if (loginResponse.isSuccess == true) {
    //     checkResult = true;

    //     _auth.storeToken(loginResponse.token);
    //     _auth.storeUsername(username);
    //     var parsed = _jwt.parseJwt(loginResponse.token);
    //     _auth.storeUserInfo(parsed);

    //     var res = await _auth.findFcmToken(loginUser);
    //     var fcmToken = res.body;

    //     _auth.storeFcmToken(fcmToken);
    //   } else {
    //     checkResult = false;

    //     _auth.clearToken();
    //     handleError4Login(response, scaffoldKey, loginResponse.loginCheckFlag);
    //   }
    // } else {
    //   checkResult = false;

    //   _auth.clearToken();
    //   handleError4Login(response, scaffoldKey);
    // }

    setBusy(false);
    return true;
    // return (response.statusCode == 200 && checkResult == true) ? true : false;
  }
}
