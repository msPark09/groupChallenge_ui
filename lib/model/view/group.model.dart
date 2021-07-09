import 'dart:convert';

import 'package:argon_flutter/model/base.model.dart';
import 'package:argon_flutter/model/base_handler.dart';
import 'package:argon_flutter/model/dto/group.dto.dart';
import 'package:argon_flutter/service/api.dart';
import 'package:argon_flutter/service/auth.service.dart';
import 'package:flutter/cupertino.dart';

/** 그룹정보 조회 모델 */
class GroupModel extends BaseModel with BaseHandler {
  Api _api;
  AuthService _auth;

  GroupDto groupDto;

  GroupModel({@required Api api, @required AuthService authService})
      : _api = api,
        _auth = authService;

  /**
   * 그룹 조회 - id
   */
  Future<bool> getGroup(id, scaffoldKey, context) async {
    setBusy(true);

    // var response = await _api.getGroup(id);

    // if (response.statusCode != 200) {
    //   handleError2(response, scaffoldKey, context);
    // }

    // if (response.body == null) {
    // handleNoData(scaffoldKey); // snackBar check
    // }

    // groupDto = groupDto.fromJson(json.decode(response.body));

    setBusy(false);
    // return response.statusCode == 200 ? true : false;
  }

  /**
   * 그룹 조회 - 메인화면용
   */
  Future<bool> getMainGroupInfo(scaffoldKey, context) async {
    setBusy(true);

    var userInfo = await _auth.getUserInfo();
    var response = await _api.getMainGroupInfo(userInfo['userId']);

    if (response.statusCode != 200) {
      handleError2(response, scaffoldKey, context);
    }

    if (response.body == null) {
      handleNoData(scaffoldKey); // snackBar check
    }

    groupDto = GroupDto.fromJson(json.decode(response.body));

    setBusy(false);
    return response.statusCode == 200 ? true : false;
  }
}
