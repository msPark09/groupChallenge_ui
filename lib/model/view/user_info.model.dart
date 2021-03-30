import 'package:argon_flutter/model/base.model.dart';
import 'package:argon_flutter/model/base_handler.dart';
import 'package:argon_flutter/model/dto/user_info.dto.dart';
import 'package:argon_flutter/service/api.dart';
import 'package:argon_flutter/service/auth.service.dart';
import 'package:argon_flutter/service/helper/jwt.helper.dart';
import 'package:flutter/cupertino.dart';

class UserInfoModel extends BaseModel with BaseHandler {
  Api _api;
  AuthService _auth;
  JwtHelper _jwtHelper;

  UserInfoDto userInfoDto;

  UserInfoModel(
      {@required Api api,
      @required AuthService authService,
      @required JwtHelper jwtHelper})
      : _api = api,
        _auth = authService,
        _jwtHelper = jwtHelper;

  Future<void> loadUserInfo(scaffoldKey) async {
    setBusy(true);

    // userInfo 있다면 셋팅
    var userInfo = await _auth.getUserInfo();

    this.userInfoDto = UserInfoDto.fromJson(userInfo);
    this.userInfoDto = new UserInfoDto(
      userId: 'bubyabya',
      userName: 'userName',
    );

    setBusy(false);
  }
}
