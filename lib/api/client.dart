import 'dart:convert';

import 'package:christian_date_app/state/models/activityModel.dart';
import 'package:christian_date_app/state/models/privateMessageModel.dart';
import 'package:christian_date_app/state/models/threadModel.dart';

import 'abstractClient.dart';
import 'package:http/http.dart' as http;

class ApiClient extends AbstractApiClient {
  final String baseUrl = 'www.test-chrzescijanskarandka.tk';
  String token = '';

  @override
  Future<Map<String, dynamic>> getJwtToken(Map<String, String> credentials) async {

    final response = await http.post(
      Uri.http(baseUrl, '/wp-json/jwt-auth/v1/token'),
      body: credentials,
    );

    print(response.body);

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
      Uri.http(baseUrl, '/wp-json/wp/v2/users/me'),
      headers: {
        'Authorization': 'Bearer $token'
      }
    );

    print(response.body);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

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

  @override
  Future<Map<String, dynamic>> getActivities(Map<String, String> query) async {
    final response = await http.get(
        Uri.http(baseUrl, '/wp-json/mobile/v1/activities', query),
        headers: {
          'Authorization': 'Bearer $token'
        },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      List<dynamic> activities = decoded['items'] as List;

      return <String, dynamic> {
        'error': false,
        'activities': activities.map((activity) => ActivityModel.fromJson(activity)).toList(),
      };
    } else {
      return <String, dynamic> {
        'error': true,
        'response': response.body,
      };
    }
  }

  @override
  Future<Map<String, dynamic>> createActivity(String content) async {
    final response = await http.post(
      Uri.http(baseUrl, '/wp-json/mobile/v1/activities'),
      body: {
        'content': content
      },
      headers: {
        'Authorization': 'Bearer $token'
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      return <String, dynamic> {
        'error': false,
        'activity': decoded,
      };
    } else {
      return <String, dynamic> {
        'error': true,
        'response': response.body,
      };
    }
  }

  @override
  Future<Map<String, dynamic>> getMessageThreads(Map<String, String> query) async {
    final response = await http.get(
      Uri.http(baseUrl, '/wp-json/mobile/v1/threads', query),
      headers: {
        'Authorization': 'Bearer $token'
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      List<dynamic> threads = decoded['items'] as List;

      return <String, dynamic> {
        'error': false,
        'count': decoded['count'],
        'limit': decoded['limit'],
        'offset': decoded['offset'],
        'total': decoded['total'],
        'threads': threads.map((thread) => ThreadModel.fromJson(thread)).toList(),
      };
    } else {
      return <String, dynamic> {
        'error': true,
        'response': response.body,
      };
    }
  }

  @override
  Future<Map<String, dynamic>> getMessages(Map<String, String> query) async {
    final response = await http.get(
      Uri.http(baseUrl, '/wp-json/mobile/v1/messages', query),
      headers: {
        'Authorization': 'Bearer $token'
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      List<dynamic> messages = decoded['items'] as List;

      return <String, dynamic> {
        'error': false,
        'count': decoded['count'],
        'limit': decoded['limit'],
        'offset': decoded['offset'],
        'total': decoded['total'],
        'messages': messages.map((message) => PrivateMessageModel.fromJson(message)).toList(),
      };
    } else {
      return <String, dynamic> {
        'error': true,
        'response': response.body,
      };
    }
  }

  @override
  Future<Map<String, dynamic>> validateJwtToken(String token) async {
    final response = await http.post(
      Uri.http(baseUrl, '/wp-json/jwt-auth/v1/token/validate'),
      headers: {
        'Authorization': 'Bearer $token'
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      this.token = token;
      return <String, dynamic> {
        'error': false,
        'token': token,
        'valid': true,
      };
    } else {
      return <String, dynamic> {
        'error': true,
        'response': response.body,
      };
    }
  }

  @override
  Future<Map<String, dynamic>> sendMessage(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.http(baseUrl, '/wp-json/mobile/v1/messages'),
      headers: {
        'Authorization': 'Bearer $token'
      },
      body: data
    );

    print(response.body);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      return <String, dynamic> {
        'error': false,
        'thread_id': decoded['thread_id'],
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
