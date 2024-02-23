// import 'package:basic/utils/storage.dart';
import 'dart:async';

import 'package:basic/utils/storage.dart';
import 'package:flutter/material.dart';

class GameTime extends ChangeNotifier {
  static final DateTime birthDate = DateTime(601);
  static DateTime _currentIngameTime = DateTime(601);
  final Duration _gameTimeIncrement = Duration(minutes: 2);
  // static late Timer _timer;

  GameTime() {
    _startTimer();
  }
  void _startTimer() {
    Timer.periodic(_gameTimeIncrement, (timer) {
      //TODO: need to store latest game time in server
      advanceInGameDate(1);
    });
  }

  static DateTime get getInGameDate => _currentIngameTime;

  void advanceInGameDate(int days, {int months = 0, int years = 0}) {
    _currentIngameTime = DateTime(_currentIngameTime.year + years,
        _currentIngameTime.month + months, _currentIngameTime.day + days);
    notifyListeners();
  }

  static String getInGameDateString() {
    DateTime dateTime = _currentIngameTime;
    String formattedDate =
        "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
    return formattedDate;
  }

  static int getAge() {
    int years = getInGameDate.year - birthDate.year;

    // Adjust the age if the player hasn't had their birthday yet this year
    if (getInGameDate.month < birthDate.month ||
        (getInGameDate.month == birthDate.month &&
            getInGameDate.day < birthDate.day)) {
      years--;
    }

    return years + Constants.playerInitAge;
  }
}
