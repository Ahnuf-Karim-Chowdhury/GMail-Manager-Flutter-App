import 'package:flutter/material.dart';


class UIDrawer extends StatelessWidget {
  const UIDrawer({super.key});

  Widget build(BuildContext context) {
    return Drawer(
       backgroundColor: Colors.grey[900],
      child: Column(
        children: [

          //header
          DrawerHeader(child: Icon(
            Icons.person,
            color: Colors.white,
            size: 64,
          ))

        ],
      ),
    );
  }
}
