abstract class AbstractApiClient {
  Future<Map<String, dynamic>> getJwtToken(Map<String, String> credentials);

  Future<Map<String, dynamic>> getCurrentUserData();

  Future<Map<String, dynamic>> getActivities(Map<String, String> query);

  Future<Map<String, dynamic>> createActivity(String content);

}