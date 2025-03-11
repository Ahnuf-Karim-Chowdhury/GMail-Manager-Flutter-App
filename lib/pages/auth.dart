import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context,snapshot){
          //user looged in

          // user not logged in
          
        }),
    );
  }
}
