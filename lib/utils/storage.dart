// import "dart:ffi";

import "package:basic/game_internals/entities/items.dart";
import "package:basic/game_internals/entities/monster.dart";
import "package:basic/game_internals/skills/skills.dart";
import "package:flutter/material.dart";

abstract class VolatileStorage {
  static DateTime _inGameDate = DateTime(601);

  static void advanceInGameDate(int days, {int months = 0, int years = 0}) {}

  static String getInGameDateString() {
    DateTime dateTime = _inGameDate;
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
  //Items in game
  static final Map<String, Item> _gameItems = {
    "Mushroom": Item(
        Tier.common,
        "Mushroom",
        Image.asset(
          "assets/images/items/alchemy_herbs/20.png",
        ),
        "A probably poisonous mushroom from the wild")
  };

  //monsters in game
  static final Map<String, Monster> _gameMonsters = {
    "Goblin": Monster.newMonster(
        "Goblin",
        Skill("Jab", SkillType.physical, 100),
        Image.asset("assets/images/monsters/atk/con16.png")),
    "Buzzkill": Monster.newMonster(
        "Buzzkill",
        Skill("Sting", SkillType.physical, 100),
        Image.asset("assets/images/monsters/atk/con16.png")),
    "Arachni": Monster.newMonster(
        "Arachni",
        Skill("Snare", SkillType.physical, 100),
        Image.asset("assets/images/monsters/atk/con16.png")),
    "Skeleton": Monster.newMonster(
        "Skeleton",
        Skill("Stab", SkillType.physical, 100),
        Image.asset("assets/images/monsters/atk/con16.png")),
    "Grizzly": Monster.newMonster(
        "Grizzly",
        Skill("Maul", SkillType.physical, 100),
        Image.asset("assets/images/monsters/atk/con16.png")),
    "Orc": Monster.newMonster("Orc", Skill("Smash", SkillType.physical, 100),
        Image.asset("assets/images/monsters/atk/con16.png")),
    "Viper": Monster.newMonster("Viper", Skill("Bite", SkillType.physical, 100),
        Image.asset("assets/images/monsters/atk/con16.png"))
  };
  static Monster newMonster(String monsterName) {
    if (!_gameMonsters.containsKey(monsterName)) {
      throw ArgumentError("invalid Monster name");
    }
    final monster = _gameMonsters[monsterName];
    return monster!;
  }

  static Item newItem(String itemName) {
    if (!_gameItems.containsKey(itemName)) {
      throw ArgumentError("invalid item name");
    }
    final gameItem = _gameItems[itemName]!;
    return Item(
        gameItem.tier, gameItem.name, gameItem.icon, gameItem.description);
  }

  //probability related constants
  static double followerAtkDefProbability = 0.1;
  static int get legendaryLootProbability => 1;
  static int get superRareLootProbability => 9;
  static int get rareLootProbability => 20;
  static int get commonLootProbability => 70;

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
  static List<String> get mapDirnames => ['atk', 'def', 'mp', 'mr', 'spe'];

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

  static BoxDecoration getRewardsBoxDecor(
      {BorderRadiusGeometry? borderRadiusShape}) {
    return BoxDecoration(
      color: Color(0xFF747264),
      borderRadius: borderRadiusShape ?? BorderRadius.circular(16),
      border: Border.all(color: Color(0xFF555843)),
    );
  }

  static BoxDecoration getMetalBoxDecor(
      {BorderRadiusGeometry? borderRadiusShape}) {
    return BoxDecoration(
      color: Color.fromARGB(255, 119, 119, 119),
      borderRadius: borderRadiusShape ?? BorderRadius.circular(16),
      border: Border.all(color: Color.fromARGB(255, 099, 099, 099)),
    );
  }

  static BoxDecoration getWoodBoxDecor(
      {BorderRadiusGeometry? borderRadiusShape}) {
    return BoxDecoration(
      color: Color(0xFF7a5330),
      borderRadius: borderRadiusShape ?? BorderRadius.circular(16),
      border: Border.all(color: Color(0xFF604737)),
    );
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
