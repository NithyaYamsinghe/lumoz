class Reminder {
  int? id;
  String? tvShow;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? reminder;
  String? repeat;

  Reminder(
      {this.id,
      this.tvShow,
      this.note,
      this.isCompleted,
      this.date,
      this.startTime,
      this.endTime,
      this.color,
      this.reminder,
      this.repeat});

  Reminder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tvShow = json['tvShow'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    reminder = json['reminder'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tvShow'] = this.tvShow;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['color'] = this.color;
    data['reminder'] = this.reminder;
    data['repeat'] = this.repeat;
    return data;
  }
}
