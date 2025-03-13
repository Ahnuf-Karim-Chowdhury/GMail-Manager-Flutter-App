import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gmail_manager/components/appbar.dart'; // Import the new AppBar

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // navigate back to home page
  void goToHomePage() {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIAppBar(
        onMenuTap: goToHomePage,
        onProfileTap: () {},
        context: context,
      ),
      body: Center(
        child: Text("Profile Page"),
      ),
    );
  }
}
