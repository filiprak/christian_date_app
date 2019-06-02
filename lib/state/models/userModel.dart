
class UserModel {

  String username;
  String name;
  String description;
  String link;
  Map<String, dynamic> avatar;

  UserModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        name = json['name'],
        description = json['description'],
        avatar = json['avatar'],
        link = json['link'];

}