import 'package:basic/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void showAdventureWidget(BuildContext context, Image bgImage, int areaNumber) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) =>
        AdventureActionWidget(animation, areaNumber, bgImage),
  );
}

class AdventureActionWidget extends StatefulWidget {
  final int areaNumber;
  final Image bgImage;
  final Animation<double> animation;
  const AdventureActionWidget(this.animation, this.areaNumber, this.bgImage,
      {super.key});

  @override
  State<AdventureActionWidget> createState() => _AdventureActionWidgetState();
}

class _AdventureActionWidgetState extends State<AdventureActionWidget> {
  @override
  Widget build(BuildContext context) {
    String text = " ";
    bool completed = false;
    return ScaleTransition(
        scale: CurvedAnimation(
            parent: widget.animation, curve: Curves.fastEaseInToSlowEaseOut),
        child: SimpleDialog(
          // backgroundColor: Colors..withAlpha(150),
          title: Text('Area #${widget.areaNumber}',
              style: TextStyle(fontFamily: 'LTC')),
          children: [
            SizedBox(width: 160, child: widget.bgImage),
            AnimatedTextKit(
              animatedTexts: [TyperAnimatedText(text)],
            ),
            TextButton(
              onPressed: () {
                completed == true ? Navigator.pop(context) : null;
              },
              child: Text(
                'Leave',
                style: Styles.playerTextStyle(
                    size: 13,
                    fontColor: completed == true
                        ? Colors.white24
                        // : Colors.white.withOpacity(0.24)),

                        : Colors.black.withOpacity(0.6)),
              ),
            )
          ],
        ));
  }
}
