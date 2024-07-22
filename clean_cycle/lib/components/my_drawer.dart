import 'package:clean_cycle/components/my_drawer_tile.dart';
import 'package:clean_cycle/pages/Home_page.dart';
import 'package:clean_cycle/pages/settings_page.dart';
import 'package:clean_cycle/services/auth/logout.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            //app logo
            Padding(
              padding: const EdgeInsets.only(
                top: 100.0,
                bottom: 50,
              ),
              child: Icon(
                Icons.lock_open_rounded,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),

            //divider line
            Padding(
              padding: const EdgeInsets.all(25),
              child: Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),

            // home list file
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

            // settings list tile
            MyDrawerTile(
                text: "S E T T I N G S",
                icon: Icons.settings,
                onTap: () {
                  //Pop drawer
                  Navigator.pop(context);

                  //go to settings page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                }),

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
            const Spacer(),

            const SizedBox(height: 25),
          ],
        ));
  }
}
