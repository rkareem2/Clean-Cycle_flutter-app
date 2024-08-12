import 'dart:io';

import 'package:clean_cycle/components/text_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  // all users
  final usersCollection = FirebaseFirestore.instance.collection("users");
  final picker = ImagePicker();
  final storage = FirebaseStorage.instance;

  // edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            "Edit $field",
            style: const TextStyle(color: Colors.white),
          ),
          content: TextField(
              autofocus: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter new $field",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                newValue = value;
              }),
          actions: [
            // cancel button
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),

            // save button
            TextButton(
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(newValue),
            ),
          ]),
    );
  }

// Upload image to Firebase Storage
  Future<void> _uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final storageRef = storage.ref().child('profile_pics/${currentUser.uid}');
      final uploadTask = storageRef.putFile(file);

      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore with the new profile picture URL
      await usersCollection.doc(currentUser.email).update({
        'profilePic': downloadUrl,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data();

            if (userData == null) {
              return const Center(
                child: Text('No data available'),
              );
            }

            final userMap = userData as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(height: 50),

                // profile pic
                Center(
                  child: CircleAvatar(
                    radius: 72,
                    backgroundImage: userMap['profilePic'] != null
                        ? NetworkImage(userMap['profilePic'])
                        : null,
                    child: userMap['profilePic'] == null
                        ? const Icon(
                            Icons.person,
                            size: 72,
                          )
                        : null,
                  ),
                ),

                const SizedBox(height: 10),

                // upload button
                Center(
                  child: ElevatedButton(
                    onPressed: _uploadImage,
                    child: const Text('Change Profile Picture'),
                  ),
                ),

                const SizedBox(height: 50),

                //user email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),

                const SizedBox(height: 50),

                //user details
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    "My details",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),

                // first name
                MyTextBox(
                  text: userMap['fname'],
                  sectionName: 'First Name',
                  onPressed: () => editField('fname'),
                ),

                // last name
                MyTextBox(
                  text: userMap['lname'],
                  sectionName: 'Last Name',
                  onPressed: () => editField('lname'),
                ),

                // username
                MyTextBox(
                  text: userMap['username'],
                  sectionName: 'Username',
                  onPressed: () => editField('username'),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
