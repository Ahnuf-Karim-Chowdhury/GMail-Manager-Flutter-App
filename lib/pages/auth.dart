import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gmail_manager/pages/home.dart';
import 'package:gmail_manager/pages/login.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user looged in
          if (snapshot.hasData) {
            return HomePage();
          }
          // user not logged in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
