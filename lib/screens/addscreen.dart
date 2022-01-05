import 'package:birthday_reminder/appprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:provider/provider.dart';

class AddRemPage extends StatefulWidget {
  const AddRemPage({Key? key}) : super(key: key);

  @override
  _AddRemPageState createState() => _AddRemPageState();
}

class _AddRemPageState extends State<AddRemPage> {
  String title = '';
  String desc = '';
  String date = '';
  String time = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffefefef),
        appBar: AppBar(
          backgroundColor: Color(0xff3700B3),
          leadingWidth: 30,
          title: const Text(
            'Add Reminder',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 15),
          margin: EdgeInsets.all(15),
          child: ListView(
            children: [
              Text(
                'Person Name',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (newTitle) {
                  title = newTitle;
                },
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  counterText: "",
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Name',
                  hintStyle: TextStyle(fontWeight: FontWeight.w300),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff3700B3), width: 1.5),
                  ),
                ),
                cursorColor: Color(0xff3700B3),
                maxLength: 30,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Custom Message',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (newDes) {
                  desc = newDes;
                },
                keyboardType: TextInputType.text,
                maxLength: 60,
                cursorColor: Color(0xff3700B3),
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  hintText: 'Message',
                  contentPadding: EdgeInsets.all(15),
                  hintStyle: TextStyle(fontWeight: FontWeight.w300),
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff3700B3), width: 1.5),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Reminder date',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              DateTimePicker(
                type: DateTimePickerType.date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                cursorColor: Color(0xff3700B3),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Date',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff3700B3), width: 1.5),
                  ),
                  hintStyle: TextStyle(fontWeight: FontWeight.w300),
                  icon: Icon(
                    Icons.calendar_today_rounded,
                    color: Color(0xff3700B3),
                  ),
                ),
                onChanged: (val) {
                  date = val;
                },

              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Reminder time',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              DateTimePicker(
                type: DateTimePickerType.time,
                use24HourFormat: true,
                cursorColor: Color(0xff3700B3),
                locale: Locale('en', 'US'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Time',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff3700B3), width: 1.5),
                  ),
                  hintStyle: TextStyle(fontWeight: FontWeight.w300),
                  icon: Icon(
                    Icons.access_time_rounded,
                    color: Color(0xff3700B3),
                  ),
                ),
                onChanged: (val) {
                  time = val;
                  print(time);
                },
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  if (title != '' && desc != '' && date != '' && time != '') {
                    context
                        .read<AppProvider>()
                        .addReminder(title, desc, time, date);
                    Navigator.pop(context);
                  } else {
                    print("Fill the details Properly");
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Save'),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff3700B3))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
