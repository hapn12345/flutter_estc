// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../routing.dart';
import 'scaffold_body.dart';

class BookstoreScaffold extends StatelessWidget {
  const BookstoreScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: const BookstoreScaffoldBody(),
        onDestinationSelected: (idx) {
          if (idx == 0) routeState.go('/home');
          if (idx == 1) routeState.go('/alert');
          if (idx == 2) routeState.go('/log');
          if (idx == 3) routeState.go('/user');
        },
        destinations: [
          AdaptiveScaffoldDestination(
            title: AppLocalizations.of(context).homePage,
            icon: Icons.home,
          ),
          AdaptiveScaffoldDestination(
            title: AppLocalizations.of(context).alert,
            icon: Icons.error_outline_outlined,
          ),
          AdaptiveScaffoldDestination(
            title: AppLocalizations.of(context).addLogs,
            icon: Icons.note,
          ),
          AdaptiveScaffoldDestination(
            title: AppLocalizations.of(context).user,
            icon: Icons.person,
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(String pathTemplate) {
    if (pathTemplate == '/home') return 0;
    if (pathTemplate == '/alert') return 1;
    if (pathTemplate == '/log') return 2;
    if (pathTemplate == '/user') return 3;
    return 0;
  }
}
