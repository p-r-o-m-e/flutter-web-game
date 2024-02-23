// import 'package:basic/style/palette.dart';
import 'package:basic/utils/customicon.dart';
import 'package:basic/utils/storage.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class InventoryWidget extends StatelessWidget {
  final Size size;
  const InventoryWidget(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    // final palette = context.read<Palette>();
    // size.width >
    return SizedBox(
      width: size.width,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 12),
            margin: EdgeInsets.only(left: 2),
            decoration: Styles.getWoodBoxDecor(
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(flex: 3, child: SizedBox()),
                Text(
                  'Inventory',
                  style: Styles.playerTextStyle(
                      size: 40,
                      fontColor: Color(0xFF59392c).withAlpha(250),
                      fontFamily: 'LTC',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(flex: 2, child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextButton(
                      style: ButtonStyle(
                          mouseCursor: MaterialStateMouseCursor.clickable,
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color(0xFF6A452A).withOpacity(0.8)),
                          // foregroundColor: MaterialStateColor.resolveWith(
                          //     (states) => palette.inkFullOpacity),
                          elevation: MaterialStatePropertyAll(4),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)))),
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            CustomFlutterIcon.box,
                            color: Color(0xFF59392c),
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
            color: Color(0xFF6A452A),
          ),
          AspectRatio(
            aspectRatio: 4.9 / 3,
            child: Container(
              // height: size.height / 2,
              // padding: EdgeInsets.symmetric(vertical: 8),
              width: size.width * .9,
              // height: 120,
              decoration: Styles.getWoodBoxDecor(),
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    // addSemanticIndexes: true,
                    // semanticChildCount: 20,
                    // clipBehavior: Clip.antiAliasWithSaveLayer,
                    // shrinkWrap: true,
                    padding: EdgeInsets.all(6),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      // childAspectRatio: 1,
                      // mainAxisExtent: 50,
                      crossAxisCount: 5, // Number of columns
                      crossAxisSpacing: 8.0,
                      // size.height / 35, // Spacing between columns
                      mainAxisSpacing: 8.0, // Spacing between rows
                    ),
                    itemCount: 15,
                    itemBuilder: (context, i) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFa57847),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFF604737)),
                        ),
                        child: Stack(children: [
                          VolatileStorage.getFromInventoryByIndex(i) != null
                              ? Center(
                                  child: Image(
                                    image:
                                        VolatileStorage.getFromInventoryByIndex(
                                                i)!
                                            .icon
                                            .image,
                                    // fit: BoxFit.cover,
                                    height: 64,
                                    width: 64,
                                  ),
                                )
                              : Center(
                                  child: Icon(
                                    Icons.grid_3x3_outlined,
                                    color: Color(0xFF604737).withOpacity(0.3),
                                  ),
                                ),
                          Positioned(
                            bottom: 8,
                            right: 10,
                            child: Text(
                              "${VolatileStorage.getFromInventoryByIndex(i) != null ? VolatileStorage.getFromInventoryByIndex(i)!.count : ""}",
                              style: Styles.playerTextStyle(
                                  size: 16,
                                  fontColor:
                                      Colors.lime.shade300.withOpacity(0.5)),
                            ),
                          )
                        ]),
                      );
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            decoration: Styles.getMetalBoxDecor(),
            width: size.width,
            height: size.width / 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 6,
                ),
                AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 109, 109, 109),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color.fromARGB(255, 099, 099, 099)),
                      ),
                      child: ClipRect(
                        child: Icon(
                          CustomFlutterIcon.fist_raised,
                          color:
                              Color.fromARGB(255, 089, 089, 089).withAlpha(230),
                        ),
                      ),
                    )),
                SizedBox(
                  width: 6,
                ),
                AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 109, 109, 109),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color.fromARGB(255, 099, 099, 099)),
                      ),
                      child: ClipRect(
                        child: Icon(
                          CustomFlutterIcon.shield_alt,
                          color:
                              Color.fromARGB(255, 089, 089, 089).withAlpha(230),
                        ),
                      ),
                    )),
                SizedBox(
                  width: 6,
                ),
                AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 109, 109, 109),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color.fromARGB(255, 099, 099, 099)),
                      ),
                      child: ClipRect(
                        child: Icon(
                          CustomFlutterIcon.fire,
                          color:
                              Color.fromARGB(255, 089, 089, 089).withAlpha(230),
                        ),
                      ),
                    )),
                SizedBox(
                  width: 6,
                ),
                AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 109, 109, 109),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color.fromARGB(255, 099, 099, 099)),
                      ),
                      child: ClipRect(
                        child: Icon(
                          CustomFlutterIcon.shield_virus,
                          color:
                              Color.fromARGB(255, 089, 089, 089).withAlpha(230),
                        ),
                      ),
                    )),
                SizedBox(
                  width: 6,
                ),
                AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 109, 109, 109),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color.fromARGB(255, 099, 099, 099)),
                      ),
                      child: ClipRect(
                        child: Icon(
                          CustomFlutterIcon.lightning_bolt,
                          color:
                              Color.fromARGB(255, 089, 089, 089).withAlpha(230),
                        ),
                      ),
                    )),
                SizedBox(
                  width: 6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
