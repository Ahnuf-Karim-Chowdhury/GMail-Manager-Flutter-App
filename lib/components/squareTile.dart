import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;

  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: imagePath.endsWith('.svg') 
          ? SvgPicture.asset(
              imagePath,
              height: 72,
            )
          : Image.asset(
              imagePath,
              height: 72, 
            ),
    );
  }
}
