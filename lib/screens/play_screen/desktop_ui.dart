import 'package:basic/screens/play_screen/mobile_ui.dart';
import 'package:basic/screens/play_screen/widgets/inventory_widget.dart';
import 'package:basic/screens/play_screen/widgets/rewards_widget.dart';
import 'package:basic/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesktopUI extends StatelessWidget {
  final Size size;
  const DesktopUI(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    final double width = size.width / 2.5 > 338 ? size.width / 2.5 : 338;
    // final double width = size.width / 3;
    final palette = context.read<Palette>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          // color: palette.backgroundPlaySession,
          width: width,
          child: MobileUI(Size(width, size.height)),
        ),
        SizedBox(
          width: 1,
        ),
        Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: palette.darkPen,
              // borderRadius: BorderRadius.circular(12),
              border: Border.all(color: palette.darkPen.withAlpha(200)),
            ),
            // padding: EdgeInsets.only(left: 24),
            width: size.width - width - 1,
            // color: Colors.amber.shade300,
            // padding: EdgeInsets.zero,
            child: CustomScrollView(slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate([
                InventoryWidget(Size(size.width - width - 18, size.height)),
                SizedBox(height: 12),
                RewardsWidget(size)
              ]))
            ])),
        // Visibility(
        //     visible: size.width > 1200,
        //     child: SizedBox(
        //       width: 64,
        //     ))
      ],
    );
  }
}
