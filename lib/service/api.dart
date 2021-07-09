import 'dart:convert';

import 'package:argon_flutter/model/criteria/search-criteria.dart';
import 'package:argon_flutter/model/dto/user_info.dto.dart';
import 'package:argon_flutter/service/helper/http.helper.dart';
import 'package:http/http.dart';

class Api extends HttpHelper {
  // 인증 확인용 api - splash
  Future<Response> authenticate() async {
    var url = '${HttpHelper.endpoint}/api/authenticate';

    return await httpGet(url);
  }

  // get fcm token
  Future<Response> findFcmToken(String userid) async {
    var url = '${HttpHelper.endpoint}/api/v1/fcm/$userid';

    return await httpGet(url);
  }

  // fcm token update
  Future<Response> updateFcmToken(UserInfoDto loginUser) async {
    var url = '${HttpHelper.endpoint}/api/v1/fcm';
    var body = json.encode(loginUser.toJson());

    return await httpPut(url, body);
  }

  // 로그인 처리
  // jwt를 포함한 Token 반환
  Future<Response> login(UserInfoDto loginUser) async {
    var url = '${HttpHelper.endpoint}/api/v1/login';
    var body = json.encode(loginUser.toJson());

    return await loginPost(url, body);
  }

  // 유저 프로필 조회
  Future<Response> getUserProfile(String userId) async {
    var url = '${HttpHelper.endpoint}/api/v1/users/$userId';

    // 신규 등록
    return await httpGet(url);
  }

  Future<Response> saveUser(UserInfoDto userInfoDto) async {
    var url = '${HttpHelper.endpoint}/api/v1/users';
    var body = json.encode(userInfoDto.toJson());

    // 신규 등록
    return await httpPost(url, body);
  }

  // 메인화면에 표시할 메인 그룹 상태
  Future<Response> getMainGroupInfo(int userId) async {
    var url = '${HttpHelper.endpoint}/api/v1/groups/main/$userId';

    return await httpGet(url);
  }

  Future<Response> searchGroups(SearchCriteria criteria) async {
    var url = '${HttpHelper.endpoint}/api/v1/groups/search-page';
    var body = json.encode(criteria.toJson());

    // 신규 등록
    return await httpPost(url, body);
  }
}
