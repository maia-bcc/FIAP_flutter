import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/screens/components/rounded_button.dart';
import 'package:trabalho_final_flutter/screens/components/rounded_text_field.dart';

import 'menu.dart';

class Login extends StatelessWidget {
  static const String id = 'login';

  Login({super.key});

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedTextField(
                text: 'Email',
                onChanged: (value) => email = value,
              ),
              const SizedBox(height: 32),
              RoundedTextField(
                text: 'Senha',
                onChanged: (value) => password = value,
                obscureText: true,
              ),
              const SizedBox(height: 64),
              RoundedButton(
                text: 'Entrar',
                onPressed: () => authenticateUser(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  void authenticateUser(BuildContext context) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((userCredential) {
      Navigator.pushReplacementNamed(context, Menu.id);
    }).catchError((_) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((userCredential) {
        Navigator.pushReplacementNamed(context, Menu.id);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message),
          ),
        );
      });
    });
  }
}