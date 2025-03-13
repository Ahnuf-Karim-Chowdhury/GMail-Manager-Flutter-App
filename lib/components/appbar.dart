import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class UIAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onProfileTap;
  final BuildContext context;
  final String title;

  const UIAppBar({
    Key? key,
    required this.onMenuTap,
    required this.onProfileTap,
    required this.context,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[900],
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: onMenuTap,
        splashColor: Colors.white, // Set splash color to white
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.logout, color: Colors.white),
          onPressed: () {
            signUserOut(context);
          },
          splashColor: Colors.white, // Set splash color to white
        ),
      ],
      title: Text(title, style: TextStyle(color: Colors.white)),
    );
  }

  static Future<bool> showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.grey.shade800.withOpacity(0.9),
              title: Text(
                'LogOut Confirmation',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              content: Text(
                'Are you sure you want to LogOut?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              actions: [
                // Wrap the buttons in a Row to center them
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false); // Cancel
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10), // Add spacing between buttons
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true); // LogOut
                      },
                      child: Text(
                        'LogOut',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ) ??
        false; // Return false if the dialog is dismissed
  }

  void signUserOut(BuildContext context) async {
    final Logger logger = Logger();

    bool shouldLogout = await showLogoutConfirmationDialog(context);
    if (shouldLogout) {
      try {
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacementNamed('/login');
      } catch (e) {
        logger.e('Error signing out: $e');
      }
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
