import 'package:flutter/material.dart';
import 'package:gmail_manager/components/list_tile.dart';

class UIDrawer extends StatelessWidget {
  final VoidCallback onProfileTap; // Corrected the type here
  final VoidCallback onLogOut; // Corrected the type here

  const UIDrawer({
    super.key,
    required this.onLogOut,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          //header
          DrawerHeader(
            child: Icon(Icons.person, color: Colors.white, size: 64),
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // home list tile
                    UIListTile(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      icon: Icons.home,
                      text: "H O M E",
                    ),

                    // profile list tile
                    UIListTile(
                      onTap: onProfileTap,
                      icon: Icons.person,
                      text: "P R O F I L E",
                    ),

                    // inbox
                    UIListTile(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/inbox');
                      },
                      icon: Icons.inbox,
                      text: "I N B O X",
                    ),






                  ],
                ),

                // logout list tile
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: UIListTile(
                    onTap: onLogOut,
                    icon: Icons.logout,
                    text: "L O G O U T",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
