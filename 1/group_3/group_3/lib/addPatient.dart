import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPatients extends StatefulWidget {
  const AddPatients({super.key});

  @override
  State<AddPatients> createState() => _AddPatientsState();
}

class _AddPatientsState extends State<AddPatients> {
  final name = TextEditingController();
  final age = TextEditingController();
  final room = TextEditingController();
  final diagnosis = TextEditingController();

  Future<String> registerUser() async {
    final response = await http.post(
      Uri.parse('http://192.168.2.12:3000/register'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'username': name.text,
        'age': age.text,
        'room': room.text,
        'diagnosis': diagnosis.text
      }),
    );
    if (response.statusCode == 200) {
      return 'patient registered successfully';
    } else if (response.statusCode == 400) {
      return 'patient already taken';
    } else {
      throw Exception('Failed to register patient');
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
              controller: name,
              decoration: InputDecoration(
                  labelText: "PatientName",
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
              controller: age,
              decoration: InputDecoration(
                  labelText: "age",
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
              controller: room,
              decoration: InputDecoration(
                  labelText: "Room",
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
              controller: diagnosis,
              decoration: InputDecoration(
                  labelText: "Diagnosis",
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
