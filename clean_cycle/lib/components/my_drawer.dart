import 'package:clean_cycle/components/my_drawer_tile.dart';
import 'package:clean_cycle/pages/settings_page.dart';
import 'package:clean_cycle/services/auth/auth_service.dart';
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
              onTap: () {},
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
                }
            ),

            const Spacer(),

            //logout list tile
            // MyDrawerListTile(
            //   text: "L O G O U T",
            //   icon: Icons.logout,
            // Home list tile
            // Uncomment and customize your own list tiles as needed
            // MyDrawerListTile(
            //   text: "H O M E",
            //   icon: Icons.home,
            //   onTap: () => Navigator.pop(context),
            // ),

            // Settings list tile
            // Uncomment and customize your own list tiles as needed
            // MyDrawerListTile(
            //   text: "S E T T I N G S",
            //   icon: Icons.settings,
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const SettingsPage(),
            //       ),
            //     );
            //   },
            // ),

            const Spacer(),

            // Logout list tile
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("L O G O U T"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogoutPage()),
                );
              },
            ),
            const Spacer(),

            const SizedBox(height: 25),
          ],
        ));
  }
}
