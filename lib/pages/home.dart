import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gmail_manager/components/drawer.dart';
import 'package:gmail_manager/components/loading.dart';
import 'package:gmail_manager/pages/profile.dart';
import 'package:gmail_manager/components/appbar.dart'; // Import the new AppBar

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser!;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_final_fields
  bool _isLoggingOut = false;

  // navigate to profile page
  void goToProfilePage() {
    Navigator.pop(context);

    // go to profile page
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
        title: "Dashboard",
        onMenuTap: () {
          widget._scaffoldKey.currentState?.openDrawer();
        },
        onProfileTap: goToProfilePage,
        context: context,
      ),
      drawer: UIDrawer(
        onLogOut: () => UIAppBar(
          title: "Dashboard",
          onMenuTap: () {},
          onProfileTap: goToProfilePage,
          context: context,
        ).signUserOut(context),
        onProfileTap: goToProfilePage,
      ),
      body: Stack(
        children: [
          Center(child: Text("Welcome: ${widget.user.email}")),
          if (_isLoggingOut)
            LoadingScreen(), // Show loading screen when logging out
        ],
      ),
    );
  }
}
