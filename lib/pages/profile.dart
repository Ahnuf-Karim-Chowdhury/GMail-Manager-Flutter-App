import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gmail_manager/components/appbar.dart'; // Import the new AppBar
import 'package:gmail_manager/components/drawer.dart'; // Import the Drawer

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // navigate to home page
  void goToHomePage() {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/home');
  }

  // navigate to profile page
  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      key: _scaffoldKey,
      appBar: UIAppBar(
        title: "Profile Page",
        onMenuTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        onProfileTap: goToProfilePage,
        context: context,
      ),
      drawer: UIDrawer(
        onLogOut: () => UIAppBar(
          title: "Profile Page",
          onMenuTap: () {},
          onProfileTap: goToProfilePage,
          context: context,
        ).signUserOut(context),
        onProfileTap: goToProfilePage,
      ),
      body: ListView(
        children: [
          SizedBox(height: 50),

          // Profile pic
          Icon(Icons.person, size: 72),

          SizedBox(height: 10),

          // User email
          Text(
            currentUser?.email ?? 'No email',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),

          SizedBox(height: 10),

          // Username
          Text(
            currentUser?.displayName ?? 'No username',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
