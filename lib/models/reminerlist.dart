import 'package:birthday_reminder/models/reminder.dart';

class ReminderList {
  List<Reminder> items = [];

  toMap() {
    return items.map((item) {
      return item.toMap();
    }).toList();
  }
}