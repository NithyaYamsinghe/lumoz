class Wishlist{
  int? id;
  String? name;
  String? episodeCount;
  String? tvChanel;
  String? description;

  Wishlist(
      { this.id,
        this.name,
        this.episodeCount,
        this.tvChanel,
        this.description});

  Wishlist.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    episodeCount = json['episodeCount'];
    tvChanel = json['tvChanel'];
    description= json['description'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name']= this.name;
    data['episodeCount'] = this.episodeCount;
    data['tvChanel']=this.tvChanel;
    data['description']= this.description;

    return data;
  }
}

