class TvShow {
  int? id;
  String? channel;
  String? title;
  String? image;
  String? description;
  String? season;
  int? isOngoing;
  String? date;
  String? startTime;
  String? endTime;

  TvShow({
    this.id,
    this.channel,
    this.title,
    this.image,
    this.description,
    this.season,
    this.isOngoing,
    this.date,
    this.startTime,
    this.endTime,
  });

  TvShow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channel = json['channel'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    season = json['season'];
    isOngoing = json['isOngoing'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['channel'] = channel;
    data['image'] = image;
    data['description'] = description;
    data['season'] = season;
    data['isOngoing'] = isOngoing;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }
}
