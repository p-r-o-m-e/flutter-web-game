import 'package:basic/game_internals/entities/combatant.dart';
import '../skills/skills.dart';
import 'package:flutter/material.dart';

class Monster extends Combatant {
  Monster._(this._name, this._move, this._icon);

  final Skill _move;
  final String _name;
  final Image _icon;

  static Monster newMonster(String name, Skill move, Image icon) {
    return Monster._(name, move, icon);
  }

  @override
  Skill get chooseMove => _move;

  @override
  String get getName => _name;

  @override
  Image get getIcon => _icon;
}
