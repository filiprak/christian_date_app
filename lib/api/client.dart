import 'dart:convert';

import 'abstractClient.dart';
import 'package:http/http.dart' as http;

class ApiClient extends AbstractApiClient {
  final String baseUrl = 'http://www.test-chrzescijanskarandka.tk/wp-json';
  String token = '';

  @override
  Future<Map<String, dynamic>> getJwtToken(Map<String, String> credentials) async {

    final response = await http.post(
      baseUrl + '/jwt-auth/v1/token',
      body: credentials,
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      token = decoded['token'];

      return <String, dynamic> {
        'error': false,
        'token': decoded['token'],
        'email': decoded['user_email'],
        'username': decoded['user_nicename'],
        'displayname': decoded['user_display_name'],
      };
    } else {
      return <String, dynamic> {
        'error': true,
        'response': response.body,
      };
    }
  }

  @override
  Future<Map<String, dynamic>> getCurrentUserData() async {

    final response = await http.get(
      baseUrl + '/wp/v2/users/me',
      headers: {
        'Authorization': 'Bearer $token'
      }
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      token = decoded['token'];

      return <String, dynamic> {
        'error': false,
        'name': decoded['name'],
        'username': decoded['slug'],
        'description': decoded['description'],
        'link': decoded['link'],
        'avatar': decoded['avatar_urls'],
      };
    } else {
      return <String, dynamic> {
        'error': true,
        'response': response.body,
      };
    }

  }

}

final api = ApiClient();
