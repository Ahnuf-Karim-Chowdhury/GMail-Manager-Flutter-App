import 'package:flutter/material.dart';

class UIButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? color;
  final double? borderRadius;
  final double? paddingHeight;
  final double? paddingWidth;
  final double? fontSize;

  const UIButton({
    super.key,
    required this.onTap,
    required this.text,
    this.color = Colors.black,
    this.borderRadius = 8.0,
    this.paddingHeight = 20.0,
    this.paddingWidth = 25.0,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(paddingHeight ?? 20.0),
        margin: EdgeInsets.symmetric(horizontal: paddingWidth ?? 25.0),
        decoration: BoxDecoration(
          color: color ?? Colors.black,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize ?? 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
