import 'package:clean_cycle/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
//import '../pages/settings_page.dart;

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

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

            //home list file
            // MyDrawerListTile(
            //   text: "H O M E",
            //   icon: icons.home,
            //   onTap: () => Navigator.pop(context),
            // ),

            //settings list tile
            // MyDrawerListTile(
            //     text: "S E T T I N G S",
            //     icon: Icons.settings,
            //     onTap: () {
            //       //Pop drawer
            //       Navigator.pop(context);

            //       //go to settings page
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const SettingsPage(),
            //         ),
            //       );
            //     }),
            const Spacer(),

            //logout lsit tile
            // MyDrawerListTile(
            //   text: "L O G O U T",
            //   icon: Icons.logout,
            //   onTap: () {
            //     logout();
            //     Navigator.pop(context);
            //   },
            // ),
            const SizedBox(height: 25),
          ],
        ));
  }
}
