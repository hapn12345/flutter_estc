import 'package:estc_project/models/log_item.dart';
import 'package:estc_project/pages/splash_page.dart';
import 'package:estc_project/util/constants.dart';
import 'package:estc_project/util/log_util.dart';
import '../../util/share_preference_util.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prepare();
  runApp(const MyApp());
}

Future<void> prepare() async {
  // Initialize Log Util
  LogUtil.init(isDebug: true);
  // Initialize shared prefereneces
  await SharedPreferenceUtil().init();
  // Initialize hive
  await Hive.initFlutter();
  // Registering the adapter
  Hive.registerAdapter(LogItemAdapter());
  // Opening the box
  await Hive.openBox<LogItem>(Constants.logItemTable);
}

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

  @override
  void initState() {
    super.initState();
    prepare();
  }

  Future<void> prepare() async {
    var languageCode = await SharedPreferenceUtil().getLanguageCode();
    setState(() {
      _locale = Locale(languageCode);
    });
    LogUtil.d('languageCode:$languageCode, locale:$_locale');
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
    SharedPreferenceUtil().setLanguageCode(value.languageCode);
    LogUtil.d(tag: 'KhaiTQ', 'setLocale:${_locale.languageCode}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}
