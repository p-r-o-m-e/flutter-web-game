import "package:flutter/material.dart";

abstract class VolatileStorage {
  static final Map<String, Image> imageDict = {};

  static void addtoStringImageDict(String key, Image value) {
    imageDict[key] = value;
  }
}

abstract class Constants {
  static String get avatarSpritesheetPath => 'assets/images/avatars/0.png';
  static List<int> get avatarSpriteSheetColRows => [3, 3];
}
