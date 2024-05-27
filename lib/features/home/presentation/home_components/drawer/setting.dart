import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_application/core/images/image.dart';

class RotatingSvgIcon extends StatefulWidget {
  const RotatingSvgIcon({super.key});

  @override
  _RotatingSvgIconState createState() => _RotatingSvgIconState();
}

class _RotatingSvgIconState extends State<RotatingSvgIcon> {
  double _rotationAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _rotationAngle += 90.0;
        });
      },
      child: Transform.rotate(
        angle: _rotationAngle *
            (3.141592653589793 / 180),
        child: SvgPicture.asset(
          AllIcons.setting,
          width: 35,
          height: 35,
        ),
      ),
    );
  }
}
