import 'package:argon_flutter/model/dto/attched-file.dto.dart';
import 'package:argon_flutter/model/dto/goal.dto.dart';

class GroupDto {
  int groupId;
  String name; // 그룹명
  String info; // 그룹 정보
  String startDate; // 그룹 시작일 : yyyyMMdd
  String endDate; // 그룹 종료일: yyyyMMdd
  // TODO enum : 월 / 주 / 일
  int jugi; // 그룹 체크주기
  int checkDay; // 그룹 체크일자
  bool isPublic; // 그룹 공개여부
  List<String> rules; // 그룹 규칙
  AttachedFileDto mainPhoto; // 메인사진
  AttachedFileDto backgroundPhoto; // 배경사진
  String invitedCode; // 초대코드
  GoalDto nowGoal; // 해당 그룹 현재 목표값

  GroupDto({
    this.groupId,
    this.name,
    this.info,
    this.startDate,
    this.endDate,
    this.jugi,
    this.checkDay,
    this.isPublic,
    this.rules,
    this.mainPhoto,
    this.backgroundPhoto,
    this.invitedCode,
    this.nowGoal,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['groupId'] = this.groupId;
    data['name'] = this.name;
    data['info'] = this.info;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['jugi'] = this.jugi;
    data['checkDay'] = this.checkDay;
    data['isPublic'] = this.isPublic;
    data['rules'] = this.rules;
    data['mainPhoto'] = this.mainPhoto?.toJson();
    data['backgroundPhoto'] = this.backgroundPhoto?.toJson();
    data['invitedCode'] = this.invitedCode;
    data['nowGoal'] = this.nowGoal?.toJson();

    return data;
  }

  GroupDto.fromJson(Map<String, dynamic> json) {
    this.groupId = json['groupId'];
    this.name = json['name'];
    this.info = json['info'];
    this.startDate = json['startDate'];
    this.endDate = json['endDate'];
    this.jugi = json['jugi'];
    this.checkDay = json['checkDay'];
    this.isPublic = json['isPublic'];
    this.rules = json['rules'];
    this.mainPhoto = AttachedFileDto.fromJson(json['mainPhoto']);
    this.backgroundPhoto = AttachedFileDto.fromJson(json['backgroundPhoto']);
    this.invitedCode = json['invitedCode'];
    this.nowGoal = GoalDto.fromJson(json['nowGoal']);
  }
}
