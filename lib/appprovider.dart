import 'package:audioplayers/audioplayers.dart';
import 'package:birthday_reminder/models/reminerlist.dart';
import 'package:flutter/material.dart';
import 'package:birthday_reminder/models/reminder.dart';
import 'package:birthday_reminder/services/create_alarm.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

final LocalStorage storage = new LocalStorage('reminder_app');
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
AudioPlayer advancePlayer = new AudioPlayer();
AudioCache player = new AudioCache(prefix: 'assets/audio/', fixedPlayer: advancePlayer);


class AppProvider extends ChangeNotifier {
  ReminderList remlist = ReminderList();
  CreateAlarm cralarm = CreateAlarm();
  int alarmCount = 0;

  void initList() {
    var items = storage.getItem('todos');
    if (items != null && items.length > 0) {
      print(items);
      remlist.items = items.map<Reminder>((item) => Reminder(id: item['id'], title: item['title'], desc: item['desc'], timestamp: DateTime.parse(item['timestamp']))).toList();
      alarmCount = remlist.items.length;
      print(remlist.items);
    } else {
      storage.setItem('todos', remlist.toMap());
    }
  }

  void addReminder(String title, String desc, String time, String date) {
    String datetime = date + ' ' + time;
    DateFormat format = new DateFormat('yyyy-MM-dd HH:mm');
    DateTime timestamp = format.parse(datetime);
    remlist.items.add(Reminder(title: title, desc: desc, id: alarmCount, timestamp: timestamp));
    storage.setItem('todos', remlist.toMap());
    cralarm.addAlarm(id: alarmCount, timestamp: timestamp);
    alarmCount += 1;
    notifyListeners();
  }

  Reminder getRemider(int id) {
    return remlist.items.firstWhere((element) => element.id == id);
  }

  void deleteReminder(int id) {
    remlist.items.removeWhere((element) => element.id == id);
    storage.setItem('todos', remlist.toMap());
    cralarm.removeAlarm(id: id);
    alarmCount -= 1;
    notifyListeners();
  }

  void updateReminder(int id) {
    int index = remlist.items.indexWhere((element) => element.id == id);
    DateTime time = remlist.items[index].timestamp;
    remlist.items[index].timestamp = DateTime(time.year + 1, time.month, time.day, time.hour, time.minute);
    cralarm.addAlarm(id: remlist.items[index].id, timestamp: remlist.items[index].timestamp);
    storage.setItem('todos', remlist.toMap());
    notifyListeners();
  }
}