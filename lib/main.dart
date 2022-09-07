import 'package:estc_project/model/log_item.dart';
import 'package:estc_project/pages/splash_page.dart';
import 'package:estc_project/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  // Initialize hive
  await Hive.initFlutter();
  // Registering the adapter
  Hive.registerAdapter(LogItemAdapter());
  // Opening the box
  var box = await Hive.openBox<LogItem>(Constants.LOG_ITEM_TABLE);
  debugPrint('KhaiTQ - ${box.values.toList().toString()}');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}
