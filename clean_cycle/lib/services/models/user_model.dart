class UserModel {

  final String? id;
  final String fname;
  final String lname;
  final String username;
  final String email;
  final String password;
  String? role;

  UserModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.username,
    required this.email,
    required this.password,
    this.role
  });

  toJson() {
    return {
      "fname": fname,
      "lname": lname,
      "username": username,
      "email": email,
      "password": password,
      "role": role
    };
  }
}
