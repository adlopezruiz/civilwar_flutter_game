import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:civil_war/models/card_model.dart';
import 'package:civil_war/providers/game_page_provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameCard extends StatelessWidget {
  final CardModel card;

  const GameCard({
    required this.card,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GamePageProvider gameProvider =
        Provider.of<GamePageProvider>(context);
    late FlipCardController controller = FlipCardController();

    bool onTouch = gameProvider.cardCanBeTouched;

    //Flag to check if it´s been the first time flipped (Initial flip)
    bool isRecentlyLoaded = gameProvider.isFirstLoad;

    return FlipCard(
      controller: controller,
      autoFlipDuration: const Duration(seconds: 4),
      onFlipDone: (isFront) {
        if (isRecentlyLoaded) {
          gameProvider.isFirstLoad = false;
          gameProvider.unblockTouch();
        } else {
          print(card.uniqueId);
          print(gameProvider.lastFlippedCardID);
          if (card.uniqueId != gameProvider.lastFlippedCardID) {
            if (controller.state!.isFront) {
              //Check if there is empty slot in provider
              if (gameProvider.card1Flipped == -1) {
                //Save card selected to provider
                gameProvider.card1Flipped = card.cardNumber;
                //Save this one card controler in provider
                gameProvider.card1Controler = controller;
              } else if (gameProvider.card2Flipped == -2) {
                //Same but with second card
                gameProvider.card2Flipped = card.cardNumber;
                gameProvider.card2Controler = controller;
                gameProvider.blockTouch();
              }
            }
            //Check if both cards are DIFFERENT
            if (gameProvider.card1Flipped != -1 &&
                gameProvider.card2Flipped != -2) {
              gameProvider.areCardsEquals();

              if (gameProvider.showCardFullInfo) {
                card.isDiscovered = true;
                gameProvider.lastFlippedCardID = -1;
                CardModel previousCard =
                    gameProvider.getPrevCard(card.cardNumber, card.uniqueId!);
                previousCard.isDiscovered = true;
                gameProvider.blockTouch();

                //Launch dialog with extra info
                Future.delayed(const Duration(milliseconds: 400),
                    () => showFullCard(context, gameProvider));
              }
            }
          }
        }
      },
      onFlip: () {},
      side: CardSide.BACK,
      flipOnTouch: onTouch && !card.isDiscovered,
      front: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/not-discovered.PNG',
          fit: BoxFit.cover,
        ),
      ),
      back: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/${card.imageAsset}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void showFullCard(
    BuildContext context,
    GamePageProvider gameProvider,
  ) {
    AwesomeDialog(
        titleTextStyle:
            const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        descTextStyle: const TextStyle(fontSize: 19),
        context: context,
        dialogType: DialogType.info,
        width: 380,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        animType: AnimType.rightSlide,
        title: card.cardTitle,
        desc: card.description,
        showCloseIcon: true,
        btnOkText: 'Entendido',
        onDismissCallback: (type) {
          gameProvider.showCardFullInfo = false;
          gameProvider.unblockTouch();
        },
        btnOkOnPress: () {
          gameProvider.gameEndCheck();
          if (gameProvider.isGameEnded) {
            showEndGameDialog(context, gameProvider);
          }
        }).show();
  }

  void showEndGameDialog(
    BuildContext context,
    GamePageProvider gameProvider,
  ) {
    AwesomeDialog(
        titleTextStyle:
            const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        descTextStyle: const TextStyle(fontSize: 19),
        context: context,
        dialogType: DialogType.success,
        width: 380,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        animType: AnimType.rightSlide,
        title: '¡Enhorabuena!',
        desc:
            'Has encontrado todas las parejas! Espero que hayas aprendido mucho!\n ¿Quieres aparecer en el ranking?',
        showCloseIcon: false,
        btnCancelText: 'No',
        btnOkText: 'Si',
        onDismissCallback: (type) {
          Navigator.pushReplacementNamed(context, 'home');
        },
        btnCancelOnPress: () => gameProvider.clearData(),
        btnOkOnPress: () {
          gameProvider.saveUserToFirebase();
        }).show();
  }
}
