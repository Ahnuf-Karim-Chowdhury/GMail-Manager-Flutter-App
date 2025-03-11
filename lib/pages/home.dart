import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser!;
  
  // logger
  final Logger logger = Logger();

  //sign user out
  void signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      logger.e('Error signing out: $e'); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, 
        actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
      ),
      body: Center(
        child: Text("Welcome: ${user.email}"), 
      ),
    );
  }
}
