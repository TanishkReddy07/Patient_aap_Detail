import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdm/adddetails.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  List<dynamic> _users = [];
  final name = TextEditingController();
  final age = TextEditingController();
  final room = TextEditingController();
  Future<void> editUser() async {
    final response = await http.post(
      Uri.parse('http://192.168.0.101:3000/register'),
      headers: <String, String>{'Content-Type': 'application/json'},
      // body: jsonEncode(<String, String>{'username': name}),
    );
    if (response.statusCode == 200) {
      setState(() {
        _users = jsonDecode(response.body);
      });
    } else if (response.statusCode == 400) {
      throw Exception('Failed to get patient');
    } else {
      throw Exception('Failed to get patient');
    }
  }

  Future<void> _fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://192.168.0.101:3000/register'));
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
    editUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('patients'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];

          return Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  user['bloodPressure'],
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
            MaterialPageRoute(builder: (context) => const AddDetails()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
