import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/screens/login.dart';
import 'package:trabalho_final_flutter/screens/menu.dart';


class Splash extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds:3),(){
      var firebaseAuth = FirebaseAuth.instance;
      var user = firebaseAuth.currentUser;
      if(user != null){
        Navigator.push(context,MaterialPageRoute(
          builder: (context)=>const Menu(),
        ));
      }else{
        Navigator.push(context,MaterialPageRoute(
          builder: (context)=>Login(),
        ));
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Carregando...',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 5.0,),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              strokeWidth: 11.0,
            ),
          ],
        ),
      ),
    );
  }
}