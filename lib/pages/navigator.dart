// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:estc_project/models/log_item.dart';
import 'package:estc_project/pages/log/filter_history_page.dart';
import 'package:estc_project/pages/onboarding_page.dart';
import 'package:estc_project/pages/splash_page.dart';
import 'package:estc_project/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../routing.dart';
import '../util/constants.dart';
import 'log/edit_log_page.dart';
import 'log/log_history_page.dart';
import 'login_page.dart';
import '../widgets/fade_transition_page.dart';
import 'scaffold.dart';

/// Builds the top-level navigator for the app. The pages to display are based
/// on the `routeState` that was parsed by the TemplateRouteParser.
class AppNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const AppNavigator({
    required this.navigatorKey,
    super.key,
  });

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  final _logInKey = const ValueKey('Login');
  final _scaffoldKey = const ValueKey('App scaffold');
  final _splashKey = const ValueKey('Splash');
  final _onboardingKey = const ValueKey('Onboarding');
  final _logHistoryKey = const ValueKey('Log History');
  final _alertKey = const ValueKey('Alert');
  final _editLogKey = const ValueKey('Edit Log');

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    //final authState = BookstoreAuthScope.of(context);
    final pathTemplate = routeState.route.pathTemplate;

    LogItem? selectedLog;
    if (pathTemplate == '/log/edit_log/:logId') {
      selectedLog = Hive.box<LogItem>(Constants.logItemTable).values.firstWhere(
          (log) => log.logId == routeState.route.parameters['logId']);
    }

    DateTime? filterDate;
    String? filterLogId;
    if (pathTemplate == '/log/log_history/:date&&:logId') {
      filterDate =
          DateTime.parse(routeState.route.parameters['date'] as String);
      filterLogId = routeState.route.parameters['logId'];
      LogUtil.d('filter history with: $filterDate, $filterLogId');
    }

    return Navigator(
      key: widget.navigatorKey,
      onPopPage: (route, dynamic result) {
        if (route.settings is Page &&
            (route.settings as Page).key == _editLogKey) {
          routeState.go('/log/log_history');
        }

        if (route.settings is Page &&
            (route.settings as Page).key == _logHistoryKey) {
          routeState.go('/log');
        }

        return route.didPop(result);
      },
      pages: [
        if (routeState.route.pathTemplate == '/splash')
          // Display the splash screen.
          FadeTransitionPage<void>(key: _splashKey, child: const SplashPage())
        else if (routeState.route.pathTemplate == '/onboarding')
          // Display the onboarding screen.
          FadeTransitionPage<void>(
              key: _onboardingKey, child: const OnboardingPage())
        else if (routeState.route.pathTemplate == '/login')
          // Display the sign in screen.
          FadeTransitionPage<void>(key: _logInKey, child: const LoginPage())
        else if (routeState.route.pathTemplate == '/log/log_history')
          // Display the log history screen.
          FadeTransitionPage<void>(
              key: _logHistoryKey, child: const LogHistoryPage())
        else ...[
          // Display the app
          FadeTransitionPage<void>(
            key: _scaffoldKey,
            child: const BookstoreScaffold(),
          ),
          if (selectedLog != null)
            MaterialPage<void>(
              key: _editLogKey,
              child: EditLogPage(log: selectedLog),
            )
          else if (filterDate != null && filterLogId != null)
            MaterialPage<void>(
              key: _logHistoryKey,
              child: FilterHistoryPage(date: filterDate, logID: filterLogId),
            )
        ],
      ],
    );
  }
}
