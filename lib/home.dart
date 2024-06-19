import 'package:calc_firebase_login/authentication/login.dart';
import 'package:calc_firebase_login/authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://mir-s3-cdn-cf.behance.net/project_modules/disp/15549a14589707.5628669c64769.png'),
            fit: BoxFit.cover
          )
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('WELCOME',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                      fontFamily: 'IndieFlower'
                  ),),
                SizedBox(height: 50),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, PageTransition(child: LoginPage(), type: PageTransitionType.fade));
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blueAccent)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('SIGN IN',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),),
                  ),
                ),
                SizedBox(height: 50),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, PageTransition(child: RegisterPage(), type:PageTransitionType.fade));
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blueAccent)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('REGISTER',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
