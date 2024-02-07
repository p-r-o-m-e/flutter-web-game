import 'package:basic/style/palette.dart';
import 'package:basic/utils/customicon.dart';
import 'package:basic/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerProfile extends StatelessWidget {
  final Size size;
  const PlayerProfile({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: palette.darkPen,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.darkPen.withAlpha(200)),
      ),
      padding: EdgeInsets.all(6),
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          Stack(children: [
            Column(
              children: [
                Container(
                  // color: Colors.red,
                  padding: EdgeInsets.only(top: 6),
                  height: Constants.uiSizeMultiplier * 2,
                  width: size.width * .9,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, iteration) {
                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                // color: Constants.statBoxColor,
                                padding: EdgeInsets.only(
                                    left: Constants.uiSizeMultiplier * .8),
                                height: Constants.uiSizeMultiplier / 3.5,
                                margin: EdgeInsets.only(
                                    left: 58, right: 8, top: 2, bottom: 2),
                                decoration: BoxDecoration(
                                  color: Constants.statBoxColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      // width: 1.5,
                                      color: Constants.statBoxBorder),
                                ),
                                child: LinearProgressIndicator(
                                  color: Constants.statBoxColor,
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(10),
                                  ),
                                  value:
                                      VolatileStorage.getFromPlayerNumbersDict([
                                            'STR',
                                            'DEF',
                                            'MP',
                                            'MR',
                                            'SPD'
                                          ][iteration]) /
                                          Constants.statCAP,
                                  backgroundColor: Constants.statBoxBG,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Constants.statBoxColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                              child: [
                                Icon(
                                  color: palette.pen,
                                  CustomFlutterIcon.fist_raised,
                                  size: Constants.uiSizeMultiplier / 4.5,
                                ),
                                Icon(CustomFlutterIcon.shield_alt,
                                    color: palette.pen,
                                    size: Constants.uiSizeMultiplier / 5),
                                Icon(CustomFlutterIcon.fire,
                                    color: palette.pen,
                                    size: Constants.uiSizeMultiplier / 4.5),
                                Icon(CustomFlutterIcon.shield_virus,
                                    color: palette.pen,
                                    size: Constants.uiSizeMultiplier / 5),
                                Icon(CustomFlutterIcon.lightning_bolt,
                                    color: palette.pen,
                                    size: Constants.uiSizeMultiplier / 3.7)
                              ][iteration],
                            )
                          ],
                        );
                      }),
                ),
              ],
            ),
            CircleAvatar(
              backgroundColor: palette.pen,
              backgroundImage: AssetImage(
                Constants.currentAvatarPath,
              ),
              radius: Constants.uiSizeMultiplier,
            ),
          ]),
          SizedBox(
            height: 24,
          ),
          // Expanded(flex: 1, child: SizedBox()),
          Container(
            padding: EdgeInsets.only(left: 12),
            margin: EdgeInsets.only(left: 2),
            decoration: Styles.getBrownBoxDecor(
                borderRadiusShape:
                    BorderRadius.horizontal(left: Radius.circular(42))),
            // BoxDecoration(
            //   color: Colors.brown.shade500,
            //   borderRadius: BorderRadius.horizontal(left: Radius.circular(42)),
            //   border: Border.all(color: Colors.brown.shade700),
            // ),
            width: size.width * .9,
            height: 72,
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                Text(
                  VolatileStorage.getPlayerName,
                  style:
                      Styles.playerTextStyle(size: 40, fontColor: palette.ink),
                ),
                SizedBox(
                  width: 20,
                ),
                Text("the\n${VolatileStorage.getPlayerTag}"),
                SizedBox(
                  width: 2,
                ),
                Expanded(flex: 2, child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextButton(
                      style: ButtonStyle(
                          mouseCursor: MaterialStateMouseCursor.clickable,
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.brown.shade600),
                          foregroundColor: MaterialStateColor.resolveWith(
                              (states) => palette.inkFullOpacity),
                          elevation: MaterialStatePropertyAll(4),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)))),
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "legacy\t${(VolatileStorage.getPlayerLegacy < 100) ? VolatileStorage.getPlayerLegacy : 'Infinity'}",
                            style: Styles.playerTextStyle(
                                size: 14,
                                fontFamily: 'LTC',
                                fontWeight: FontWeight.bold,
                                fontColor: palette.backgroundSettings),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Icon(
                            CustomFlutterIcon.person,
                            color: palette.backgroundSettings.withAlpha(150),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
          Container(
            width: size.width * .73,
            height: 12,
            color: Colors.brown.shade600,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12),
              width: size.width * .9,
              height: 120,
              decoration: Styles.getBrownBoxDecor(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment,
                  children: [
                    // SizedBox(height: 40),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              children: [
                                Icon(
                                  CustomFlutterIcon.moon,
                                  size: 14,
                                  color:
                                      palette.backgroundSettings.withAlpha(170),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(VolatileStorage.getInGameDateString(),
                                    style: Styles.playerTextStyle(
                                      fontColor:
                                          palette.inkFullOpacity.withAlpha(170),
                                    )),
                              ],
                            ),
                          ),
                          Text(VolatileStorage.getPlayerAge.toString(),
                              style: Styles.playerTextStyle(
                                  fontColor:
                                      palette.backgroundSettings.withAlpha(170),
                                  size: 54)),
                        ]),
                    Expanded(child: SizedBox()),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Deity",
                                      style: Styles.playerTextStyle(
                                        size: 14,
                                        fontColor: palette.inkFullOpacity
                                            .withAlpha(170),
                                      )),
                                  Expanded(child: SizedBox()),
                                  Text("Profession",
                                      style: Styles.playerTextStyle(
                                        size: 14,
                                        fontColor: palette.inkFullOpacity
                                            .withAlpha(170),
                                      )),
                                  Expanded(child: SizedBox()),
                                  Text("Follower",
                                      style: Styles.playerTextStyle(
                                        size: 14,
                                        fontColor: palette.inkFullOpacity
                                            .withAlpha(170),
                                      ))
                                ]),
                            // Expanded(child: SizedBox()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(VolatileStorage.getPlayerDeity,
                                        style: Styles.playerTextStyle(
                                          size: 14,
                                          fontColor: palette.inkFullOpacity
                                              .withAlpha(170),
                                        )),
                                    Expanded(child: SizedBox()),
                                    Text(VolatileStorage.getPlayerProfession,
                                        style: Styles.playerTextStyle(
                                          size: 14,
                                          fontColor: palette.inkFullOpacity
                                              .withAlpha(170),
                                        )),
                                    Expanded(child: SizedBox()),
                                    Text(VolatileStorage.getPlayerPartner,
                                        style: Styles.playerTextStyle(
                                          size: 14,
                                          fontColor: palette.inkFullOpacity
                                              .withAlpha(170),
                                        ))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
