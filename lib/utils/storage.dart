// import "dart:ffi";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

abstract class VolatileStorage {
  //value format avtarSpritesheet...
  static final Map<String, Uint8List> _imageBytesDict = {};

  static Uint8List getFromImageBytesDict(String key) {
    // print(_imageBytesDict.keys);
    // print(_imageBytesDict.length);
    if (!_imageBytesDict.containsKey(key)) {
      throw ArgumentError('Invalid key : $key');
    } else {
      return _imageBytesDict[key]!;
    }
  }

  static void addtoImageBytesDict(String key, Uint8List val) {
    _imageBytesDict.update(key, (value) => val, ifAbsent: () => val);
  }

  static String getInGameDateString() {
    DateTime dateTime = DateTime(601);
    String formattedDate =
        "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
    return formattedDate;
  }

  static String get getPlayerName => 'Player';
  static String get getPlayerTag => 'Divinecrafter';
  static int get getPlayerLegacy => 00;

  static int get getPlayerAge => 21;
  static String get getPlayerDeity => 'Zeus';

  static String get getPlayerProfession => 'Priest';

  static String get getPlayerPartner => 'None';

  // static String _currentAvatarKey = 'aSs3';

  // static String getCurrentAvatarKey() {
  //   return _currentAvatarKey;
  // }

  // static void setCurrentAvatarKey(String key) {
  //   _currentAvatarKey = key;
  // }

  //player stats
  static final Map<String, int> _playerNumbersDict = {
    'STR': Constants.initStat,
    'DEF': Constants.initStat,
    'MP': Constants.initStat,
    'MR': Constants.initStat,
    'SPD': Constants.initStat
  };

  static int getFromPlayerNumbersDict(String key) {
    if (!_playerNumbersDict.containsKey(key)) {
      throw ArgumentError('Invalid key : $key');
    } else {
      return _playerNumbersDict[key]!;
    }
  }

  static void addtoPlayerNumbersDict(String key, int i) {
    _playerNumbersDict[key] = i;
  }
}

abstract class Constants {
  //UI constants
  static double get uiSizeMultiplier => 54;
  static Color get statBoxColor => Colors.brown.shade300;
  static Color get statBoxBG => Colors.brown.shade400;
  static Color get statBoxBorder => Colors.brown.shade600;

  //stat related constants
  static int get initStat => 1;
  static int get statCAP => 17;
  static int get classMargin =>
      14; //number required to get a class and also the cap for stats gained via training

  //assets related constants
  static String get currentAvatarPath =>
      "assets/images/avatars/transparent/Icon11.png";
  static String get avatarWritePath =>
      "assets/images/avatars/currentAvatar.png";

  static double get avatarSpritesheetOffsetPercentage => 7;
  static String get avatarSpritesheetPath => 'assets/images/avatars/0.png';
  static List<int> get avatarSpriteSheetColRows => [3, 3];
}

abstract class Styles {
  static TextStyle playerTextStyle({
    FontWeight fontWeight = FontWeight.normal,
    double size = 16,
    String fontFamily = 'Chelsea',
    Color? fontColor,
  }) {
    return TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: size,
        color: fontColor ?? Colors.yellow.shade200);
  }

  static BoxDecoration getBrownBoxDecor(
      {BorderRadiusGeometry? borderRadiusShape}) {
    return BoxDecoration(
      color: Colors.brown.shade500,
      borderRadius: borderRadiusShape ?? BorderRadius.circular(16),
      border: Border.all(color: Colors.brown.shade700),
    );
  }
}
