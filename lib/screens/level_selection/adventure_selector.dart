import 'dart:async';
// import 'dart:html';
import 'dart:io';
import 'dart:math';

// import 'package:basic/style/palette.dart';
import 'package:basic/screens/level_selection/adventure_action_widget.dart';
import 'package:basic/utils/storage.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

void showAdventureSelector(BuildContext context, int level) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) =>
        AdventureSelectorWidget(animation, level),
  );
}

class AdventureSelectorWidget extends StatefulWidget {
  final Animation<double> animation;
  final int level;
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

                showAdventureWindow();
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
                showAdventureWindow();
              },
              child: Text('Hunt',
                  style: Styles.playerTextStyle(
                      size: 14, fontColor: Colors.white38)),
            ),
            TextButton(
              onPressed: () {
                // showAdventureWindow();
                Navigator.pop(context);
                showAdventureWindow();
              },
              child: Text('Conquest',
                  style: Styles.playerTextStyle(
                      size: 14, fontColor: Colors.white38)),
            ),
            TextButton(
              onPressed: () {
                // showAdventureWindow();
                Navigator.pop(context);
                showAdventureWindow();
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

  void showAdventureWindow() {
    // Future.delayed(Durations.extralong4);
    final File map = loadRandomMapImageFile(widget.level);
    showAdventureWidget(
        context,
        Image.file(
          map,
          fit: BoxFit.cover,
          // width: 150,
          // height: 150,
        ),
        widget.level);
  }

  File loadRandomMapImageFile(int level) {
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
