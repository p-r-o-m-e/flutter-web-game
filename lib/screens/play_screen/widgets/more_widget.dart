import 'package:go_router/go_router.dart';

import 'package:basic/utils/storage.dart';
import 'package:flutter/material.dart';

class MoreWidget extends StatelessWidget {
  final Size size;
  const MoreWidget(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    // final palette = context.read<Palette>();
    return Container(
        width: size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.brown.shade600),
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg/prbg.png'), // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            children: [
              TextButton(
                  style: ButtonStyle(
                      // shape:
                      //     MaterialStatePropertyAll(ContinuousRectangleBorder()),

                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.brown.shade400.withOpacity(0.8))),
                  onPressed: () {
                    GoRouter.of(context).go('/levels');
                  },
                  child: Text("Adventure",
                      style: Styles.playerTextStyle(
                          size: 14, fontColor: Colors.white60))),
              Expanded(child: SizedBox()),
              TextButton(
                  style: ButtonStyle(
                      // shape:
                      //     MaterialStatePropertyAll(ContinuousRectangleBorder()),

                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.brown.shade400.withOpacity(0.8))),
                  onPressed: () {},
                  child: Text(
                    "Backalley Banter",
                    style: Styles.playerTextStyle(
                        size: 14, fontColor: Colors.white60),
                  )),
              Expanded(child: SizedBox()),
              TextButton(
                  style: ButtonStyle(
                      // shape:
                      //     MaterialStatePropertyAll(ContinuousRectangleBorder()),

                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.brown.shade400.withOpacity(0.8))),
                  onPressed: () {},
                  child: Text(
                    "More",
                    style: Styles.playerTextStyle(
                        size: 14, fontColor: Colors.white60),
                  )),
              Expanded(child: SizedBox()),
            ],
          ),
        ));
  }
}
