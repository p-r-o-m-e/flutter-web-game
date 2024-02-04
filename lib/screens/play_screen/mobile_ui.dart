import 'package:basic/screens/play_screen/more_widget.dart';
import 'package:basic/screens/play_screen/player_profile_widget.dart';
import 'package:flutter/material.dart';

class MobileUI extends StatelessWidget {
  final Size size;
  const MobileUI(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 5, child: PlayerProfile(size: size)),
        Expanded(flex: 2, child: MoreWidget(size))
      ],
    );
  }
}
