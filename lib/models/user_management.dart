class UserManagement{

  int? id;
  String? text;
  String? image;
  String? link;

  UserManagement({
    this.id,
    this.text,
    this.image,
    this.link,
  });

 UserManagement.fromJson(Map<String, dynamic> json){
    id = json['id'];
    text = json['text'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['text']= text;
    data['image'] = image;
    data['link']= link;
    return data;
  }}