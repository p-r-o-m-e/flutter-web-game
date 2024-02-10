// import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:basic/game_internals/battletools/battle_manager.dart';
import 'package:basic/game_internals/entities/monster.dart';
import 'package:basic/game_internals/entities/Player.dart';
import 'package:basic/game_internals/entities/combatant.dart';
import 'package:basic/game_internals/skills/skills.dart';
import 'package:basic/screens/level_selection/levels.dart';
import 'package:basic/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';

void showAdventureWidget(
    BuildContext context, GameLevel area, BattleType battleType) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) =>
        AdventureActionWidget(animation, area, battleType),
  );
}

class AdventureActionWidget extends StatefulWidget {
  final GameLevel area;
  // final Image bgImage;
  final BattleType battleType;
  final Animation<double> animation;
  const AdventureActionWidget(this.animation, this.area, this.battleType,
      {super.key});

  @override
  State<AdventureActionWidget> createState() => _AdventureActionWidgetState();
}

class _AdventureActionWidgetState extends State<AdventureActionWidget> {
  bool completed = false;
  late final Image bgImage;
  late final String text;

  @override
  void initState() {
    final Combatant opponent = widget.battleType == BattleType.conquest
        ? Monster.newMonster(
            "Boss",
            Skill("Boss move", SkillType.physical, 200),
            Image.asset("assets/images/monsters/atk/con16.png"))
        : newMonsterfromMap(widget.area.number);
    bgImage = Image.file(
      loadRandomMapImageFile(widget.area.number),
      fit: BoxFit.cover,
    );
    final rewards = widget.battleType == BattleType.hunt
        ? widget.area.getRandomizedRewardPool()
        : null;
    text = BattleManager.getBattleReport(
        Battle(
          BattleType.hunt,
          Player(),
          opponent,
        ),
        redRewardPool: rewards);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: CurvedAnimation(
            parent: widget.animation, curve: Curves.fastEaseInToSlowEaseOut),
        child: SimpleDialog(
          // backgroundColor: Colors..withAlpha(150),
          title: Text('Adventure report: Area#${widget.area.number}',
              style: TextStyle(
                  fontFamily: 'LTC',
                  fontSize: 21,
                  fontWeight: FontWeight.w500)),
          children: [
            SizedBox(
              width: 160,
              // height: 20,
              child: bgImage,
            ),
            Container(
              height: 160,
              padding: const EdgeInsets.only(left: 4, top: 4),
              child: AnimatedTextKit(
                pause: Durations.short1,
                isRepeatingAnimation: false,
                totalRepeatCount: 1,
                animatedTexts: [TyperAnimatedText(text)],
                onFinished: () {
                  setState(() {
                    completed = true;
                  });
                },
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigator.pop(context);
                completed == true ? Navigator.pop(context) : null;
              },
              child: Text(
                'Leave',
                style: Styles.playerTextStyle(
                    size: 13,
                    fontColor: completed == true
                        ? Colors.white24
                        : Colors.black.withOpacity(0.6)),
              ),
            )
          ],
        ));
  }

  Monster newMonsterfromMap(int level) {
    return widget.area.getRandomMob();
  }

  static File loadRandomMapImageFile(int level) {
    final Directory mapDir =
        Directory('assets/images/bg/${Constants.mapDirnames[level - 1]}');
    late File randomImageFile;
    Random random = Random();

    List<FileSystemEntity> fileList = mapDir.listSync();
    List<File> imgFileList = fileList.whereType<File>().toList();

    randomImageFile = imgFileList[random.nextInt(imgFileList.length)];
    return randomImageFile;
  }
}
