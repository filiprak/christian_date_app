abstract class AbstractApiClient {
  Future<Map<String, dynamic>> getJwtToken(Map<String, String> credentials);

  Future<Map<String, dynamic>> getCurrentUserData();

}