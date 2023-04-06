import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddDetails extends StatefulWidget {
  const AddDetails({super.key});

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  final bloodPressure = TextEditingController();
  final repiratoryRate = TextEditingController();
  final bloodOxygen = TextEditingController();
  final heartRate = TextEditingController();

  get username => null;

  Future<String> registerUser() async {
    final response = await http.post(
      Uri.parse('http://192.168.2.12:3000/registerdata'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'username': username,
        'bloodPressure': bloodPressure.text,
        'repiratoryRate': repiratoryRate.text,
        'bloodOxygen': bloodOxygen.text,
        'heartRate': heartRate.text
      }),
    );
    if (response.statusCode == 200) {
      return 'patient details added successfully';
    } else if (response.statusCode == 400) {
      return 'patient details added  already taken';
    } else {
      throw Exception('Failed to  add details patient');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Column(
          children: [
            const Text("AddPatient",
                style: TextStyle(fontSize: 30, color: Colors.black87)),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: bloodPressure,
              decoration: InputDecoration(
                  labelText: "Blood Pressure (X/Y mmHg)",
                  labelStyle:
                      TextStyle(fontSize: 15, color: Colors.pink.shade400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: repiratoryRate,
              decoration: InputDecoration(
                  labelText: "Respiratory Rate (X/min)",
                  labelStyle:
                      TextStyle(fontSize: 15, color: Colors.pink.shade400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: bloodOxygen,
              decoration: InputDecoration(
                  labelText: "Blood Oxygen Level (X%)",
                  labelStyle:
                      TextStyle(fontSize: 15, color: Colors.pink.shade400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: heartRate,
              decoration: InputDecoration(
                  labelText: "Heartbeat Rate (X/min)",
                  labelStyle:
                      TextStyle(fontSize: 15, color: Colors.pink.shade400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {
                try {
                  registerUser();
                } on Exception catch (e) {
                  // TODO
                }
              },
              child: Container(
                color: Colors.red,
                alignment: Alignment.center,
                height: size.height / 14,
                width: size.width / 2,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: const Text(
                  'save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
