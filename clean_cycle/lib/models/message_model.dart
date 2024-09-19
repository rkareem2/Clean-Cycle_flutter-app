import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String message;
  final Timestamp timestamp;

  MessageModel({
    required this.senderId,
    required this.message,
    required this.timestamp
  });

  Map<String, dynamic> toMap() {
    return {
      "senderId" : senderId,
      "message" : message,
      "timestamp" : timestamp
    };
  }
}
