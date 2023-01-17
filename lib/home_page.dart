import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'Services/notifi_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   DateTime scheduleTime=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DatePickerTxt(scheduleTime: scheduleTime),
          ScheduleBtn(scheduleTime: scheduleTime),
        ],
      )),
    );
  }
}

class DatePickerTxt extends StatefulWidget {
  DatePickerTxt({
    Key? key,
    required this.scheduleTime,
  }) : super(key: key);

  DateTime scheduleTime;

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(2018, 3, 5),
            maxTime: DateTime(2023, 23, 30), onChanged: (date) {
          setState(() {
            widget.scheduleTime = date;
          });
          debugPrint('change $date');
        }, onConfirm: (date) {
          debugPrint('confirm $date');
        }, currentTime: DateTime.now());
      },
      child: const Text(
        'Select Date Time',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}

class ScheduleBtn extends StatelessWidget {
  const ScheduleBtn({
    Key? key,
    required this.scheduleTime,
  }) : super(key: key);

  final DateTime scheduleTime;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Show notifications'),
      onPressed: () {
        print(scheduleTime);
        NotificationService()
            .scheduleNotification(title: 'Sample title', body: 'It works!', scheduledNotificationDateTime: scheduleTime);
      },
    );
  }
}
