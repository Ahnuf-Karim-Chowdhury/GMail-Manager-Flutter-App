import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gmail_manager/pages/home.dart';
import 'package:gmail_manager/pages/loginOrRegister.dart';
import 'package:gmail_manager/pages/verify_email.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user logged in
          if (snapshot.hasData == false) {
            return LoginOrRegisterPage();
          }
          // user not logged in
          else {
            if (snapshot.data?.emailVerified == true) {
              return HomePage();
            }
            return VerifyEmailPage();
          }
        },
      ),
    );
  }
}
