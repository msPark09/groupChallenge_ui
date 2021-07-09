class GoalDto {
  int goalId;
  int now;
  int goal;
  String date;

  GoalDto({
    this.goalId,
    this.now,
    this.goal,
    this.date,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['goalId'] = this.goalId;
    data['now'] = this.now;
    data['goal'] = this.goal;
    data['date'] = this.date;

    return data;
  }

  GoalDto.fromJson(Map<String, dynamic> json) {
    this.goalId = json['goalId'];
    this.now = json['now'];
    this.goal = json['goal'];
    this.date = json['date'];
  }
}
