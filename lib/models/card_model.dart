// To parse this JSON data, do
//
//     final cardResponse = cardResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

class CardModel {
  CardModel({
    this.uniqueId,
    required this.cardNumber,
    required this.cardTitle,
    required this.imageAsset,
    required this.description,
    required this.isDiscovered,
  });

  int? uniqueId;
  int cardNumber;
  String cardTitle;
  String imageAsset;
  String description;
  bool isDiscovered;

  factory CardModel.fromRawJson(String str) =>
      CardModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        cardTitle: json["cardTitle"],
        cardNumber: json["cardNumber"],
        imageAsset: json["imageAsset"],
        description: json["description"],
        isDiscovered: false,
      );

  Map<String, dynamic> toJson() => {
        "cardTitle": cardTitle,
        "cardNumber": cardNumber,
        "imageAsset": imageAsset,
        "description": description,
      };
}
