import 'package:cloud_firestore/cloud_firestore.dart';

class CalculationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveCalculation(String userId, String calculation) async {
    await _firestore.collection('users').doc(userId).collection('calculations').add({
      'calculation': calculation,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List> getCalculations(String userId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('calculations')
        .orderBy('timestamp', descending: true)
        .limit(10)
        .get();

    return snapshot.docs.map((doc) => doc['calculation']).toList();
  }
}