class User {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? mobile;
  String? age;

  User(
      {this.id,
      this.userName,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.mobile,
      this.age});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    mobile = json['mobile'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['mobile'] = mobile;
    data['age'] = age;
    return data;
  }
}
