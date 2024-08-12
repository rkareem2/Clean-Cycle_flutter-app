import 'package:clean_cycle/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {

  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db.collection("users").add(user.toJson())
      .whenComplete(() => 
        Get.snackbar("Success", "Your account has been created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green)
      )
      .catchError((error, stackTrace) {
        Get.snackbar("Error", "Something went wrong, try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      });
  }
}
