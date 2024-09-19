import 'package:clean_cycle/pages/chat_pages/chat_page.dart';
import 'package:clean_cycle/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CollectionCenter extends StatefulWidget {
  const CollectionCenter({super.key});
  
  @override
  CollectionCenterState createState() => CollectionCenterState();
}

class CollectionCenterState extends State<CollectionCenter> {
  final CollectionReference items = FirebaseFirestore.instance.collection('collection-items');
  String searchQuery = '';
  String filterCriteria = 'All';
  bool menuExpanded = false;

  Future<List<QueryDocumentSnapshot>> getFilteredDocuments() async {
    final snapshot = await items.get();
    List<QueryDocumentSnapshot> filteredDocs = [];

    for (var doc in snapshot.docs) {
      final name = doc['name'].toString().toLowerCase();
      final matchesSearchQuery = name.contains(searchQuery.toLowerCase());

      bool matchesFilterCriteria = true;
      if (filterCriteria != 'All') {
        matchesFilterCriteria = await checkIfArrayContainsString(doc.id, 'collection-items', filterCriteria);
      }

      if (matchesSearchQuery && matchesFilterCriteria) {
        filteredDocs.add(doc);
      }
    }

    return filteredDocs;
  }

  Future<bool> checkIfArrayContainsString(String documentId, String collectionName, String searchString) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentId)
        .get();

    if (documentSnapshot.exists) {
      List<dynamic> arrayField = List<String>.from(documentSnapshot.get('category'));
      return arrayField.contains(searchString);
    } else {
      return false;
    }
  }

  void requestItem(String itemName, String itemId, String itemOwnerId) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    ChatService service = ChatService();
    String chatRoomId = "${itemId}_$currentUserId";

    service.updateUsersChatRoom(itemId, currentUserId, itemOwnerId, itemName);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(chatRoomId: chatRoomId, chatRoomName: itemName)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Filter by Category:'),
                    DropdownButton<String>(
                      value: filterCriteria,
                      items: ['All', 'Recycle', 'Reuse'].map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          filterCriteria = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: getFilteredDocuments(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2.5,
              childAspectRatio: 1,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              var item = data[index];
              return Padding(
                padding: const EdgeInsets.all(0),
                child: GridTile(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(7.5),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['name'],
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            item['description'],
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          ElevatedButton(onPressed: () => requestItem(item['name'], item.id, item['ownerId']), child: const Text("Request Item", style: TextStyle(color: Colors.blueAccent)),)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            right: 10,
            bottom: 145,
            child: AnimatedOpacity(
              opacity: menuExpanded ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton.extended(
                heroTag: 'contribute-page',
                onPressed: () {
                  Navigator.pushNamed(context, '/contribute_page');
                },
                icon: const Icon(Icons.add),
                label: const Text('Create Requests'),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 85,
            child: AnimatedOpacity(
              opacity: menuExpanded ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton.extended(
                heroTag: 'chat-rooms',
                onPressed: () {
                  Navigator.pushNamed(context, '/chat_rooms');
                },
                icon: const Icon(Icons.chat_bubble),
                label: const Text('Chats'),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 0,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  menuExpanded = !menuExpanded;
                });
              },
              heroTag: 'mainBtn',
              child: Icon(menuExpanded ? Icons.close : Icons.menu),
            ),
          ),
        ],
      ),
    );
  }
}
