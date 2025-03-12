import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class Authservice {
  final Logger logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> sendEmailVerificationLink() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
      logger.i('Verification email sent.');
    } catch (e) {
      logger.e('Error sending verification email: $e');
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? guser = await _googleSignIn.signIn();
      if (guser == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication gauth = await guser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gauth.accessToken,
        idToken: gauth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      logger.e('Error signing in with Google: $e');
      return null;
    }
  }
}


