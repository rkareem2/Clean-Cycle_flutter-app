class UserModel {
  final String? id;
  final String fname;
  final String lname;
  final String username;
  final String email;
  Map<String, dynamic>? chatRooms;

  UserModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.username,
    required this.email,
    this.chatRooms
  });

  get firstName => null;
  get lastName => null;
  get profileUrl => null;

  toJson() {
    return {
      "id" : id,
      "fname": fname,
      "lname": lname,
      "username": username,
      "email": email,
      "chatRooms": chatRooms
    };
  }
}
