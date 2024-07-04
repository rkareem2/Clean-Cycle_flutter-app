import 'package:cloud_firestore/cloud_firestore.dart';

//this page will create a column "collect" on the database with data and collect as fields
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
