import 'package:clean_cycle/services/auth/auth_service.dart';
import 'package:clean_cycle/models/user_model.dart';
import 'package:clean_cycle/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionCenterController extends GetxController {
  static CollectionCenterController get instance => Get.find();
  final AuthService _authService = AuthService();
  final userRepo = Get.put(UserRepository());

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<bool> createUser(UserModel user, BuildContext context) async {
    try {
      // Sign up the user with email and password
      UserCredential userCredential = await _authService.signUpWithEmailPassword(emailController.text, passwordController.text);

      // Save additional user information in Firestore
      await saveUserDetails(user, userCredential.user!.uid);

      // If sign-up is successful, show a success message
      Get.snackbar('Success', 'User signed up successfully.');
      return true;
    } catch (e) {
      print(e);
      // Handle sign-up errors
      Get.snackbar('Error', e.toString());
      return false;
    }
  }

  Future<void> saveUserDetails(UserModel user, String uid) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    await userCollection.doc(user.email).set({
      'id': uid,
      'fname': user.fname,
      'lname': user.lname,
      'username': user.username,
      'email': user.email,
      // Optional: Add a default profile URL if needed
      'profileUrl':
          'https://example.com/user-profile.jpg', // Default profile URL
    });
  }
}
