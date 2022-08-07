import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(blogData) async {
    await FirebaseFirestore.instance
        .collection('blogs')
        .add(blogData)
        .catchError((e) {});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getData() {
    return FirebaseFirestore.instance.collection('blogs').snapshots();
  }
}
