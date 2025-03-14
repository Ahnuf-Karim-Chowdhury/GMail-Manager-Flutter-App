import 'package:flutter/material.dart';

class UIListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;  
  const UIListTile({super.key, required this.onTap, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        onTap: onTap,
        title: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
