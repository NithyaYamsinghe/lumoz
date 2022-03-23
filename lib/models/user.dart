class User{

  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? mobile;
  int? age;

  User({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.mobile,
    this.age
  });

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    mobile = json['mobile'];
    age = json['age'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['comment'] = userName;
    data['tvShowId'] = firstName;
    data['comment'] = lastName;
    data['tvShowId'] = email;
    data['comment'] = password;
    data['tvShowId'] = mobile;
    data['comment'] = age;
    return data;
  }

}