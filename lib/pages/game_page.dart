import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:civil_war/providers/game_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/game_card.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GamePageProvider gameProvider =
        Provider.of<GamePageProvider>(context);

    final screenSize = MediaQuery.of(context).size;
    final widthPadding = screenSize.width * 0.02;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              width: 380,
              buttonsBorderRadius: const BorderRadius.all(
                Radius.circular(2),
              ),
              dismissOnTouchOutside: true,
              dismissOnBackKeyPress: false,
              headerAnimationLoop: true,
              animType: AnimType.bottomSlide,
              title: 'CANCELAR',
              desc: '¿Estas seguro que deseas salir?',
              showCloseIcon: true,
              btnOkText: 'Sácame de aqui',
              btnCancelText: 'No, seguir jugando',
              btnCancelOnPress: () {},
              btnOkOnPress: () {
                Navigator.pop(context);
                gameProvider.clearData();
              },
            ).show();
          },
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        ),
        title: const Text('Encuentra las parejas'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF272837),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  '¡Suerte ${gameProvider.playerName}!',
                  style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Intentos',
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '${gameProvider.userTries}',
                          style: const TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Puntos',
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '${gameProvider.totalPoints}',
                          style: const TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (gameProvider.generatedImages.isNotEmpty)
                SizedBox(
                  width: screenSize.width > 700
                      ? screenSize.width / 3.5
                      : screenSize.width >= 450 && screenSize.width <= 900
                          ? screenSize.width / 2
                          : screenSize.width,
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: widthPadding),
                    itemCount: gameProvider.generatedImages.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: screenSize.width > 700
                            ? screenSize.width * 0.055
                            : screenSize.width >= 450 && screenSize.width <= 900
                                ? screenSize.width * 0.10
                                : screenSize.width * 0.22),
                    itemBuilder: (context, index) =>
                        GameCard(card: gameProvider.generatedImages[index]),
                  ),
                )
              else
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
