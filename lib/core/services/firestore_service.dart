import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();

  static final FirestoreService instance = FirestoreService._();

  factory FirestoreService() => instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> userCollection(
    String userId,
    String collection,
  ) => _firestore.collection('users').doc(userId).collection(collection);
}
