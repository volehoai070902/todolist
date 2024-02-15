class UserModel {
  String email;
  String password;
  UserModel({required this.email, required this.password});

  set useremail(String email) {
    this.email = email;
  }

  set userpassword(String password) {
    this.password = password;
  }
}