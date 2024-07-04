import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get collection of collect/donate
  final CollectionReference collect =
      FirebaseFirestore.instance.collection('collect');

  //save collect/donation to db
  Future<void> saveCollectToDatabase(String r) async {
    await collect.add({
      'date': DateTime.now(),
      'order': r,
      //add more fields as necessary..
    });
  }
}
