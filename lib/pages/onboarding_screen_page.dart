import 'package:civil_war/pages/intro_screens/intro_screen_1.dart';
import 'package:civil_war/pages/intro_screens/intro_screen_2.dart';
import 'package:civil_war/pages/intro_screens/intro_screen_3.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  //Controller to keep track of pages
  final PageController _controller = PageController();

  //Flag to see if we are in last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          controller: _controller,
          children: const [
            IntroScreen1(),
            IntroScreen2(),
            IntroScreen3(),
          ],
        ),
        //Dot indicators
        Container(
          alignment: const Alignment(0, 0.85),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, 'home'),
                  child: const Text(
                    'Saltar',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38.0),
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                ),
              ),
              onLastPage
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                          onTap: () =>
                              Navigator.pushReplacementNamed(context, 'home'),
                          child: const Icon(
                            Icons.play_circle,
                            size: 50,
                          )),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          child: const Icon(
                            Icons.navigate_next_outlined,
                            size: 50,
                          )),
                    )
            ],
          ),
        )
      ]),
    );
  }
}
