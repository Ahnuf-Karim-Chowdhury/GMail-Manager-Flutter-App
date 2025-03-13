import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gmail_manager/components/appbar.dart'; // Import the new AppBar
import 'package:gmail_manager/components/drawer.dart'; // Import the Drawer
import 'package:gmail_manager/components/loading.dart'; // Import the Loading screen
import 'package:gmail_manager/pages/profile.dart';

class ProfilePage extends StatefulWidget {
   ProfilePage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: UIAppBar(
        title: "Profile Page",
        onMenuTap: () {
          widget._scaffoldKey.currentState?.openDrawer();
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
      body: Center(
        child: Text("Profile Page"),
      ),
    );
  }
}
