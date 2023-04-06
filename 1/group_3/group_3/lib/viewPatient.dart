import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdm/addPatient.dart';
import 'package:pdm/viewPatientDetails.dart';

class ViewPatient extends StatefulWidget {
  const ViewPatient({super.key, required this.title});
  final String title;
  @override
  State<ViewPatient> createState() => _ViewPatientState();
}

class _ViewPatientState extends State<ViewPatient> {
  List<dynamic> _users = [];

  Future<void> _fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://192.168.2.12:3000/register'));
    if (response.statusCode == 200) {
      setState(() {
        _users = jsonDecode(response.body);
      });
    } else {
      // Handle error
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Patients'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  user['username'],
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                leading: CircleAvatar(
                  child: Text(
                    user["username"][0],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                trailing: Text("${user["room"]}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PatientDetails(),
                      settings: const RouteSettings(
                        arguments: 'john',
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPatients()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
