import 'dart:convert';
import 'dart:io';

import 'package:argon_flutter/constants/app_constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomResponses {
  static Response timeOut() {
    print('★★★★★ TimeOut Error!!');
    return Response(json.encode({'Error': 'TimeOut'}), HttpStatus.TimeOut);
  }

  static Response noNetwork() {
    print('★★★★★ Network not connected !!');
    return Response(json.encode({'Error': 'NoNetwork'}), HttpStatus.TimeOut);
  }
}

class HttpHelper {
  //static const endpoint = 'https://onestop.kpmsweb.com/krone'; // 운영서버
  //static const endpoint = 'http://152.149.199.96:28080/krone'; // 개발서버 (96)
  static const endpoint = 'http://152.149.200.63:3000'; // 로컬환경

  static const headers = {
    HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8',
    HttpHeaders.acceptHeader: 'application/json;charset=UTF-8'
  };

  // jwt token 적용한 http headers 반환
  Future _getHeaderWithJwt() async {
    var token = await _getToken();
    return {
      HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json;charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
  }

  // login 시 사용 (without token)
  Future<Response> loginPost(url, body) async {
    if (!await _checkConnectivity()) {
      return Future.value(CustomResponses.noNetwork());
    }

    return await post(url, headers: headers, body: body).timeout(
        const Duration(seconds: AppSettings.TimeOutDuration), onTimeout: () {
      return Future.value(CustomResponses.timeOut());
    });
  }

  // ===== Basic ========================================
  // with token
  // ====================================================
  // get (with http headers - content-type, auth)
  Future<Response> httpGet(url) async {
    if (!await _checkConnectivity()) {
      return Future.value(CustomResponses.noNetwork());
    }

    var authHeaders = await _getHeaderWithJwt();
    return await get(url, headers: authHeaders).timeout(
        const Duration(seconds: AppSettings.TimeOutDuration), onTimeout: () {
      return Future.value(CustomResponses.timeOut());
    });
  }

  // post (with http headers - content-type, auth)
  Future<Response> httpPost(url, body) async {
    if (!await _checkConnectivity()) {
      return Future.value(CustomResponses.noNetwork());
    }

    var authHeaders = await _getHeaderWithJwt();
    return await post(url, headers: authHeaders, body: body).timeout(
        const Duration(seconds: AppSettings.TimeOutDuration), onTimeout: () {
      return Future.value(CustomResponses.timeOut());
    });
  }

  // put (with http headers - content-type, auth)
  Future<Response> httpPut(url, body) async {
    if (!await _checkConnectivity()) {
      return Future.value(CustomResponses.noNetwork());
    }

    var authHeaders = await _getHeaderWithJwt();
    return await put(url, headers: authHeaders, body: body).timeout(
        const Duration(seconds: AppSettings.TimeOutDuration), onTimeout: () {
      return Future.value(CustomResponses.timeOut());
    });
  }

  // delete (with http headers - content-type, auth)
  Future<Response> httpDelete(url) async {
    if (!await _checkConnectivity()) {
      return Future.value(CustomResponses.noNetwork());
    }

    var authHeaders = await _getHeaderWithJwt();
    return await delete(url, headers: authHeaders).timeout(
        const Duration(seconds: AppSettings.TimeOutDuration), onTimeout: () {
      return Future.value(CustomResponses.timeOut());
    });
  }
  // ===== Basic ========================================

  // ===== File =========================================
  // with token
  // ====================================================
  // get (with http headers - content-type, auth)
  Future<HttpClientResponse> httpFileGet(url) async {
    if (!await _checkConnectivity()) {
      var res = CustomResponses.noNetwork() as HttpClientResponse;
      return Future.value(res);
    }

    var token = await _getToken();
    var request = await HttpClient().getUrl(Uri.parse(url));
    request.headers.add(HttpHeaders.authorizationHeader, 'Bearer $token');
    request.headers.add(HttpHeaders.acceptHeader, '*/*');
    return await request.close();
  }

  // file upload (with http headers - content-type, auth)
  Future<Response> httpUpload(url, Map fields, multipartFile) async {
    if (!await _checkConnectivity()) {
      return Future.value(CustomResponses.noNetwork());
    }

    var authHeaders = await _getHeaderWithJwt();
    var uri = Uri.parse(url);
    var request = new MultipartRequest("POST", uri);
    request.files.add(multipartFile);
    request.fields.addAll(fields);
    request.headers.addAll(authHeaders);

    var streamResponse = await request.send();

    return await Response.fromStream(streamResponse).timeout(
        const Duration(seconds: AppSettings.TimeOutDuration), onTimeout: () {
      return Future.value(CustomResponses.timeOut());
    });
  }
  // ===== File =========================================

  // ===== SharedPreferences ===========================
  // SharedPreferences(저장소) 토큰 저장
  // ====================================================
  // jwt 토큰 얻기
  Future _getToken() async {
    // shared preferences 인스턴스
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token'); // access_token(jwt) 얻음
    //print ('★★★★★ BaseHttp token => $token');
    return token;
  }

  // jwt 토큰 얻기
  Future<String> getToken() async {
    // shared preferences 에 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    return token;
  }
  // ===== SharedPreferences ===========================

  // ===== _checkConnectivity ===========================
  // 연결상태 체크
  // ====================================================
  Future<bool> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      //print('★★★★★ mobile network connected');
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      //print('★★★★★ wifi network connected');
      return true;
    } else {
      //print('★★★★★ network connected???? ${connectivityResult.toString()}');
      return false;
    }
  }
  // ===== _checkConnectivity ===========================
}
