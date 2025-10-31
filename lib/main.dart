import 'package:flutter/material.dart';

void main() {
  runApp(const DemyTeachersApp());
}

class DemyTeachersApp extends StatelessWidget {
  const DemyTeachersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demy Teachers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            'Demy Teachers App',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}