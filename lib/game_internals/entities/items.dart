import 'dart:math';

import 'package:flutter/material.dart';

class Item {
  final ItemClass itemClass;
  final Tier tier;
  final String name;
  final Image icon;
  int count;
  final String description;

  void setCount(int count) {
    this.count = count;
  }

  Item(this.tier, this.name, this.icon, this.description,
      {this.itemClass = ItemClass.miscellaneous, this.count = 1});
}

enum Tier { common, rare, superRare, legendary }

enum ItemClass { equipment, miscellaneous }

class RewardPool {
  final List<Item> legendary;
  final List<Item> superRare;
  final List<Item> rare;
  final List<Item> common;
  const RewardPool(this.common, this.rare, this.superRare, this.legendary);

  static Tier rollForTier(int legendaryWeight, int superRareWeight,
      int rareWeight, int commonWeight) {
    int totalWeight =
        legendaryWeight + superRareWeight + rareWeight + commonWeight;
    int randomValue = (Random().nextDouble() * totalWeight).toInt();
    final List<int> weightList = [
      legendaryWeight,
      superRareWeight,
      rareWeight,
      commonWeight
    ];
    final List<Tier> tierList = [
      Tier.legendary,
      Tier.superRare,
      Tier.rare,
      Tier.common
    ];
    int cumulativeWeight = 0;
    for (int i = 0; i < 4; i++) {
      cumulativeWeight += weightList[i];
      if (randomValue <= cumulativeWeight && weightList[i] != 0) {
        return tierList[i];
      }
    }
    throw ArgumentError("no hits for any tier in the roll");
  }

  static RewardPool randomizePool(RewardPool rewardPool,
      {double volatility = 0.4}) {
    if (volatility >= 1) {
      return rewardPool;
    } else if (volatility < 0.1) {
      throw ArgumentError("volatility should be in the range from 0.1 to 1.0");
    } else {
      var resultPool = rewardPool;
      Random random = Random();
      for (var item in rewardPool.common) {
        // print(item.count);
        // print((item.count * volatility).floor());
        resultPool.common[rewardPool.common.indexOf(item)].setCount(item.count -
            (
                // ((item.count * volatility).floor()) + 1 == 0
                //   ? 0
                // :
                random.nextInt(((item.count * volatility).round()) + 1)));
      }
      for (var item in rewardPool.rare) {
        resultPool.rare[rewardPool.rare.indexOf(item)].setCount(item.count -
            // (
            // (item.count * volatility).floor()) + 1 == 0
            // ? 0
            // :
            random.nextInt(((item.count * volatility).round()) + 1));
      }
      for (var item in rewardPool.superRare) {
        resultPool.superRare[rewardPool.superRare.indexOf(item)]
            .setCount(item.count -
                // ((item.count * volatility).floor()) + 1 == 0
                // ? 0
                // :
                random.nextInt(((item.count * volatility).round()) + 1));
      }
      for (var item in rewardPool.legendary) {
        resultPool.legendary[rewardPool.legendary.indexOf(item)]
            .setCount(item.count -
                // ((item.count * volatility).floor()) + 1 == 0
                // ? 0
                // :
                random.nextInt(((item.count * volatility).round()) + 1));
      }

      return rewardPool;
    }
  }
}
