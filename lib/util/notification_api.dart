import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final BehaviorSubject<String?> onNotifications =
      BehaviorSubject<String?>();

  static const _androidInitializationSettins =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  static void initialseNotifications() async {
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: _androidInitializationSettins,
    );
    _notifications.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      onNotifications.add(payload);
    });
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotifications({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      {
        _notifications.show(
          id,
          title,
          body,
          await _notificationDetails(),
          payload: payload,
        )
      };
  static Future isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      await _notifications
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
  }

  static Future requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await _notifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await _notifications
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      await androidImplementation?.requestPermission();
    }
  }
}
