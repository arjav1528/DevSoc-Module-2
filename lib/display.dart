import 'package:calc_firebase_login/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class HistoryLog extends StatefulWidget {
  const HistoryLog({super.key});

  @override
  State<HistoryLog> createState() => _HistoryLogState();
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
    final calculations = await _calculationService.getCaculation(userId);
    setState(() {
      _calculations = calculations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Log'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,

      ),
      body: Center(
        child: ListView.builder(
          itemCount: _calculations.length,
          itemBuilder: (context,index){
            return Center(
              child: ListTile(
                title: Text(_calculations[index],
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),)
              ),
            );
          },
        ),
      ),
    );
  }
}
