// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:basic/game_internals/entities/items.dart';
import 'package:basic/game_internals/entities/monster.dart';

//skip importing the entire class if getting app speed / lag issue
import 'package:basic/utils/storage.dart' show Constants;

final gameLevels = [
  GameLevel(
    number: 1,

    rewardPoolList: {'Mushroom': 5},
    monsterPoolList: [
      "Goblin",
      "Buzzkill",
      "Skeleton",
      "Arachni",
      "Grizzly",
      "Viper",
      "Orc"
    ],
    // TODO: When ready, change these achievement IDs.
    // You configure this in App Store Connect.
    achievementIdIOS: 'first_win',
    // You get this string when you configure an achievement in Play Console.
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
  GameLevel(
    number: 2, rewardPoolList: {},
    monsterPoolList: [],
    // difficulty: 42,
  ),
  GameLevel(
    number: 3, rewardPoolList: {},
    monsterPoolList: [],
    // difficulty: 100,
    // achievementIdIOS: 'finished',
    // achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
  ),
  GameLevel(
    number: 4, rewardPoolList: {},
    monsterPoolList: [],
    // difficulty: 100,
    // achievementIdIOS: 'finished',
    // achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
  ),
  GameLevel(number: 5, rewardPoolList: {}, monsterPoolList: []
      // difficulty: 100,
      // achievementIdIOS: 'finished',
      // achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
      ),
];

class GameLevel {
  final int number;
  final Map<String, int> rewardPoolList;
  final List<String> monsterPoolList;

  /// The achievement to unlock when the level is finished, if any.
  final String? achievementIdIOS;

  final String? achievementIdAndroid;

  bool get awardsAchievement => achievementIdAndroid != null;

  Monster getRandomMob() {
    final Random random = Random();
    return Constants.newMonster(
        monsterPoolList[random.nextInt(monsterPoolList.length - 1)]);
  }

  RewardPool getRandomizedRewardPool({double volatility = 0.4}) {
    final List<Item> legendary = [];
    final List<Item> superRare = [];
    final List<Item> rare = [];
    final List<Item> common = [];

    for (var itemName in rewardPoolList.keys) {
      final Item item = Constants.newItem(itemName);
      item.setCount(rewardPoolList[itemName]!);
      switch (item.tier) {
        case Tier.common:
          common.add(item);
        case Tier.rare:
          rare.add(item);
        case Tier.superRare:
          superRare.add(item);
        case Tier.legendary:
          legendary.add(item);
        default:
          throw ArgumentError(
              "level contains invalid reward names or issue with item generation parameters.");
      }
    }

    return RewardPool.randomizePool(
        RewardPool(common, rare, superRare, legendary),
        volatility: 0.4);
  }

  GameLevel({
    required this.number,
    required this.monsterPoolList,
    required this.rewardPoolList,

    // required this.difficulty,
    this.achievementIdIOS,
    this.achievementIdAndroid,
  }) : assert(
            (achievementIdAndroid != null && achievementIdIOS != null) ||
                (achievementIdAndroid == null && achievementIdIOS == null),
            'Either both iOS and Android achievement ID must be provided, '
            'or none');
}
