import 'dart:convert';

import 'package:civil_war/models/card_model.dart';
import 'package:http/http.dart';

class FireBaseService {
  final String _baseURL = 'REALTIME DATABASE URL';

  Future<List<CardModel>> getCardsData() async {
    List<CardModel> cardList = [];

    Response response = await get(Uri.parse('${_baseURL}cards.json'));

    Map<String, dynamic> mapResponse = jsonDecode(response.body);

    int counter = 0;
    mapResponse.forEach((key, value) {
      CardModel tempCard = CardModel.fromJson(value);
      tempCard.uniqueId = counter++;
      tempCard.isDiscovered = false;
      cardList.add(tempCard);
    });

    return cardList;
  }

  //Post user to ranking
  Future<void> uploadUserToRanking(
      String userName, int userPoints, int userTries) async {
    await post(Uri.parse('${_baseURL}ranking.json'),
        body: jsonEncode({
          "playerName": userName,
          "points": userPoints,
          "tries": userTries
        }));
  }

  Future<List<dynamic>> getRanking() async {
    List<Map<String, dynamic>> rankingList = [];

    Response response = await get(Uri.parse('${_baseURL}ranking.json'));

    Map<String, dynamic> parsedMap = jsonDecode(response.body);

    int counter = 0;
    //Fill list
    parsedMap.forEach((key, value) {
      rankingList.add(value);
    });

    rankingList.sort((a, b) => (b['points'].compareTo(a['points'])));

    return rankingList;
  }
}
