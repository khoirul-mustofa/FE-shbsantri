class UserModel {
  String? name;
  String? email;
  String? avatar;

  UserModel({this.name, this.email, this.avatar});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['avatar'] = avatar;
    return data;
  }
}
