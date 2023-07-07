import 'package:flutter/material.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFDF1D5A),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/juego.png',
                  height: MediaQuery.of(context).size.height / 2 + 100,
                ),
              ),
            ),
            const Text(
              '¡Descubre!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Haz memoria y encuentra todas las parejas de cartas. Pero cuidado, cada fallo resta puntos!',
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
