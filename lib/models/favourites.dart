class Favourites{

  int? id;
  String? title;

  Favourites({
    this.id,
    this.title,
  });

  Favourites.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    return data;
  }

}