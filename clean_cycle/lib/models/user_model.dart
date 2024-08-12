class UserModel {
  final String? id;
  final String fname;
  final String lname;
  final String username;
  final String email;

  const UserModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.username,
    required this.email,
  });

  get firstName => null;
  get lastName => null;
  get profileUrl => null;

  toJson() {
    return {
      "fname": fname,
      "lname": lname,
      "username": username,
      "email": email,
    };
  }
}
