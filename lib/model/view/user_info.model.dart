import 'dart:convert';

import 'package:argon_flutter/model/base.model.dart';
import 'package:argon_flutter/model/base_handler.dart';
import 'package:argon_flutter/model/dto/user_info.dto.dart';
import 'package:argon_flutter/service/api.dart';
import 'package:argon_flutter/service/auth.service.dart';
import 'package:argon_flutter/service/helper/jwt.helper.dart';
import 'package:argon_flutter/util/validation-util.dart';
import 'package:flutter/cupertino.dart';

class UserInfoModel extends BaseModel with BaseHandler {
  Api _api;
  AuthService _auth;
  JwtHelper _jwt;

  UserInfoDto userInfoDto;

  String jwtToken;

  UserInfoModel(
      {@required Api api,
      @required AuthService authService,
      @required JwtHelper jwtHelper})
      : _api = api,
        _auth = authService,
        _jwt = jwtHelper;

// Future<void> loadUsernameAndExtraInfo(scaffoldKey) async {
//     setBusy(true);

//     // 기기정보
//     device = await _device.getDeviceInfo();

//     // 패키지(앱) 정보
//     package = await _package.getPackageInfo();

//     // 로그인화면으로 이동했으므로 token이 저장되어 있다면 clear처리함.
//     await _auth.clearToken();

//     username = await _auth.getUsername();

//     setBusy(false);
//   }

  Future<bool> login(
      String email, String password, scaffoldKey, context) async {
    setBusy(true);

    userInfoDto = new UserInfoDto(email: email, password: password);

    var response = await _auth.login(userInfoDto);
    var checkResult = false;

    if (response.statusCode == 200) {
      var result = json.decode(response.body);

      // 로그인 성공
      if (result.isSuccess == true) {
        checkResult = true;

        // token 내용 저장
        _auth.storeToken(result.token);
        var parsed = _jwt.parseJwt(result.token);
        _auth.storeUserInfo(parsed);

        var res = await _auth.findFcmToken(userInfoDto);
        var fcmToken = res.body;

        _auth.storeFcmToken(fcmToken);
      } else {
        // 로그인 실패
        checkResult = false;
        print('★★★★★ loginCheckFlag => ${result.loginCheckFlag}');

        _auth.clearToken();
        handleError4Login(response, scaffoldKey, result.loginCheckFlag);
      }
    } else {
      checkResult = false;

      _auth.clearToken();
      handleError4Login(response, scaffoldKey);
    }

    setBusy(false);
    return (response.statusCode == 200 && checkResult == true) ? true : false;
  }

/**
 * 유저정보 로드 - 기본storge에 저장된것
 */
  Future<void> loadUserInfo(scaffoldKey) async {
    setBusy(true);

    this.jwtToken = await _auth.getToken();

    // userInfo 있다면 셋팅
    var userInfo = await _auth.getUserInfo();

    this.userInfoDto = UserInfoDto.fromJson(userInfo);

    setBusy(false);
  }

/**
 * 유저정보 로드 - 프로필 정보 로드
 */
  Future<bool> loadUserProfile(scaffoldKey, context) async {
    setBusy(true);

    this.jwtToken = await _auth.getToken();

    // userInfo 있다면 셋팅
    var userInfo = await _auth.getUserInfo();

// TODO
    // var response = await _api.getUserProfile(userInfo['userId']);

    // if (response.statusCode != 200) {
    //   handleError2(response, scaffoldKey, context);
    // }

    // if (response.body == null) {
    // handleNoData(scaffoldKey); // snackBar check
    // }

    // userInfoDto = UserInfoDto.fromJson(json.decode(response.body));
    userInfoDto = new UserInfoDto();

    setBusy(false);
    // return response.statusCode == 200 ? true : false;
    return true;
  }

  String errorEmailText;
  String errorPasswordText;
  String errorUsernameText;

/**
 * 입력내용 확인 
 */
  Future<bool> validate() async {
    setBusy(true);

    int errorCount = 0;

    if (userInfoDto.email != null && userInfoDto.email.isNotEmpty) {
      if (!ValidationUtil.isEmail(userInfoDto.email)) {
        errorEmailText = 'e-mail 형식이 아닙니다.';
        errorCount++;
      } else {
        errorEmailText = null;
      }
    } else {
      errorEmailText = 'e-mail 입력';
      errorCount++;
    }

    if (userInfoDto.password != null && userInfoDto.password.isNotEmpty) {
      errorPasswordText = null;
    } else {
      errorPasswordText = '비밀번호 입력';
      errorCount++;
    }

    if (userInfoDto.userName != null && userInfoDto.userName.isNotEmpty) {
      errorUsernameText = null;
    } else {
      errorUsernameText = '이름 입력';
      errorCount++;
    }

    setBusy(false);
    return errorCount == 0 ? true : false;
  }

/**
 * 유저저장(회원가입)
 */
  Future<bool> saveUser(scaffoldKey, context) async {
    setBusy(true);

    var response = await _api.saveUser(userInfoDto);

    if (response.statusCode != 200) {
      handleError2(response, scaffoldKey, context);
    } else {
      handleSuccess(response, scaffoldKey);
    }

    if (response.body == null) {
      handleNoData(scaffoldKey);
    }

    setBusy(false);
    return (response.statusCode == 200 && response.body != null) ? true : false;
  }
}
