import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:gmail_manager/components/sidebar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser!;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  // logger
  final Logger logger = Logger();

  //sign user out
  void signUserOut(BuildContext context) async {
    bool shouldLogout = await showLogoutConfirmationDialog(context);
    if (shouldLogout) {
      try {
        await FirebaseAuth.instance.signOut();
      } catch (e) {
        logger.e('Error signing out: $e');
      }
    }
  }

  Future<bool> showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade400.withOpacity(0.9), // Adjust transparency here
          title: Text('LogOut Confirmation'),
          content: Text('Are you sure you want to LogOut?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel
              },
              child: Text('Cancel',style: TextStyle(color: Colors.black),),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // LogOut
              },
              child: Text(
                'LogOut',
                style: TextStyle(color: Colors.white), // Set LogOut button color to red
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                side: BorderSide(color: Colors.red),
              ),
            ),
          ],
        );
      },
    ) ?? false; // Return false if the dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          splashColor: Colors.white, // Set splash color to white
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              signUserOut(context);
            },
            splashColor: Colors.white, // Set splash color to white
          ),
        ],
        title: Text('Dashboard'),
      ),
      drawer: Sidebar(),
      body: Center(
        child: Text("Welcome: ${user.email}"), 
      ),
    );
  }
}
