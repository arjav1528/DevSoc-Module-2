import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class CalculationService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List> getCaculation(String userID) async {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(userID)
        .collection('calculations')
        .orderBy('timestamp',descending: true)
        .limit(10)
        .get();
    return snapshot.docs.map((doc) => doc['calculation']).toList();
  }
}