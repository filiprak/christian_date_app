
class UserModel {

  int id;
  String username;
  String name;
  String avatar;

  UserModel() {
    username = '';
    name = '';
    avatar = 'https://via.placeholder.com/48';
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['user_login'],
        name = json['name'],
        avatar = json['avatar_urls']['full'];

}