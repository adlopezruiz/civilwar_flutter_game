import 'package:flutter/material.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFF2F80ED),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/nombre.png',
                  height: MediaQuery.of(context).size.height / 2 + 100,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Registrate',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Así luego podrás elegir si quieres participar en el ranking',
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
