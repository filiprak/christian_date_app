abstract class AbstractApiClient {
  Future<Map<String, dynamic>> getJwtToken(Map<String, String> credentials);

  Future<Map<String, dynamic>> getCurrentUserData();

  // activities

  Future<Map<String, dynamic>> getActivities(Map<String, String> query);

  Future<Map<String, dynamic>> createActivity(String content);

  // messages

  Future<Map<String, dynamic>> getMessageThreads(Map<String, String> query);

}