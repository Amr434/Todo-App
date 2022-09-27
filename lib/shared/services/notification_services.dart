

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_task/models/task.dart';
import 'package:todo_task/modules/notified_page.dart';
class NotifyHelper{


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    tz.initializeTimeZones();

    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    final List<ActiveNotification>? activeNotifications =
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
    print("active"+activeNotifications.toString());







    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );


    final AndroidInitializationSettings initializationSettingsAndroid =
     AndroidInitializationSettings('@mipmap/ic_launcher');

      final InitializationSettings initializationSettings =
      InitializationSettings(
      iOS: initializationSettingsIOS,
      android:initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: selectNotification
    );

  }




  Future onDidReceiveLocalNotification(int id, String ?title, String? body, String? payload)
  async {


     Get.dialog(
       Text("Welcom to flutter"),
       barrierColor: Colors.red,
     );


  }
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    }
    else {
      print("Notification Done");
    }

    if(payload=='change mode'){

    }
    else{
      Get.to(()=>NotifiedPage(payload: payload,));
    }

  }


  displayNotification({required String title, required String body}) async {

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        title,
        body,
        importance: Importance.max, priority: Priority.high,

    );
    var iOSPlatformChannelSpecifics =  new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,


    );
  }

  scheduledNotification(int hour ,int minutes,TaskModel taskModel) async {

    await flutterLocalNotificationsPlugin.zonedSchedule(
        taskModel.id!,
       taskModel.title,
        taskModel.note,

        _converttime(hour,minutes),
        // tz.TZDateTime.now(tz.local).add( Duration(seconds: 5
        // )),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name',)
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "${taskModel.title}|${taskModel.note}+${taskModel.startime}"


    );

  }
 tz.TZDateTime  _converttime(int hour,int minutes){
   final tz.TZDateTime now =tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduletime=tz.TZDateTime(tz.local,now.year,now.month,now.day,hour,minutes);

    if(scheduletime==tz.TZDateTime.now(tz.local)){
      scheduletime.add(const Duration(days: 1));
    }
    return scheduletime;

  }
  Future<void>_schedulintia() async
  {

  }


}