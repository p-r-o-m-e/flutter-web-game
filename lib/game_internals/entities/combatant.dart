import 'package:basic/game_internals/skills/skills.dart';
import 'package:flutter/material.dart';

abstract class Combatant {
  String get getName;
  Skill get chooseMove;
  Image get getIcon;
}
