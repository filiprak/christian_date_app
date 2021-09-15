abstract class AbstractApiClient {
  Future<Map<String, dynamic>> getJwtToken(Map<String, String> credentials);

  Future<Map<String, dynamic>> validateJwtToken(String token);

  Future<Map<String, dynamic>> getCurrentUserData();

  Future<Map<String, dynamic>> getUsers(Map<String, String> query);

  // activities

  Future<Map<String, dynamic>> getActivities(Map<String, String> query);

  Future<Map<String, dynamic>> createActivity(String content);

  // messages

  Future<Map<String, dynamic>> getMessageThreads(Map<String, String> query);

  Future<Map<String, dynamic>> getMessages(Map<String, String> query);

  Future<Map<String, dynamic>> sendMessage(Map<String, dynamic> params);

}