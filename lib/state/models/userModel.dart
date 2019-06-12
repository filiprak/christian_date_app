
class UserModel {

  int id;
  String username;
  String name;
  String email;
  String description;
  String link;
  String avatar24;
  String avatar48;
  String avatar96;

  UserModel() {
    username = '';
    name = '';
    description = '';
    link = 'http://localhost';
    avatar24 = 'https://via.placeholder.com/24';
    avatar48 = 'https://via.placeholder.com/48';
    avatar96 = 'https://via.placeholder.com/96';
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        name = json['name'],
        id = json['id'],
        description = json['description'],
        avatar24 = json['avatar']['24'],
        avatar48 = json['avatar']['48'],
        avatar96 = json['avatar']['96'],
        link = json['link'];

}