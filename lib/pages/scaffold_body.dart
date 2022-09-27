import 'package:estc_project/pages/alert_page.dart';
import 'package:estc_project/pages/log/add_logs_page.dart';
import 'package:estc_project/pages/user/user_page.dart';
import 'package:estc_project/pages/webview.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../network/network_request.dart';
import '../routing.dart';

import '../widgets/fade_transition_page.dart';

import 'scaffold.dart';

/// Displays the contents of the body of [BookstoreScaffold]
class BookstoreScaffoldBody extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const BookstoreScaffoldBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var currentRoute = RouteStateScope.of(context).route;

    // A nested Router isn't necessary because the back button behavior doesn't
    // need to be customized.
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, dynamic result) => route.didPop(result),
      pages: [
        if (currentRoute.pathTemplate == '/home')
          const FadeTransitionPage<void>(
              key: ValueKey('home'), child: MyWebView())
        else if (currentRoute.pathTemplate == '/alert')
          FadeTransitionPage<void>(
            key: const ValueKey('alert'),
            child: AlertPage(),
          )
        else if (currentRoute.pathTemplate == '/log')
          const FadeTransitionPage<void>(
            key: ValueKey('log'),
            child: AddLogsPage(),
          )
        else if (currentRoute.pathTemplate == '/user')
          const FadeTransitionPage<void>(
            key: ValueKey('user'),
            child: UserPage(),
          )
        // Avoid building a Navigator with an empty `pages` list when the
        // RouteState is set to an unexpected path, such as /signin.
        //
        // Since RouteStateScope is an InheritedNotifier, any change to the
        // route will result in a call to this build method, even though this
        // widget isn't built when those routes are active.
        else
          FadeTransitionPage<void>(
            key: const ValueKey('empty'),
            child: Container(),
          ),
      ],
    );
  }
}
