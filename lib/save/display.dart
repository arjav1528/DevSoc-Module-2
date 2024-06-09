import 'package:calc_firebase_login/save/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryLog extends StatefulWidget {
  const HistoryLog({super.key});

  @override
  _HistoryLogState createState() => _HistoryLogState();
}

class _HistoryLogState extends State<HistoryLog> {
  final CalculationService _calculationService = CalculationService();

  List<dynamic> _calculations = [];

  @override
  void initState() {
    super.initState();
    _loadCalculations();
  }

  Future<void> _loadCalculations() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? _user = _auth.currentUser;
    final String userId = _user!.uid;
    final calculations = await _calculationService.getCalculations(userId);
    setState(() {
      _calculations = calculations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Log'),
      ),
      body: ListView.builder(
        itemCount: _calculations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_calculations[index]),
          );
        },
      ),
    );
  }
}