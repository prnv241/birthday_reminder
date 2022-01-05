import 'dart:core';
import 'package:birthday_reminder/appprovider.dart';
import 'package:birthday_reminder/services/create_alarm.dart';
import 'package:flutter/material.dart';
import 'package:birthday_reminder/components/remitem.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    initializeNotificaitons(context);
    updatealarms(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffefefef),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            print("Button Pressed");
            Navigator.pushNamed(context, '/add');
          },
          backgroundColor: Color(0xff3700B3),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xff3700B3),
          title: const Text(
            'Birthday Reminder',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
        body: FutureBuilder(
          future: storage.ready,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            context.read<AppProvider>().initList();
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container(
                margin: EdgeInsets.all(5),
                child: ListView.builder(
                  itemCount: context.watch<AppProvider>().remlist.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardItem(index: index);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
