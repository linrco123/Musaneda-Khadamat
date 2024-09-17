// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/app/modules/notification/providers/notification_provider.dart';
import 'package:musaneda/config/constance.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../controllers/language_controller.dart';
import '../notification_model.dart';

class NotificationController extends GetxController {
  static NotificationController get I => Get.put(NotificationController());
  @override
  onInit() {
    super.onInit();
    getNotifications();
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage? message) async {}

  Future<void> config() async {
    try {
      requestPermission();

      RemoteMessage? init =
          await FirebaseMessaging.instance.getInitialMessage();
      if (init != null) {
        _handleMessage(init);
        _handleOnMessage(init);
      }

      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

      FirebaseMessaging.onMessage.listen(_handleOnMessage);

      FirebaseMessaging.instance.getToken().then((token) {
        Pretty.instance.logger.d("on_get_token: $token");
      });

      FirebaseMessaging.instance.onTokenRefresh.listen((token) {
        Pretty.instance.logger.d("on_token_refresh: $token");
      });
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  void _handleMessage(RemoteMessage message) async {
    try {
      Pretty.instance.logger.d("handle_message:$message");
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  void _handleOnMessage(RemoteMessage message) async {
    try {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        Get.snackbar(
          notification.title!,
          notification.body!,
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  Future<void> requestPermission() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        // notification accepted /allowed
      }
      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        // notification denied
      }

      update();
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  final box = GetStorage();
  static final NotificationController _notifyService =
      NotificationController._internal();

  factory NotificationController() => _notifyService;

  NotificationController._internal();

  final FlutterLocalNotificationsPlugin fl = FlutterLocalNotificationsPlugin();

  Future<void> initNotify() async {
    try {
      await requestPermission();

      await fl.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings(
            '@drawable/notification',
          ),
          iOS: DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
          ),
        ),
      );

      // FirebaseMessaging.instance.getInitialMessage().then((message) {
      //   FirebaseMessageModel frmModel = FirebaseMessageModel(
      //     title: message!.notification!.title!,
      //     body: message.notification!.body!,
      //     type: message.data['type'],
      //     dateTime: since(date: message.data['date_time']),
      //   );
      //   notifyList.add(frmModel);

      //   Get.toNamed(Routes.NOTIFICATION);
      // });

      // FirebaseMessaging.onBackgroundMessage(
      //     _firebaseMessagingBackgroundHandler);

      // FirebaseMessaging.onMessageOpenedApp.listen(
      //   (message) async {
      //     FirebaseMessageModel frmModel = FirebaseMessageModel(
      //       title: message.notification!.title!,
      //       body: message.notification!.body!,
      //       type: message.data['type'],
      //       dateTime: since(date: message.data['date_time']),
      //     );

      //     notifyList.add(frmModel);
      //   },
      // );

      FirebaseMessaging.onMessage.listen(
        (message) async {
          fl.show(
              0,
              message.notification!.title!,
              message.notification!.body!,
              const NotificationDetails(
                android: AndroidNotificationDetails(
                  'main_channel',
                  'Main Channel',
                  importance: Importance.max,
                  priority: Priority.max,
                  icon: '@drawable/notification',
                  playSound: true,
                ),
                iOS: DarwinNotificationDetails(
                  sound: 'default.wav',
                  presentAlert: true,
                  presentBadge: false,
                  presentSound: true,
                ),
              ));
        },
      );
      GetStorage box = GetStorage();
      FirebaseMessaging.instance.onTokenRefresh.listen((token) {
        Pretty.instance.logger.e("Refreshed_token: $token");
        NotificationProvider()
            .updateFCMToken({'fcm_token': token}).then((value) {
          if (value == 200) {
            box.write('fcm_token', token);
            FirebaseMessaging.instance.subscribeToTopic('all');
          }
        });
      });

      FirebaseMessaging.instance.getToken().then(
        (token) {
          Pretty.instance.logger.d("get_token_tow: $token");
          box.write('fcm_token', token);
        },
      );
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  remove(NotificationData ob) {
    if (getNotify.contains(ob)) {
      getNotify.remove(ob);
    }
    update();
  }

  Future<void> cancelAllNotifications() async {
    await fl.cancelAll();
    getNotify.clear();
    update();
  }

  // To show local push notification in our local timezone of our country
  tz.TZDateTime scheduled() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('eg/cairo'));
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime date = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
      now.second,
    );
    if (date.isBefore(now)) {
      date = date.add(const Duration(seconds: 1));
    }
    return date;
  }

  static since({required String date, bool numeric = true}) {
    final DateTime dateTime = DateFormat.parse(date);
    // final DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
    final DateTime now = DateTime.now();

    final Duration difference = now.difference(dateTime);

    log(LanguageController.I.getLocale.toString(), name: "LOCALE");

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} ${LanguageController.I.getLocale == 'ar' ? 'سنة' : 'year'}';
    }
    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} ${LanguageController.I.getLocale == 'ar' ? 'شهر' : 'month'}';
    }
    if (difference.inDays > 0) {
      return '${difference.inDays} ${LanguageController.I.getLocale == 'ar' ? 'يوم' : 'day'}';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours} ${LanguageController.I.getLocale == 'ar' ? 'ساعة' : 'hour'}';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${LanguageController.I.getLocale == 'ar' ? 'دقيقة' : 'minute'}';
    }
    return '${difference.inSeconds} ${LanguageController.I.getLocale == 'ar' ? 'ثانية' : 'second'}';
  }

  Future<void> showNotify({id, title, body, type}) async {
    try {
      await fl.zonedSchedule(
        id,
        title,
        body,
        scheduled(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'main_channel',
            'Main Channel',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/notification',
            playSound: true,
          ),
          iOS: DarwinNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: false,
            presentSound: true,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: type,
      );
    } catch (e) {}

    update();
  }

  var notifyList = <NotificationData>[];

  List<NotificationData> get getNotify => notifyList;
  int page = 1;
  var isLoading = false.obs;
  var lastPage = false.obs;
  void getNotifications() {
    NotificationProvider().getNotifications(page).then((value) {
      if (value.data != null) {
        for (Notifications data in value.data!.notifications as List) {
          notifyList.add(data.data!);
        }
      }
      isLoading(false);
      update();
    }).catchError((error) {
      isLoading(false);
      update();
    });
    ;
  }

  void getMoreNotifications() {
    isLoading(true);
    NotificationProvider().getNotifications(++page).then((value) {
      for (Notifications data in value.data!.notifications as List) {
        notifyList.add(data.data!);
      }
      if (page >= value.data!.pagination!.lastPage!) {
        lastPage.value = true;
      }
      isLoading(false);
      update();
    }).catchError((error) {
      isLoading(false);
      update();
    });
  }
}

class DateFormat {
  final String format;

  static DateFormat get I => DateFormat('yyyy-MM-dd HH:mm:ss');

  DateFormat(this.format);

  static DateTime parse(String date) {
    return DateTime.parse(date);
  }

  static String formatIt(DateTime date) {
    return date.toString();
  }
}
