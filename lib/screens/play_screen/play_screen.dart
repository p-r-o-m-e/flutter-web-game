// ignore_for_file: prefer_const_literals_to_create_immutables

// import 'dart:io';
// import 'dart:js';

import 'package:basic/screens/play_screen/desktop_ui.dart';
import 'package:basic/screens/play_screen/mobile_UI.dart';
import 'package:basic/style/palette.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();
    return Scaffold(
      backgroundColor: palette.backgroundPlaySession,
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
            padding: const EdgeInsets.all(6),
            child: (constraints.biggest.height > constraints.biggest.width)
                ? MobileUI(constraints.biggest)
                : DesktopUI(constraints.biggest));
      }),
    );
  }
}
