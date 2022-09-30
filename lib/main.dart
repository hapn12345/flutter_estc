import 'dart:async';
import 'package:estc_project/models/log_item.dart';
import 'package:estc_project/util/constants.dart';
import 'package:estc_project/util/log_util.dart';
import 'util/shared_preference_util.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_strategy/url_strategy.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  LogUtil.d(
      tag: 'KhaiTQ', 'Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
  LogUtil.d(tag: 'KhaiTQ', 'Setup firebase done');
}

void showFlutterNotification(RemoteMessage message) {
  const int insistentFlag = 4;
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
          android: AndroidNotificationDetails(
            'alert_notifications_channel',
            'Alert Notifications Channel',
            channelDescription: 'Alert Notifications Channel',
            importance: Importance.max,
            priority: Priority.high,
            additionalFlags: Int32List.fromList(<int>[insistentFlag]),
            icon: 'launch_background',
            sound: const RawResourceAndroidNotificationSound('alarm'),
          ),
          iOS: const IOSNotificationDetails(sound: 'alarm.aiff')),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() {
  // Initialize UrlStrategy
  setHashUrlStrategy();
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
  //Initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  await FirebaseMessaging.instance.getToken().then((token) {
    LogUtil.d(tag: 'KhaiTQ', 'FCM Token: $token');
    SharedPreferenceUtil().setFcmToken(token ?? '');
  });
}
