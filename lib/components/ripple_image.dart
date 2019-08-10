import 'package:flutter/material.dart';

class RippleImage extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final String imagePath;
  final Function onTap;

  RippleImage(this.width, this.height, this.imagePath,
      {this.onTap, this.borderRadius = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(onTap: () {
                if (onTap != null) {
                  onTap();
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
