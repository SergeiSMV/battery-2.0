import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'app_colors.dart';


calendar(BuildContext mainContext, TextEditingController dateCntr){
  return showModalBottomSheet(
    isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: mainContext, 
      builder: (context){
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TableCalendar(
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  locale: 'ru',
                  rowHeight: 40,
                  headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true, titleTextStyle: TextStyle(color: firmColor, fontSize: 17)),
                  daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: TextStyle(color: firmColor), weekendStyle: const TextStyle(color: Colors.red)),
                  focusedDay: DateTime.now(), 
                  firstDay: DateTime.utc(2010, 01, 01), 
                  lastDay: DateTime.utc(2030, 01, 01),
                  onDaySelected: (DateTime day, DateTime focusedDay){
                    var formatter = DateFormat('dd.MM.yyyy');
                    String selected = formatter.format(day);
                    dateCntr.text = selected;
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      }
  );
}