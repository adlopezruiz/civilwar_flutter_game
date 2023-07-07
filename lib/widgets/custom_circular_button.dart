
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Make widget receive callback
class CustomCircularButton extends StatelessWidget {
  final IconData? icon;
  final Function()? onTap;
  const CustomCircularButton(
      {super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: RawMaterialButton(
        onPressed: onTap,
        fillColor: Colors.white,
        shape: const CircleBorder(),
        constraints: const BoxConstraints(minHeight: 35, minWidth: 35),
        child: FaIcon(
          icon,
          size: 22,
          color: const Color(0xFF2F3041),
        ),
      ),
    );
  }
}
