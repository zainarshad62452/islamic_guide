import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class CardModel {
  String doctor;
  int cardBackground;
  var cardIcon;

  CardModel(this.doctor, this.cardBackground, this.cardIcon);
}

List<CardModel> cards = [
  new CardModel("Bind a Mosque", 0xFFec407a, Icons.add),
  new CardModel("Find Nearby Mosque", 0xFF5c6bc0, TablerIcons.search),
  new CardModel("Set Prayer Alerts", 0xFFfbc02d, TablerIcons.alert_circle),
  new CardModel("Set Busy Modes", 0xFF1565C0, Icons.settings),
];
List<CardModel> mosqueKeeperCards = [
  new CardModel("Bind a Mosque", 0xFFec407a, Icons.add),
  new CardModel("Find Nearby Mosque", 0xFF5c6bc0, TablerIcons.search),
  new CardModel("Set Prayer Alerts", 0xFFfbc02d, TablerIcons.alert_circle),
  new CardModel("Set Busy Modes", 0xFF1565C0, Icons.settings),
  // new CardModel("Nuritions", 0xFF1565C0, Icons.food_bank_outlined),
];