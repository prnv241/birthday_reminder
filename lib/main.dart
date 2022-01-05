import 'package:birthday_reminder/screens/addscreen.dart';
import 'package:birthday_reminder/screens/reminderscreen.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:birthday_reminder/screens/homescreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:birthday_reminder/appprovider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
          theme: ThemeData.light().copyWith(
            primaryColor: Color(0xff3700B3),
            backgroundColor: Color(0xffefefef),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => HomeScreen(),
            '/add': (context) => AddRemPage(),
            '/rem': (context) => ReminderScreen()
          },
      ),
    );
  }
}



