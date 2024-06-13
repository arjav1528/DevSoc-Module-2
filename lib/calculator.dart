import 'package:calc_firebase_login/display.dart';
import 'package:calc_firebase_login/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String operation = '';
  String calculation = '';
  double result = 0;
  bool isVisible = true;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final User? user;
  late final String userID;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future saveCalculation(String string) async{
    return await _firestore.collection('users').doc(userID).collection('calculations').add({
      'calculation' : calculation,
      'timestamp' : FieldValue.serverTimestamp(),
    });
  }
  @override
  void initState(){
    super.initState();
    user = auth.currentUser;
    userID = user!.uid;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Welcome to the Calculator'),
        backgroundColor: Colors.blueAccent,
        actions:[
          TextButton.icon(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            label: Text('Logout',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),),
            icon: Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 15, 8, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _num1Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  hintText: 'First Number'
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              SizedBox(height: 30),
              TextField(
                controller: _num2Controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    hintText: 'Second Number'
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: (){
                        setState(() {
                          double num1 = double.parse(_num1Controller.text);
                          double num2 = double.parse(_num2Controller.text);
                          result = num1 + num2;
                          isVisible = !(isVisible);
                          operation = '+';
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                        shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            )
                        ),
                      ),
                      child: const Text('   +   ',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white
                        ),),
                    ),
                  const SizedBox(width: 2),
                  TextButton(
                    onPressed: (){
                      setState(() {
                        double num1 = double.parse(_num1Controller.text);
                        double num2 = double.parse(_num2Controller.text);
                        result = num1 - num2;
                        isVisible = !(isVisible);
                        operation = '-';
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                      shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          )
                      ),
                    ),
                    child: const Text('   -   ',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white
                      ),),
                  ),
                  const SizedBox(width: 2),
                  TextButton(
                    onPressed: (){
                      setState(() {
                        double num1 = double.parse(_num1Controller.text);
                        double num2 = double.parse(_num2Controller.text);
                        result = num1 * num2;
                        isVisible = !(isVisible);
                        operation = 'x';
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                      shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          )
                      ),
                    ),
                    child: const Text('   x   ',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white
                      ),),
                  ),
                  const SizedBox(width: 2),
                  TextButton(
                    onPressed: (){
                      setState(() {
                        double num1 = double.parse(_num1Controller.text);
                        double num2 = double.parse(_num2Controller.text);
                        result = num1 / num2;
                        isVisible = !(isVisible);
                        operation = '/';

                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                      shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          )
                      ),
                    ),
                    child: const Text('   /   ',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white
                      ),),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 40),
              Center(
                child: Text('$result',
                  style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                  ),),
              ),
              SizedBox(height: 70),
              TextButton(
                child: Text('Save'),
                onPressed: () {
                  setState(() {
                    double num1 = double.parse(_num1Controller.text);
                    double num2 = double.parse(_num2Controller.text);
                    calculation = '$num1 $operation $num2 = $result';
                    saveCalculation(calculation);

                  });
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blueAccent)
                ),
              ),
              SizedBox(height: 30),
              TextButton(
                child: Text('History'),
                onPressed: () {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryLog()));

                  });
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blueAccent)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}