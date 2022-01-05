import 'dart:core';

class Reminder {
  String title;
  String desc;
  int id;
  DateTime timestamp;
  Reminder({required this.title, required this.desc, required this.id, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'timestamp': timestamp.toString()
    };
  }
}