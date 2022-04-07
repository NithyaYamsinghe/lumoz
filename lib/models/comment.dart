class Comment {
  int? id;
  String? comment;
  int? tvShowId;

  Comment({this.id, this.comment, this.tvShowId});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    tvShowId = json['tvShowId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['comment'] = comment;
    data['tvShowId'] = tvShowId;
    return data;
  }
}
