class AttachedFileDto {
  int fileId; // 파일ID
  String logicalFileName; // 파일명
  var fileSize; // 파일크기
  bool isExist;
  String title; // 파일 타이틀
  String remark; // 메모

  AttachedFileDto(
      {this.fileId,
      this.logicalFileName,
      this.fileSize,
      this.isExist,
      this.title,
      this.remark});

  AttachedFileDto.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      fileId = json['fileId'];
      logicalFileName = json['logicalFileName'];
      fileSize = json['fileSize'];
      isExist = json['fileId'] != null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileId'] = this.fileId;
    data['logicalFileName'] = this.logicalFileName;
    data['fileSize'] = this.fileSize;
    data['isExist'] = this.isExist;

    return data;
  }
}
