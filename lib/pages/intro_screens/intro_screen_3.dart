import 'package:flutter/material.dart';

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key});
  //
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFF45D280),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/ranking.png',
                  height: MediaQuery.of(context).size.height / 2 + 100,
                ),
              ),
            ),
            const Text(
              '¡Gana!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              '¡Sube tu puntuación al ranking y compite con tus amigos!',
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
