import 'package:clean_cycle/models/collection_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionCenterController extends GetxController {
  static CollectionCenterController get instance => Get.find();

  Future<bool> postItem(CollectionItemModel item, BuildContext context) async {
    try {
      await addCollectionItem(item);
      Get.snackbar('Success', 'Item posted successfully.');
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
  }

  Future<void> addCollectionItem(CollectionItemModel item) async {
    final itemCollection = FirebaseFirestore.instance.collection('collection-items');
    await itemCollection.doc().set({
      'name': item.name,
      'desscription': item.description,
      'category': item.category,
    });
  }
}
