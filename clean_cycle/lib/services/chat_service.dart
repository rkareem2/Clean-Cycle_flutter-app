import 'package:clean_cycle/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUsersChatRoom(String itemId, String requestorId, String ownerId, String chatRoomName) async {
    DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore.collection('users').doc(requestorId).get();
    String chatRoomId = "${itemId}_$requestorId";

    if (userDoc.exists) {
      if (userDoc.data()?['chatRooms'] != null && userDoc.data()?['chatRooms'] is Map) {
        Map<String, dynamic> chatRooms = userDoc.data()!['chatRooms'];
        chatRooms[chatRoomId] = chatRoomName;
        await _firestore.collection('users').doc(requestorId).update({'chatRooms': chatRooms});
        await _firestore.collection('users').doc(ownerId).update({'chatRooms': chatRooms});
      } else {
        await _firestore.collection('users').doc(requestorId).update({'chatRooms': {chatRoomId: chatRoomName}});
        await _firestore.collection('users').doc(ownerId).update({'chatRooms': {chatRoomId: chatRoomName}});
      }
    }
  }

  Future<void> sendMessage(String chatRoomId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    MessageModel newMessage = MessageModel(
      senderId: currentUserId,
      message: message,
      timestamp: timestamp
    );

    await _firestore.collection("chat-rooms").doc(chatRoomId).collection("messages").add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String chatRoomId) {
    return _firestore.collection("chat-rooms").doc(chatRoomId).collection("messages").orderBy("timestamp", descending: false).snapshots();
  }
}