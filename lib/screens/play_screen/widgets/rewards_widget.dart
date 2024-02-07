import 'package:basic/style/palette.dart';
import 'package:basic/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardsWidget extends StatelessWidget {
  final Size size;
  const RewardsWidget(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();
    return Container(
      padding: EdgeInsets.all(6),
      width: size.width,
      decoration: Styles.getRewardsBoxDecor(),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 5 / 1.16,
            child: SizedBox(
              // height: 500,
              width: size.width / 2,
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
                      childAspectRatio: 5 / 1,
                      // mainAxisExtent: 50,
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 8.0,
                      // size.height / 35, // Spacing between columns
                      mainAxisSpacing: 8.0, // Spacing between rows
                    ),
                    itemCount: 4,
                    itemBuilder: (context, i) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF7D7463),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFF555843)),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.,
                            children: [
                              Icon(Icons.mail_outline_outlined),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Mail",
                                style: Styles.playerTextStyle(
                                    fontColor: palette.pen.withAlpha(200),
                                    size: size.width / 50),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          AspectRatio(
            aspectRatio: 5 / 1.16,
            child: SizedBox(
              width: size.width / 2,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(6),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 5 / 1,
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0, // Spacing between rows
                    ),
                    itemCount: 4,
                    itemBuilder: (context, i) {
                      return Container(
                        // width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF7D7463),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFF555843)),
                        ),
                        child: TextButton(
                          //Daily, Weekly, Work,
                          onPressed: () {},
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Daily",
                                style: Styles.playerTextStyle(
                                    fontColor:
                                        Color(0xFFE0DECA).withOpacity(0.9),
                                    size: size.width / 50),
                              )),
                        ),
                      );
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Text("data")
          AspectRatio(
            aspectRatio: 1 / .78,
            child: SizedBox(
              width: size.width / 2,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: GridView.builder(
                    // scrollDirection: Axis.,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(6),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 5 / 2.5,
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0, // Spacing between rows
                    ),
                    itemCount: 6,
                    itemBuilder: (context, i) {
                      return Container(
                        // width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF9A9483),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFF555843)),
                        ),
                        child: TextButton(
                          //Daily, Weekly, Work,
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                child: Image.asset(
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.contain,
                                  "assets/images/items/alchemy_herbs/2.png",
                                ),
                              ),
                              Text(
                                "Monastery",
                                style: Styles.playerTextStyle(
                                    fontColor:
                                        Color(0xFFE0DECA).withOpacity(0.9),
                                    size: size.width / 50),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
