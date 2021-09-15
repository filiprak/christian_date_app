
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

  static String normalizeUrl(String url) {
    return url.contains('https:') ? url : 'https:' + url;
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['user_login'],
        name = json['name'],
        avatar = normalizeUrl(json['avatar_urls']['full']) {

  }

}