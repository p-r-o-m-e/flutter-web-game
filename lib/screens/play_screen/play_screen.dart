import 'package:basic/style/responsive_screen.dart';
import 'package:flutter/material.dart';

class PlayScreen extends StatelessWidget {
  final String avatarPath = "assets/images/avatars/0.png";

  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
        squarishMainArea: CircleAvatar(child: Icon(Icons.abc)
            //     FutureBuilder<List<Image>?>(
            //   future: ImageProcessor.sliceSpritesheetImage(
            //       imagePath: avatarPath, cols: 3, rows: 3),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done &&
            //         snapshot.hasData) {
            //       return snapshot.data![0];
            //     } else {
            //       return Icon(Icons.do_not_disturb);
            //     }
            //   },
            // )
            ),
        rectangularMenuArea: Text("beta"));
  }
}
