import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authservice {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    // Sign out from any previously signed in account
    await _googleSignIn.signOut();

    // Start the sign-in process again
    final GoogleSignInAccount? guser = await _googleSignIn.signIn();

    if (guser == null) {
      // The user canceled the sign-in
      return;
    }

    final GoogleSignInAuthentication gauth = await guser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
