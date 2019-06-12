class LoginModel {
  String token;
  String username;

  bool authenticated = false;

  LoginModel(this.token, this.username, this.authenticated);
}
