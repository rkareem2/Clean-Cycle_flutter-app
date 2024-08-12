import 'package:flutter/material.dart';
import 'package:clean_cycle/services/auth_service.dart'; // Import your authentication service

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  void logout(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signOut();
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Are you sure you want to log out?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => logout(context),
              child: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
