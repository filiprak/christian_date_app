
import 'package:christian_date_app/state/models/profileModel.dart';
import 'package:christian_date_app/state/models/utils.dart';


class UserModel {

  int id;
  String username;
  String name;
  String avatar;
  ProfileModel xProfile;

  UserModel() {
    username = '';
    name = '';
    avatar = 'https://via.placeholder.com/48';
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['user_login'],
        name = json['name'],
        avatar = normalizeUrl(json['avatar_urls']['full']),
        xProfile = ProfileModel.fromJson(json['xprofile']);
}