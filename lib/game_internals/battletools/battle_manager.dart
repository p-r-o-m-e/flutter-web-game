import 'dart:math';

import 'package:basic/game_internals/entities/combatant.dart';
import 'package:basic/game_internals/entities/items.dart';
import 'package:basic/utils/storage.dart';

class BattleManager {
  static BattleReport getBattleReport(Battle battle,
      {RewardPool? redRewardPool, RewardPool? blueRewardPool}) {
    final Random random = Random();

    final bool redFollowerAtk =
        random.nextDouble() < Constants.followerAtkDefProbability;
    final bool redFollowerDef =
        random.nextDouble() < Constants.followerAtkDefProbability;
    final bool blueFollowerAtk =
        random.nextDouble() < Constants.followerAtkDefProbability;
    final bool blueFollowerDef =
        random.nextDouble() < Constants.followerAtkDefProbability;

    //using a flat value for damage dealt/taken for now
    final int redDamage = 90;
    final int blueDamage = 90;

    String res = "";
    String encounterText = "";

    String redMoveText = "";
    String blueFollowerBlockText = "";
    String redFollowerAttackText = "";
    String blueDamageTakenText = "";

    String blueMoveText = "";
    String redFollowerBlockText = "";
    String blueFollowerAttackText = "";
    String redDamageTakenText = "";

    String rewardsText = "";

    encounterText =
        '${battle.red.getName} ${battle.battleType == BattleType.duel ? 'Vs' : 'encountered ${[
            'a',
            'e',
            'i',
            'o',
            'u'
          ].contains(battle.blue.getName[0].toLowerCase()) ? 'an' : 'a'}'} ${battle.blue.getName}.\n';

    redMoveText =
        '${battle.red.getName} used ${battle.red.chooseMove.getName}.\n';
    //ignoring pet atk/def mechanics for now
    blueDamageTakenText = '${battle.blue.getName} took $redDamage% damage!\n';

    blueMoveText =
        '${battle.blue.getName} used ${battle.blue.chooseMove.getName}.\n';
    redDamageTakenText = '${battle.red.getName} took $blueDamage% damage!\n';

    final List<Item> redRewardslotteryResult = [];

    // extract and process rewards
    if (redRewardPool == null) {
      rewardsText = '${battle.red.getName} received :\nNo rewards';
    } else {
      final int legendaryWeight = redRewardPool.legendary.isEmpty
          ? 0
          : Constants.legendaryLootProbability;
      final int superRareWeight = redRewardPool.superRare.isEmpty
          ? 0
          : Constants.superRareLootProbability;
      final int rareWeight =
          redRewardPool.rare.isEmpty ? 0 : Constants.rareLootProbability;
      final int commonWeight =
          redRewardPool.common.isEmpty ? 0 : Constants.commonLootProbability;
      for (int i = 0; i < 1; i++) {
        final Tier lotteryTier = RewardPool.rollForTier(
            legendaryWeight, superRareWeight, rareWeight, commonWeight);
        // print("$lotteryTier" + "$legendaryWeight");
        switch (lotteryTier) {
          case Tier.legendary:
            redRewardslotteryResult.add(redRewardPool
                .legendary[random.nextInt(redRewardPool.legendary.length)]);
            break;
          case Tier.superRare:
            redRewardslotteryResult.add(redRewardPool
                .superRare[random.nextInt(redRewardPool.superRare.length)]);
          case Tier.rare:
            redRewardslotteryResult.add(
                redRewardPool.rare[random.nextInt(redRewardPool.rare.length)]);
            break;
          case Tier.common:
            redRewardslotteryResult.add(redRewardPool
                .common[random.nextInt(redRewardPool.common.length)]);
            break;
          default:
          // throw ArgumentError("not hitting ");
        }
      }

      rewardsText = "${battle.red.getName} received :";
      if (redRewardslotteryResult.isNotEmpty) {
        for (var element in redRewardslotteryResult) {
          rewardsText += '\n ${element.name}(${element.count})';
        }
      } else {
        rewardsText += '\nNo rewards';
      }
    }

    res = encounterText +
        redMoveText +
        blueFollowerBlockText +
        redFollowerAttackText +
        blueDamageTakenText +
        blueMoveText +
        redFollowerBlockText +
        blueFollowerAttackText +
        redDamageTakenText +
        rewardsText;
    return BattleReport(res, redRewardslotteryResult);
  }
}

class BattleReport {
  final String text;
  final List<Item> rewards;
  BattleReport(this.text, this.rewards);
}

class Battle {
  final BattleType battleType;
  final Combatant red;
  final Combatant blue;

  late final Combatant? redFollower;
  late final Combatant? blueFollower;

  Battle(this.battleType, this.red, this.blue);
}

enum BattleType { training, hunt, hordeHunt, conquest, duel }
