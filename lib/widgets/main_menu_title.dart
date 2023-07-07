import 'package:flutter/material.dart';

class MainMenuTitle extends StatelessWidget {
  const MainMenuTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Guerra',
          style: TextStyle(
            letterSpacing: 4.0,
            color: Colors.red,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            fontSize: 40,
          ),
        ),
        Text(
          'Civil',
          style: TextStyle(
            letterSpacing: 4.0,
            color: Colors.yellow,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            fontSize: 40,
          ),
        ),
        Text(
          'Española',
          style: TextStyle(
            letterSpacing: 4.0,
            color: Colors.red,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            fontSize: 40,
          ),
        )
      ],
    );
  }
}
