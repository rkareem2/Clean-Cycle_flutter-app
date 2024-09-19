class UserModel {
  final String? id;
  final String fname;
  final String lname;
  final String username;
  final String email;
  List<String>? collectionItem;
  Map<String, dynamic>? chatRooms;

  UserModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.username,
    required this.email,
    this.collectionItem,
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
      "collectionItem": collectionItem,
      "chatRooms": chatRooms
    };
  }
}
