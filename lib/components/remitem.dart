import 'package:birthday_reminder/services/create_alarm.dart';
import 'package:birthday_reminder/appprovider.dart';
import 'package:birthday_reminder/models/reminder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardItem extends StatelessWidget {
  int index = 0;
  CardItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Reminder> remlist = context.watch<AppProvider>().remlist.items;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Card(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        remlist[index].title,
                        style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        remlist[index].desc,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 15),
                      Text(
                        '${remlist[index].timestamp.day.toString()}th ${inttostring(remlist[index].timestamp.month)} ${remlist[index].timestamp.year.toString()} ${remlist[index].timestamp.hour > 12 ? remlist[index].timestamp.hour - 12 : remlist[index].timestamp.hour}:${remlist[index].timestamp.minute < 10 ? '0' + remlist[index].timestamp.minute.toString() : remlist[index].timestamp.minute} ${ampm(remlist[index].timestamp.hour)}',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      TextButton(
                        child: Icon(Icons.delete_rounded, size: 30),
                        onPressed: () {
                          context
                              .read<AppProvider>()
                              .deleteReminder(remlist[index].id);
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                          foregroundColor: MaterialStateProperty.all(Colors.black),
                          alignment: AlignmentGeometry.lerp(Alignment.centerRight, Alignment.centerRight, 0),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
