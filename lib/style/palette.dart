// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// A palette of colors to be used in the game.
///
/// The reason we're not going with something like Material Design's
/// `Theme` is simply that this is simpler to work with and yet gives
/// us everything we need for a game.
///
/// Games generally have more radical color palettes than apps. For example,
/// every level of a game can have radically different colors.
/// At the same time, games rarely support dark mode.
///
/// Colors taken from this fun palette:
/// https://lospec.com/palette-list/crayola84
///
/// Colors here are implemented as getters so that hot reloading works.
/// In practice, we could just as easily implement the colors
/// as `static const`. But this way the palette is more malleable:
/// we could allow players to customize colors, for example,
/// or even get the colors from the network.
class Palette {
  // Color get pen => const Color(0xff1d75fb);
  // Color get darkPen => const Color(0xFF0050bc);
  // Color get redPen => const Color(0xFFd10841);
  // Color get inkFullOpacity => const Color(0xff352b42);
  // Color get ink => const Color(0xee352b42);
  // Color get backgroundMain => const Color(0xffffffd1);

  // Color get backgroundLevelSelection => const Color(0xffa2dcc7);
  // Color get backgroundPlaySession => const Color(0xffffebb5);
  // Color get background4 => const Color(0xffffd7ff);
  // Color get backgroundSettings => const Color(0xffbfc8e3);
  // Color get trueWhite => const Color(0xffffffff);

  // Color get pen => const Color(0xffB12B24);
  // Color get darkPen => const Color(0xFF760504);
  // Color get redPen => const Color(0xFFd10841);
  // Color get inkFullOpacity => const Color(0xffA3EBB1);
  // Color get ink => Color(0xeeCDD193);
  // Color get backgroundMain => const Color(0xff013A20);
  // // Color get backgroundLevelSelection => const Color(0xff0099A2);
  // Color get backgroundPlaySession => const Color(0xff3F5132);
  // Color get background4 => const Color(0xff2D2A11);
  // Color get backgroundSettings => const Color(0xff1D4E4D);
  // Color get trueWhite => const Color(0xffffffff);
  // Color get backgroundLevelSelection => backgroundSettings;

// Color get darkPen => const Color(0xff4A403A);
//   Color get pen => const Color(0xFF665A48);
  Color get pen => const Color(0xff4A403A);
  Color get darkPen => const Color(0xFF665A48);
  Color get redPen => const Color(0xFFd10841);
  Color get inkFullOpacity => const Color(0xffCDD193);
  Color get ink => Color(0xeeCDD193);
  Color get backgroundMain => const Color(0xff2B2B2B);

  Color get backgroundPlaySession => const Color(0xff3D3B40);
  Color get backgroundSettings => const Color(0xff502A2A);
  // Color get backgroundSettings => const Color(0xff191717);

  Color get trueWhite => const Color(0xffffffff);
  Color get backgroundLevelSelection => backgroundSettings;
}
