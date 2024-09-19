import 'package:clean_cycle/models/collection_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionCenterController extends GetxController {
  static CollectionCenterController get instance => Get.find();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = <bool>[];
  bool isRecycle = false;
  bool isReuse = false;

  Future<void> postItem(CollectionItemModel item) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final docRef = firestore.collection('collection-items').doc();

    await docRef.set({
      'name': item.name,
      'description': item.description,
      'ownerId': FirebaseAuth.instance.currentUser!.uid,
      'category': item.category,
    });
    await firestore.collection("users").doc(firebaseAuth.currentUser!.uid).update({'collectionItems': FieldValue.arrayUnion([docRef.id])});
  }
}
