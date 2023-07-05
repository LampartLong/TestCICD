import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  late DateTime _selectedDate;
  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
    _showDatePicker(context);
  }

  DateTime selectedDateTime = DateTime.now();

  void _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      fontSize: 16,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold,
      textBaseline: TextBaseline.alphabetic,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Same Font Size DatePicker'),
      ),
      body: Center(
          child: SizedBox(
        width: 200,
        height: 200,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (DateTime newDate) {
            setState(() {
              _selectedDate = newDate;
            });
          },
          backgroundColor: Colors.white, // Set background color
          use24hFormat: true, // Set to true if using 24-hour format
        ),
      )),
    );
  }
}
