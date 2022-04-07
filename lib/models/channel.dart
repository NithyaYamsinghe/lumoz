class Channel {
  int? id;
  String? channel;
  String? image;
  String? description;

  Channel({
    this.id,
    this.channel,
    this.image,
    this.description,
  });

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channel = json['channel'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['channel'] = channel;
    data['image'] = image;
    data['description'] = description;
    return data;
  }
}
