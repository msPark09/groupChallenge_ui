import 'package:argon_flutter/model/criteria/base-criteria.dart';

class SearchCriteria extends BaseCriteria {
  int userId; // 사용자 ID
  int searchId;
  String searchText;

  SearchCriteria(currentPage, pageSize) {
    this.currentPage = currentPage;
    this.pageSize = pageSize;
  }

  SearchCriteria.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['currentPage'] = this.currentPage;
    data['pageSize'] = this.pageSize;

    data['userId'] = this.userId;
    data['searchId'] = this.searchId;
    data['searchText'] = this.searchText;
    return data;
  }
}
