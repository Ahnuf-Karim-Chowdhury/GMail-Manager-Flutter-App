import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:gmail_manager/components/sidebar.dart';

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
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: signUserOut,
          ),
        ],
        title: Text('Dashboard'),
      ),
      drawer: SidebarPage(),
      body: Center(
        child: Text("Welcome: ${user.email}"), 
      ),
    );
  }
}
