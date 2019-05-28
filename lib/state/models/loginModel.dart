class LoginModel {
  String token;
  String username;
  String email;

  bool authenticated = false;

  LoginModel(this.token, this.username, this.email, this.authenticated);
}
