import 'dart:async';
// import 'dart:html';
// import 'dart:io';
// import 'dart:math';

import 'package:basic/game_internals/battletools/battle_manager.dart';
import 'package:basic/screens/level_selection/adventure_action_widget.dart';
import 'package:basic/screens/level_selection/levels.dart';
import 'package:basic/utils/storage.dart';
import 'package:flutter/material.dart';

void showAdventureSelector(BuildContext context, GameLevel level) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) =>
        AdventureSelectorWidget(animation, level),
  );
}

class AdventureSelectorWidget extends StatefulWidget {
  final Animation<double> animation;
  final GameLevel level;
  const AdventureSelectorWidget(this.animation, this.level, {super.key});

  @override
  State<AdventureSelectorWidget> createState() =>
      _AdventureSelectorWidgetState();
}

class _AdventureSelectorWidgetState extends State<AdventureSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    // final bool special = Random().nextBool();
    bool active = true;

    Future.delayed(Duration(seconds: 14), () {
      if (mounted && active) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    });
    return ScaleTransition(
        scale: CurvedAnimation(
            parent: widget.animation, curve: Curves.fastEaseInToSlowEaseOut),
        child: SimpleDialog(
          // backgroundColor: Colors..withAlpha(150),
          title: Text('Select action', style: TextStyle(fontFamily: 'LTC')),
          children: [
            SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                showAdventureWindow(BattleType.training);
              },
              child: Text('Train',
                  style: Styles.playerTextStyle(
                      size: 14,
                      fontColor: Colors
                          .white38)), //AmberAccent gives golden color, good for special effect
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                showAdventureWindow(BattleType.hunt);
              },
              child: Text('Hunt',
                  style: Styles.playerTextStyle(
                      size: 14, fontColor: Colors.white38)),
            ),
            TextButton(
              onPressed: () {
                // showAdventureWindow();
                Navigator.pop(context);
                showAdventureWindow(BattleType.conquest);
              },
              child: Text('Conquest',
                  style: Styles.playerTextStyle(
                      size: 14, fontColor: Colors.white38)),
            ),
            TextButton(
              onPressed: () {
                // showAdventureWindow();
                Navigator.pop(context);
                // showAdventureWindow();
              },
              child: Text('Expedition',
                  style: Styles.playerTextStyle(
                      size: 14, fontColor: Colors.white38)),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 4,
            ),
            TextButton(
              onPressed: () {
                // _timer.cancel();
                active = false;
                Navigator.pop(context);
              },
              child: Text(
                'Leave',
                style:
                    Styles.playerTextStyle(size: 13, fontColor: Colors.white24),
              ),
            )
          ],
        ));
  }

  void showAdventureWindow(BattleType battleType) {
    showAdventureWidget(
      context,
      widget.level,
      battleType,
    );
  }
}
