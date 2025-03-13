import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gmail_manager/components/drawer.dart';
import 'package:gmail_manager/components/loading.dart';
import 'package:gmail_manager/pages/profile.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser!;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoggingOut = false;
  final Logger logger = Logger();

  //sign user out
  void signUserOut(BuildContext context) async {
    bool shouldLogout = await showLogoutConfirmationDialog(context);
    if (shouldLogout) {
      setState(() {
        _isLoggingOut = true;
      });
      try {
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacementNamed('/login');
      } catch (e) {
        logger.e('Error signing out: $e');
        setState(() {
          _isLoggingOut = false;
        });
      }
    }
  }

  // navigate to profile page
  void goToProfilePage() {
    Navigator.pop(context);

    // go to profile page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  Future<bool> showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              // ignore: deprecated_member_use
              backgroundColor: Colors.grey.shade400.withOpacity(
                0.9,
              ), // Adjust transparency here
              title: Text('LogOut Confirmation'),
              content: Text('Are you sure you want to LogOut?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Cancel
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.black)),
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
                    style: TextStyle(
                      color: Colors.white,
                    ), // Set LogOut button color to white
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    side: BorderSide(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        ) ??
        false; // Return false if the dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            widget._scaffoldKey.currentState?.openDrawer();
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
      drawer: UIDrawer(
        onLogOut: () => signUserOut(context),  // Corrected this line
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
