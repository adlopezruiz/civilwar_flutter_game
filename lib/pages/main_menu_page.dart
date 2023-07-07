import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:civil_war/providers/game_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/main_menu_option_button.dart';
import '../widgets/main_menu_title.dart';
import '../widgets/custom_circular_button.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 80;

    if (width >= 900) width = MediaQuery.of(context).size.width / 2 - 80;

    GamePageProvider gameProvider = Provider.of<GamePageProvider>(context);

    return Container(
      color: const Color(0xFF272837),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const MainMenuTitle(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCircularButton(
                      icon: FontAwesomeIcons.info,
                      onTap: () => AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            width: 380,
                            buttonsBorderRadius: const BorderRadius.all(
                              Radius.circular(2),
                            ),
                            dismissOnTouchOutside: true,
                            dismissOnBackKeyPress: false,
                            headerAnimationLoop: true,
                            animType: AnimType.bottomSlide,
                            title: 'INFO',
                            desc:
                                'Esta APP ha sido desarrollada por Adrián López, alumno de 2º DAM con fines educativos.',
                            showCloseIcon: true,
                            btnOkText: 'Ok crack!',
                            btnOkOnPress: () {},
                          ).show()),
                  CustomCircularButton(
                      icon: FontAwesomeIcons.medal,
                      onTap: () => AwesomeDialog(
                              context: context,
                              customHeader: const FaIcon(
                                FontAwesomeIcons.medal,
                                size: 60,
                              ),
                              width: 380,
                              buttonsBorderRadius: const BorderRadius.all(
                                Radius.circular(2),
                              ),
                              dismissOnTouchOutside: true,
                              dismissOnBackKeyPress: false,
                              animType: AnimType.leftSlide,
                              title: 'TOP PLAYER',
                              desc:
                                  'El mejor jugador hasta ahora es ${gameProvider.topPlayerName}',
                              showCloseIcon: true,
                              btnOkText: 'A por el!',
                              btnOkOnPress: () {})
                          .show()),
                  CustomCircularButton(
                      icon: FontAwesomeIcons.lightbulb,
                      onTap: () => AwesomeDialog(
                            context: context,
                            customHeader: const FaIcon(
                              FontAwesomeIcons.lightbulb,
                              size: 60,
                            ),
                            width: 380,
                            buttonsBorderRadius: const BorderRadius.all(
                              Radius.circular(2),
                            ),
                            dismissOnTouchOutside: true,
                            dismissOnBackKeyPress: false,
                            animType: AnimType.rightSlide,
                            title: 'TIP',
                            desc:
                                'No seas ansia y lee la info! No perderas puntos ni nada!',
                            showCloseIcon: true,
                            btnOkText: 'Entendido',
                            btnOkOnPress: () {},
                          ).show()),
                ],
              ),
              Wrap(
                spacing: 10,
                runSpacing: 25,
                children: [
                  MenuOptionButton(
                    title: 'Nueva partida',
                    subtitle: 'Encuentra todas las parejas',
                    icon: FontAwesomeIcons.play,
                    color: const Color(0xFF2F80ED),
                    width: width,
                    onTap: () => formCustomDialog(context, gameProvider),
                  ),
                  MenuOptionButton(
                    title: 'Ranking',
                    subtitle: 'Se el mejor! Gana a tus compis!',
                    icon: FontAwesomeIcons.rankingStar,
                    color: const Color(0xFFDF1D5A),
                    width: width,
                    onTap: () => Navigator.pushNamed(context, 'ranking'),
                  ),
                  MenuOptionButton(
                    title: 'Ver tutorial',
                    subtitle: 'Volver a ver el tutorial!',
                    icon: FontAwesomeIcons.question,
                    color: const Color(0xFF45D280),
                    width: width,
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, 'onboarding'),
                  ),
                  MenuOptionButton(
                    title: 'Salir',
                    subtitle: 'Nunca te rindas!',
                    icon: FontAwesomeIcons.rightFromBracket,
                    color: const Color(0xFFFF8306),
                    width: width,
                    onTap: () {
                      exit(0);
                    },
                  )
                ],
              ),
              const Text(
                'Created by Adrian Lopez',
                style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 12,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void formCustomDialog(BuildContext context, GamePageProvider gamePageProvider) {
  late AwesomeDialog dialog;
  final textController = TextEditingController();
  dialog = AwesomeDialog(
    width: 380,
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.question,
    keyboardAware: true,
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            'Introduce tu nombre',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Material(
            elevation: 0,
            color: Colors.blueGrey.withAlpha(40),
            child: TextFormField(
              controller: textController,
              autofocus: true,
              minLines: 1,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Nombre',
                prefixIcon: Icon(Icons.text_fields),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          AnimatedButton(
            isFixedHeight: false,
            text: 'Jugar!',
            pressEvent: () {
              gamePageProvider.playerName = textController.text;
              dialog.dismiss();
              Navigator.pushNamed(context, 'game');
            },
          )
        ],
      ),
    ),
  )..show();
}
