import 'package:basic/game_internals/entities/monster.dart';
import 'package:basic/game_internals/entities/combatant.dart';
import 'package:basic/game_internals/skills/skills.dart';
import 'package:flutter/src/widgets/image.dart';

class Player extends Combatant {
  final String _playername = "Player";

  @override
  String get getName => _playername;
  Monster? _follower;

  @override
  Skill get chooseMove => Skill('Punch', SkillType.physical, 100);

  @override
  // TODO: implement getIcon
  Image get getIcon => throw UnimplementedError();
}
