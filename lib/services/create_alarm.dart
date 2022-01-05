import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:birthday_reminder/appprovider.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class CreateAlarm {

  void addAlarm({required int id, required DateTime timestamp}) {
    AndroidAlarmManager.oneShotAt(timestamp, id, callback, allowWhileIdle: true, wakeup: true, alarmClock: true, exact: true);
  }

  void removeAlarm({required int id}) {
    AndroidAlarmManager.cancel(id);
  }
}

//Insistent Notification
Future<void> showInsistentNotification(int id) async {
  await storage.ready;
  var items = storage.getItem('todos');
  var item = items.firstWhere((element) => element['id'] == id);
  final AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails('your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      autoCancel: false,
      ongoing: true,
  );
  final NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'Its ${item['title']}\'s Birthday today!', 'Click on the notification to dismiss', platformChannelSpecifics,
      payload: item['id'].toString());
}

//Setup FlutterLocalNotifications
Future<void> initializeNotificaitons(BuildContext context) async{
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
          Navigator.pushNamed(context, '/rem', arguments: {'payload': payload},);
        }
      });
}


//Callback function for Alarm
void callback(int id) async {
  final DateTime now = DateTime.now();
  await showInsistentNotification(id);
  Vibration.vibrate(repeat: 0, pattern: [1000, 1000]);
  player.play('hbd.mp3');
}

//Month int to String
String inttostring(int num) {
  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  return months[num-1];
}

//24Hour to 12HourAM/PM
String ampm(int hour) {
  if(hour >= 12 || hour == 0) return 'PM';
  else return 'AM';
}

//Update old Alarms
void updatealarms(BuildContext context) {
  var remlist = context.read<AppProvider>().remlist.items;
  DateTime now = DateTime.now();
  remlist.forEach((element) {
    if(element.timestamp.isBefore(now)) {
      context.read<AppProvider>().updateReminder(element.id);
    }
  });
}