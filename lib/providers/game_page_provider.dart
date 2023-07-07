import 'package:civil_war/services/firebase_service.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

import '../models/card_model.dart';

class GamePageProvider extends ChangeNotifier {
  List<CardModel> generatedImages = [];
  String playerName = "";
  int totalPoints = 0; //MAX 1000
  int failedAt0pointDecrement =
      0; //Controls de number of times that user fails while 0 points
  int userTries = 0; //For each try, - 10 points
  int discoveredCards = 0;
  //Boolean controllers (triggers)
  bool cardCanBeTouched = false;
  bool isFirstLoad = true;
  bool isGameEnded = false;
  bool showCardFullInfo = false;

  //Cards controllers
  int card1Flipped = -1;
  int card2Flipped = -2;

  int lastFlippedCardID = -1;

  late FlipCardController card1Controler;
  late FlipCardController card2Controler;

  //Top player name
  String topPlayerName = '';

  GamePageProvider() {
    initData();
  }

  void initData() async {
    generatedImages = await FireBaseService().getCardsData();

    //Duplicate array logic, i want to have unique IDs appart from card number
    int newId = 10;

    for (var i = 0; i < 10; i++) {
      var tempCard = generatedImages[i];
      var newCard = CardModel(
          cardNumber: tempCard.cardNumber,
          cardTitle: tempCard.cardTitle,
          imageAsset: tempCard.imageAsset,
          description: tempCard.description,
          isDiscovered: tempCard.isDiscovered,
          uniqueId: newId++);
      generatedImages.add(newCard);
    }

    for (var card in generatedImages) {
      print(card.uniqueId);
    }

    //Do magic shuffle!
    generatedImages.shuffle();

    print('Provider initializated');
    print('Cards loaded and shufled');

    FireBaseService().getRanking().then((value) {
      topPlayerName = value[0]['playerName'];
    });
    notifyListeners();
  }

  void clearCards() {
    //Cards controllers
    card1Flipped = -1;
    card2Flipped = -2;
  }

  //Clears variables of the provider
  void clearData() {
    generatedImages.shuffle();

    for (var card in generatedImages) {
      card.isDiscovered = false;
    }

    playerName = "";
    totalPoints = 0; //MAX 1000
    userTries = 0; //For each try, - 10 points
    discoveredCards = 0;
    failedAt0pointDecrement = 0;
    //Boolean controllers (triggers)
    cardCanBeTouched = false;
    isFirstLoad = true;
    isGameEnded = false;
    showCardFullInfo = false;
    lastFlippedCardID = -1;
    //Cards controllers
    card1Flipped = -1;
    card2Flipped = -2;
  }

  void blockTouch() {
    print('BLOQUEADAS');
    cardCanBeTouched = false;
    notifyListeners();
  }

  void unblockTouch() {
    print('DESBLOQUEADAS');
    cardCanBeTouched = true;
    notifyListeners();
  }

  //Method controlling full game logic
  void areCardsEquals() {
    if (card1Flipped != card2Flipped) {
      print('son diferentes');
      card1Controler.state!.isFront = false;
      card2Controler.state!.isFront = false;
      if (!card1Controler.state!.isFront && !card2Controler.state!.isFront) {
        Future.delayed(
            const Duration(seconds: 1), () => card1Controler.toggleCard());
        Future.delayed(const Duration(seconds: 1), () {
          card2Controler.toggleCard();
          unblockTouch();
        });
      }
      userTries++;
      if (totalPoints > 0) {
        totalPoints -= 10;
      } else {
        failedAt0pointDecrement += 10;
      }
      clearCards();
    } else {
      print('SON IGUALES!!');
      discoveredCards++;
      //Emit event to show full card info
      showCardFullInfo = true;
      //Icrement points
      totalPoints += 100;
      //Unlock cards
      clearCards();
      unblockTouch();
    }
  }

  //Notifies game is ended
  gameEndCheck() {
    if (discoveredCards == 10) {
      isGameEnded = true;
      totalPoints -= failedAt0pointDecrement;
      notifyListeners();
    }
  }

  void saveUserToFirebase() {
    FireBaseService().uploadUserToRanking(playerName, totalPoints, userTries);
    clearData();
  }

  CardModel getPrevCard(int cardNumberParam, int uniqueIdParam) {
    List<CardModel> pairCards = generatedImages
        .where((card) =>
            card.cardNumber == cardNumberParam &&
            card.uniqueId != uniqueIdParam)
        .toList();

    return pairCards[0];
  }
}
