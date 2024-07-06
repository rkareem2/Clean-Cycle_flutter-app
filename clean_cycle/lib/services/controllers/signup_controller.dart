import 'package:clean_cycle/services/auth/auth_service.dart';
import 'package:clean_cycle/services/models/user_model.dart';
import 'package:clean_cycle/services/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final AuthService _authService = AuthService();
  final userRepo = Get.put(UserRepository());

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<bool> createUser(UserModel user, BuildContext context) async {
    await userRepo.createUser(user);
    signUpUser(user.email, user.password);
    return true;
  }

  Future<void> signUpUser(String email, String password) async {
    try {
      // Call sign up method from AuthService
      UserCredential userCredential =
          await _authService.signUpWithEmailPassword(email, password);

      // Handle additional user information like fname, lname, username, and role
      // This could involve saving these details to Firestore or another database

      // If sign-up is successful, navigate or show a success message
      Get.snackbar('Success', 'User signed up successfully.');
    } catch (e) {
      // Handle sign-up errors
      Get.snackbar('Error', e.toString());
    }
  }
}
