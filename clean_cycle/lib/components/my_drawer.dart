import 'package:clean_cycle/components/my_drawer_tile.dart';
import 'package:clean_cycle/pages/Home_page.dart';
import 'package:clean_cycle/pages/collection_requests_page.dart';
import 'package:clean_cycle/pages/contribute_history.dart';
import 'package:clean_cycle/pages/profile_page.dart';
import 'package:clean_cycle/pages/settings_page.dart';
import 'package:clean_cycle/services/auth/logout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  Future<Map<String, dynamic>> getUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.email)
        .get();

    if (docSnapshot.exists) {
      final userData = docSnapshot.data();
      if (userData != null) {
        return userData;
      } else {
        print("User data is null");
      }
    } else {
      print("Document does not exist for email: ${currentUser.email}");
    }

    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const SizedBox(height: 30),
          // Fetch and display user info
          FutureBuilder<Map<String, dynamic>>(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final userData = snapshot.data ?? {};
                final userName = userData['username'] ?? 'User';
                final profileUrl = userData['profileUrl'] ??
                    'https://example.com/user-profile.jpg'; // Replace with actual field or default URL
                return MyDrawerTile(
                  text: userName,
                  imageUrl: profileUrl,
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                    );
                  },
                );
              }
            },
          ),
          // home list tile
          MyDrawerTile(
            text: "H O M E",
            icon: Icons.home,
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          MyDrawerTile(
            text: "P R O F I L E",
            icon: Icons.person,
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          // settings list tile
          MyDrawerTile(
            text: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          // collection requests tile
          MyDrawerTile(
              text: '''C O L L E C T I O N\nR E Q U E S T S''',
              icon: Icons.recycling,
              onTap: () {
                //Pop drawer
                Navigator.pop(context);

                //go to collection requests page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CollectionRequestsPage(),
                  ),
                );
              }),

          // history list tile
          MyDrawerTile(
            text: "H I S T O R Y",
            icon: Icons.history,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const historyPage(),
                ),
              );
            },
          ),
          const Spacer(),
          // Logout list tile
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("L O G O U T"),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LogoutPage()),
              );
            },
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
