import 'package:estc_project/pages/alert_page.dart';
import 'package:estc_project/widgets/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'main.dart';
import 'pages/navigator.dart';
import 'util/constants.dart';
import 'util/log_util.dart';
import 'util/shared_preference_util.dart';
import 'routing.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static Future<_MyAppState?> of(BuildContext context) async {
    return context.findAncestorStateOfType<_MyAppState>();
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Constants.localeEN;
  ThemeData _themeData = ThemeData();

  final _auth = Auth();
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final RouteState _routeState;
  late final SimpleRouterDelegate _routerDelegate;
  late final TemplateRouteParser _routeParser;

  @override
  void initState() {
    /// Configure the parser with all of the app's allowed path templates.
    _routeParser = TemplateRouteParser(
      allowedPaths: [
        '/splash', //launcher
        '/onboarding',
        '/login',
        '/home',
        '/alert',
        '/log', //add log page
        '/log/log_history',
        '/log/log_history/:date&&:logId',
        '/log/edit_log/:logId',
        '/user',
      ],
      guard: _guard,
      initialRoute: '/splash',
    );

    _routeState = RouteState(_routeParser);

    _routerDelegate = SimpleRouterDelegate(
      routeState: _routeState,
      navigatorKey: _navigatorKey,
      builder: (context) => AppNavigator(
        navigatorKey: _navigatorKey,
      ),
    );

    // Listen for when the user logs out and display the signin screen.
    _auth.init();
    _auth.addListener(_handleAuthStateChanged);

    super.initState();
    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      LogUtil.d('A new onMessageOpenedApp event was published!');
      await RouteStateScope.of(context).go('/alert');
    });
    prepare();
  }

  Future<void> prepare() async {
    var languageCode = await SharedPreferenceUtil().getLanguageCode();
    setState(() {
      _locale = Locale(languageCode);
    });
    LogUtil.d('languageCode:$languageCode, locale:$_locale');
  }

  Future<ParsedRoute> _guard(ParsedRoute from) async {
    final firstLaunch = await SharedPreferenceUtil().isFirstLaunch();
    if (firstLaunch) {
      return ParsedRoute('/onboarding', '/onboarding', {}, {});
    }

    final loggedIn = _auth.signedIn;
    final loginRoute = ParsedRoute('/login', '/login', {}, {});

    // Go to /signin if the user is not signed in
    if (!loggedIn && from != loginRoute) {
      return loginRoute;
    }
    // Go to /books if the user is signed in and tries to go to /signin.
    //else
    if (loggedIn && from == loginRoute) {
      return ParsedRoute('/home', '/home', {}, {});
    }
    return from;
  }

  void _handleAuthStateChanged() {
    if (!_auth.signedIn) {
      _routeState.go('/login');
    }
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
    SharedPreferenceUtil().setLanguageCode(value.languageCode);
    LogUtil.d(tag: 'KhaiTQ', 'setLocale:${_locale.languageCode}');
  }

  void setThemeMode(ThemeData themeData) {
    setState(() {
      _themeData = themeData;
    });
  }

  @override
  Widget build(BuildContext context) => RouteStateScope(
        notifier: _routeState,
        child: BookstoreAuthScope(
          notifier: _auth,
          child: MaterialApp.router(
              locale: _locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('vi'),
              ],
              debugShowCheckedModeBanner: false,
              routerDelegate: _routerDelegate,
              routeInformationParser: _routeParser,
              title: 'Flutter ESTC',
              // Revert back to pre-Flutter-2.5 transition behavior:
              // https://github.com/flutter/flutter/issues/82053
              theme: _themeData),
        ),
      );

  @override
  void dispose() {
    _auth.removeListener(_handleAuthStateChanged);
    _routeState.dispose();
    _routerDelegate.dispose();
    super.dispose();
  }
}
