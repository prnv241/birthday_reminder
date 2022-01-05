import 'dart:io';
import 'package:birthday_reminder/models/reminder.dart';
import 'package:flutter/material.dart';
import 'package:birthday_reminder/appprovider.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class ReminderScreen extends StatelessWidget {
  ReminderScreen({Key? key}) : super(key: key);
  final List<String> imglist = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png'
  ];
  final random = new Random();
  int next(int min, int max) => min + random.nextInt(max - min);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffefefef),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: FutureBuilder(
            future: storage.ready,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final arguments =
                    ModalRoute.of(context)?.settings.arguments as Map;
                if (arguments != null) print(arguments['payload']);
                Reminder thisreminder = context
                    .read<AppProvider>()
                    .getRemider(int.parse(arguments['payload']));
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 120,
                      ),
                      Image.asset(imglist[next(0, 6)]),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Happy birthday, ${thisreminder.title}!",
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  print("Pressed Button");
                                  await player.fixedPlayer?.stop();
                                  await Vibration.cancel();
                                  await flutterLocalNotificationsPlugin
                                      .cancelAll();
                                  context
                                      .read<AppProvider>()
                                      .updateReminder(thisreminder.id);
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xff3700B3)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text(
                                    "Dismiss",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ])
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
