import 'dart:convert';

import 'package:argon_flutter/model/base.model.dart';
import 'package:argon_flutter/model/base_handler.dart';
import 'package:argon_flutter/model/criteria/search-criteria.dart';
import 'package:argon_flutter/model/dto/group.dto.dart';
import 'package:argon_flutter/model/page/page-response.dart';
import 'package:argon_flutter/service/api.dart';
import 'package:argon_flutter/service/auth.service.dart';
import 'package:flutter/cupertino.dart';

/** 그룹정보 조회-다중 모델 */
class GroupListModel extends BaseModel with BaseHandler {
  Api _api;
  AuthService _auth;

  final int PAGE_SIZE = 10;

  // paging 처리 관련
  int totalElements = 0;
  int currentPage = 0;
  int nextPage = 0;
  int pageSize = 10;
  bool first = false;
  bool last = false;

  GroupDto groupDto;
  List<GroupDto> groupList = [];

  GroupListModel({@required Api api, @required AuthService authService})
      : _api = api,
        _auth = authService;

  /** 페이징 초기화 */
  Future<void> initPaging() async {
    totalElements = 0;
    currentPage = 0;
    nextPage = 0;
    pageSize = 10;
    first = false;
    last = false;
  }

  /**
   * 그룹 조회 - 해당 유저의 전체 그룹 조회
   */
  Future<List<GroupDto>> searchGroupList(nextPage, scaffoldKey, context) async {
    setBusy(true);

    this.groupList = [];

    if (nextPage == null) {
      nextPage = 0;
    }

    print('★★★★★ GroupListModel searchGroupList( nextPage:: $nextPage )');
    print('★★★★★ GroupListModel searchGroupList( last:: $last )');

    if (last) {
      handleLastData(scaffoldKey);
      return groupList;
    }

    var criteria = SearchCriteria(nextPage, PAGE_SIZE);
    criteria.userId = (await _auth.getUserInfo())['userId'];

    var response = await _api.searchGroups(criteria);

    if (response.statusCode != 200 && response.statusCode != 404) {
      handleError2(response, scaffoldKey, context);
    }

    if (response.statusCode != 404) {
      var pageResponse = PageResponse.fromJson(json.decode(response.body));

      if (pageResponse == null || pageResponse.totalElements == 0) {
        handleNoData(scaffoldKey);
      } else {
        var parsed = pageResponse.content as List<dynamic>;
        for (var each in parsed) {
          var group = GroupDto.fromJson(each);

          groupList.add(group);
        }

        totalElements = pageResponse.totalElements;
        currentPage = pageResponse.pageable.pageNumber;
        nextPage = pageResponse.pageable.pageNumber + 1;
        first = pageResponse.first;
        last = pageResponse.last;
      }
    }

    setBusy(false);
    return groupList;
  }
}
