import 'dart:collection';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late DeviceCalendarPlugin _deviceCalendarPlugin;

  @override
  void initState() {
    super.initState();
    _deviceCalendarPlugin = DeviceCalendarPlugin();
    _retrieveCalendars();
  }

  Future<void> _retrieveCalendars() async {
    Result<bool> hasPermissions = await _deviceCalendarPlugin.hasPermissions();
    if (!hasPermissions.data!) {
      await _deviceCalendarPlugin.requestPermissions();
    }
    Result<List<Calendar>> calendars = await _deviceCalendarPlugin.retrieveCalendars();
    print("length ${calendars.data?.length}");
    for (Calendar item in calendars.data!) {
      print(item.toJson().toString());
      await _retrieveEvents(item.id ?? "");
    }
    // calendars.data?.forEach((element) async {

    // });
    // _addEvent(calendars.data?.first.id ?? "");
  }

  Future<void> _addEvent(String id) async {
    print("_addEvent");

    String title = 'Tiêu đề sự kiện';
    String description = 'Mô tả sự kiện';
    tz.TZDateTime startDate = tz.TZDateTime.from(DateTime.now(), tz.local);
    tz.TZDateTime endDate = tz.TZDateTime.from(DateTime.now().add(const Duration(hours: 1)), tz.local);

    Event event = Event(
      id,
      title: title,
      description: description,
      start: startDate,
      end: endDate,
    );

    Result<String>? result = await _deviceCalendarPlugin.createOrUpdateEvent(
      event,
    );
    print("result ${result?.data}");

    // if (result.isSuccess) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Sự kiện đã được thêm thành công')),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Lỗi khi thêm sự kiện: ${result.errorMessages}')),
    //   );
    // }
  }

  Future<void> _retrieveEvents(String calendarId) async {
    print("_retrieveEvents $calendarId");

    DateTime startDate = DateTime.now().subtract(const Duration(days: 7));
    DateTime endDate = DateTime.now().add(const Duration(days: 7));
    startDate = DateTime(2023, 8, 30);
    endDate = DateTime(2023, 12, 30);

    // print("startDate $startDate");
    // print("endDate $endDate");

    try {
      Result<UnmodifiableListView<Event>> result = await _deviceCalendarPlugin.retrieveEvents(
        calendarId,
        RetrieveEventsParams(startDate: startDate, endDate: endDate),
      );
      print("length event ${result.data?.length}");

      result.data?.forEach((element) {
        print(element.toJson().toString());
      });
    } catch (e) {
      print('Lỗi khi lấy sự kiện: $e');
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
