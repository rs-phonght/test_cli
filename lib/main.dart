// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_notice/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.indigo.shade900,
        appBarTheme: AppBarTheme(color: Colors.indigo.shade900),
      ),
      home: MyHomePage(title: 'Flutter Local Notifications'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    NotificationService().init(context);

    super.initState();
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  NotificationService _notificationService = NotificationService();
  @override
  Widget build(BuildContext context) {
    DateTime? dateTimePick;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text('Show Notification'),
                padding: const EdgeInsets.all(10),
                onPressed: () async {
                  await _notificationService.showNotifications();
                },
              ),
              SizedBox(height: 3),
              RaisedButton(
                child: Text('Schedule Notification'),
                padding: const EdgeInsets.all(10),
                onPressed: () async {
                  await _notificationService.scheduleNotifications();
                },
              ),
              SizedBox(height: 3),
              RaisedButton(
                child: Text('Cancel Notification'),
                padding: const EdgeInsets.all(10),
                onPressed: () async {
                  await _notificationService.cancelNotifications(0);
                },
              ),
              SizedBox(height: 3),
              RaisedButton(
                child: Text('Cancel All Notifications'),
                padding: const EdgeInsets.all(10),
                onPressed: () async {
                  await _notificationService.cancelAllNotifications();
                },
              ),
              RaisedButton(
                child: Text('Time picker'),
                padding: const EdgeInsets.all(10),
                onPressed: () async {
                  _showDialog(
                    CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime.now(),
                      use24hFormat: true,
                      // This is called when the user changes the timer duration.
                      onDateTimeChanged: (DateTime newTime) {
                        setState(
                          () {
                            dateTimePick = newTime;
                            print(dateTimePick);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              Text('${dateTimePick}'),
              SizedBox(height: 3),
            ],
          ),
        ),
      ),
    );
  }
}
