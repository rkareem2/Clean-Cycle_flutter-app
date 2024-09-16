import 'package:clean_cycle/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    MessageModel newMessage = MessageModel(
      senderId: currentUserId,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _firestore.collection("chat_rooms").doc(chatRoomId).collection("messages").add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String firstUserId, String secondUserId) {
    List<String> ids = [firstUserId, secondUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    
    return _firestore.collection("chat_rooms").doc(chatRoomId).collection("messages").orderBy("timestamp", descending: false).snapshots();
  }
}