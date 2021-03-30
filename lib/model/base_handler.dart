import 'dart:convert';

import 'package:argon_flutter/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

abstract class BaseHandler {
  // mixin 용도, 직접 상속 방지
  factory BaseHandler._() => null;

  // 주의 : 로그인 화면에서만 사용함. 이외 화면에서 절대 사용 금지
  void handleError4Login(Response response, scaffoldKey, [loginCheckFlag]) {
    print('★★★★★ handleError status code => ${response.statusCode}');
    var errorMsg = '';
    if (response.statusCode == HttpStatus.UnAuthorized) {
      errorMsg = '자격증명에 실패했습니다';
    } else if (response.statusCode == HttpStatus.NotFound) {
      errorMsg = 'Page Not Found(404)';
    } else if (response.statusCode == HttpStatus.TimeOut) {
      errorMsg = '서버 응답 지연 [관리자문의]';
      var parsed = json.decode(response.body);
      var errorCode = parsed['Error'];
      //print('★★★★★ $errorCode');
      if (errorCode == 'NoNetwork') {
        errorMsg = '네트워크 연결을 확인해 주십시오.';
      }
    } else if (response.statusCode == HttpStatus.ServerError) {
      errorMsg = '시스템 오류 발생 [관리자문의]';
    } else {
      errorMsg = '서비스 요청 실패 [관리자문의]';
    }

    if (loginCheckFlag == 'DEVICE_DUP') {
      errorMsg = '기기 중복 등록 오류 [관리자문의]';
    }

    if (loginCheckFlag == 'INVALID_VERSION') {
      errorMsg = '최신 버전으로 앱을 업테이트 해 주십시오';
    }

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(errorMsg),
      duration: Duration(seconds: AppSettings.SnackBarDuration),
    );

    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void handleError2(Response response, scaffoldKey, context) {
    print('★★★★★ handleError status code => ${response.statusCode}');
    var errorMsg = '';
    if (response.statusCode == HttpStatus.UnAuthorized) {
      errorMsg = '자격증명에 실패했습니다';
      Navigator.of(context).pushNamed(RoutePaths.Login);
    } else if (response.statusCode == HttpStatus.NotFound) {
      errorMsg = 'Page Not Found(404)';
    } else if (response.statusCode == HttpStatus.TimeOut) {
      errorMsg = '서버 응답 지연 [관리자문의]';
      var parsed = json.decode(response.body);
      var errorCode = parsed['Error'];
      //print('★★★★★ $errorCode');
      if (errorCode == 'NoNetwork') {
        errorMsg = '네트워크 연결을 확인해 주십시오.';
      }
    } else if (response.statusCode == HttpStatus.ServerError) {
      errorMsg = '시스템 오류 발생 [관리자문의]';
    } else {
      var kroneAlert = response.headers['x-krone-app-alert'];
      errorMsg = '서비스 요청 실패($kroneAlert) [관리자문의]';
    }

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(errorMsg),
      duration: Duration(milliseconds: AppSettings.SnackBarDurationMil),
    );

    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void handleSuccess(Response response, scaffoldKey) {
    print('★★★★★ handleSuccess status code => ${response.statusCode}');
    var successMsg = '저장 성공';

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(successMsg),
      duration: Duration(milliseconds: AppSettings.SnackBarDurationMil),
    );

    scaffoldKey.currentState.showSnackBar(snackBar);
    return;
  }

  void handleNoData(scaffoldKey) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text('조회 데이터 없음'),
      duration: Duration(milliseconds: AppSettings.SnackBarDurationMil),
    );

    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void handleLastData(scaffoldKey) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text('전체 데이터 조회 완료'),
      duration: Duration(milliseconds: AppSettings.SnackBarDurationMil),
    );

    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
