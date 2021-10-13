import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DataService {
  /// [collection] - path to firestore reference
  String get collection;

  /// [reference] - return reference by user
  CollectionReference get reference {
    return FirebaseFirestore.instance.collection(collection);
  }

  CollectionReference subReference(String id, String subCollection) {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .collection(subCollection);
  }

  Future clearSubReference(String id, String subCollection) async {
    final snapshot = await subReference(id, subCollection).get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      await snapshot.docs
          .elementAt(i)
          .reference
          .delete();
    }
  }

  Stream<QuerySnapshot> getSortedStream({required String sortedBy}) {
    return reference.orderBy(sortedBy).snapshots();
  }

  Stream<QuerySnapshot> getDescendingStream({required String sortedBy}) {
    return reference.orderBy(sortedBy, descending: true).snapshots();
  }

  /// [stream] - return stream of current snapshot
  Stream<QuerySnapshot> get stream => reference.snapshots();
}
