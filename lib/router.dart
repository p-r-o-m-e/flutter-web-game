// Copyright 2023, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:basic/screens/loading_screen/filler.dart';
import 'package:basic/screens/login_screen.dart';
import 'package:basic/screens/play_screen/play_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'game_internals/score.dart';
import 'screens/level_selection/level_selection_screen.dart';
import 'screens/level_selection/levels.dart';
import 'screens/main_menu/main_menu_screen.dart';
import 'screens/play_session/play_session_screen.dart';
import 'settings/settings_screen.dart';
import 'style/my_transition.dart';
import 'style/palette.dart';
import 'screens/win_game/win_game_screen.dart';

/// The router describes the game's navigational hierarchy, from the main
/// screen through settings screens all the way to each individual level.
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
      routes: [
        GoRoute(
            path: 'login',
            pageBuilder: (context, state) {
              return buildMyTransition<void>(
                  key: ValueKey('login'),
                  color: context.read<Palette>().backgroundSettings,
                  child: const LoginScreen(key: Key('login screen')));
            },
            routes: [
              GoRoute(
                path: 'filler',
                pageBuilder: (context, state) {
                  return buildMyTransition<void>(
                      key: ValueKey('filler'),
                      color: context.read<Palette>().backgroundSettings,
                      child: LoadingSession(
                        key: Key('login screen'),
                        autoProceed: false,
                      ));
                },
              )
            ]),
        GoRoute(
          path: 'play',
          pageBuilder: (context, state) {
            return buildMyTransition<void>(
                key: ValueKey('play'),
                color: context.read<Palette>().backgroundPlaySession,
                child: const PlayScreen(key: Key('play screen')));
          },
        ),
        GoRoute(
            path: 'levels',
            pageBuilder: (context, state) => buildMyTransition<void>(
                  key: ValueKey('levels'),
                  color: context.read<Palette>().backgroundLevelSelection,
                  child: const LevelSelectionScreen(
                    key: Key('level selection'),
                  ),
                ),
            routes: [
              GoRoute(
                path: 'session/:level',
                pageBuilder: (context, state) {
                  final levelNumber = int.parse(state.pathParameters['level']!);
                  final level =
                      gameLevels.singleWhere((e) => e.number == levelNumber);
                  return buildMyTransition<void>(
                    key: ValueKey('level'),
                    color: context.read<Palette>().backgroundPlaySession,
                    child: PlaySessionScreen(
                      level,
                      key: const Key('play session'),
                    ),
                  );
                },
              ),
              GoRoute(
                path: 'won',
                redirect: (context, state) {
                  if (state.extra == null) {
                    // Trying to navigate to a win screen without any data.
                    // Possibly by using the browser's back button.
                    return '/';
                  }

                  // Otherwise, do not redirect.
                  return null;
                },
                pageBuilder: (context, state) {
                  final map = state.extra! as Map<String, dynamic>;
                  final score = map['score'] as Score;

                  return buildMyTransition<void>(
                    key: ValueKey('won'),
                    color: context.read<Palette>().backgroundPlaySession,
                    child: WinGameScreen(
                      score: score,
                      key: const Key('win game'),
                    ),
                  );
                },
              )
            ]),
        GoRoute(
          path: 'settings',
          builder: (context, state) =>
              const SettingsScreen(key: Key('settings')),
        ),
      ],
    ),
  ],
);
