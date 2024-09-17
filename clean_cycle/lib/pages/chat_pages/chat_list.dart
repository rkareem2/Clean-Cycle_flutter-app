import 'package:clean_cycle/pages/chat_pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<StatefulWidget> createState() => ChatListPageState();
}

class ChatListPageState extends State<ChatListPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  
  List<MapEntry<String, dynamic>> _chatRooms = [];
  List<MapEntry<String, dynamic>> _filteredChatRooms = [];

  @override
  void initState() {
    super.initState();
    fetchChatRooms();
    _searchController.addListener(_filterChatRooms);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchChatRooms() async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(_firebaseAuth.currentUser!.uid).get();
      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> chatRooms = Map<String, dynamic>.from(userDoc.get('chatRooms'));
        setState(() {
          _chatRooms = chatRooms.entries.toList();
          _filteredChatRooms = List.from(_chatRooms);
        });
      }
    } catch (e) {
      print("Error fetching chat rooms: $e");
    }
  }

  void _filterChatRooms() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredChatRooms = _chatRooms.where((room) {
        String value = room.value.toString().toLowerCase();
        return value.contains(searchTerm);
      }).toList();
    });
  }

  void _goToChatRoomDetail(String key, dynamic value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(chatRoomId: key, chatRoomName: value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Rooms"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Chat Rooms',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _filteredChatRooms.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filteredChatRooms.length,
                    itemBuilder: (context, index) {
                      MapEntry<String, dynamic> chatRoom = _filteredChatRooms[index];
                      return ListTile(
                        title: Text(chatRoom.value.toString()),
                        onTap: () => _goToChatRoomDetail(chatRoom.key, chatRoom.value),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}