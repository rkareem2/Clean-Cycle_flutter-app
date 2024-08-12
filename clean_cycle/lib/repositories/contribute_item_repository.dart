import 'package:clean_cycle/models/collection_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContributeItemRepository extends GetxController {

  static ContributeItemRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  postItem(CollectionItemModel item) async {
    await _db.collection("collection-items").add(item.toJson())
      .whenComplete(() => 
        Get.snackbar("Success", "Your item has been posted.",
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
