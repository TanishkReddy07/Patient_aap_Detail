import 'package:flutter/material.dart';
import 'package:pdm/viewPatient.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDM',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const ViewPatient(
        title: 'Patients',
      ),
    );
  }
}
