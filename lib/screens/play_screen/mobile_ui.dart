import 'package:basic/screens/play_screen/widgets/more_widget.dart';
import 'package:basic/screens/play_screen/widgets/player_profile_widget.dart';
import 'package:basic/utils/storage.dart';
import 'package:flutter/material.dart';

class MobileUI extends StatelessWidget {
  final Size size;
  // final bool spactating;
  const MobileUI(
    this.size, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //338 min width for playerprofile + padding!

    return size.width < 338 || size.height < 598
        ? Text(
            "Screen resolution is too small to fit the interface. Please contact help center if you think this error is wrongly generated.",
            style: Styles.playerTextStyle())
        : Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Expanded(flex: 5, child: PlayerProfile(size: size)),
                Expanded(flex: 2, child: MoreWidget(size))
              ],
            ),
          );
  }
}
