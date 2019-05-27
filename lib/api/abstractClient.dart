abstract class AbstractApiClient {
  Future<Map<String, dynamic>> getJwtToken(Map<String, String> credentials);

}