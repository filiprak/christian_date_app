import 'dart:convert';

import 'abstractClient.dart';
import 'package:http/http.dart' as http;

class ApiClient extends AbstractApiClient {
  final String baseUrl = 'http://www.test-chrzescijanskarandka.tk/wp-json';

  @override
  Future<Map<String, dynamic>> getJwtToken(Map<String, String> credentials) async {

    final response = await http.post(
      baseUrl + '/jwt-auth/v1/token',
      body: credentials,
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

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

}

final client = ApiClient();
