import 'package:flutter/material.dart';
import 'package:pdm/addPatient.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final username = TextEditingController();
  final password = TextEditingController();
  final _channel = WebSocketChannel.connect(
      Uri.parse('wss://http://127.0.0.1:5000/patient'));

  @override
  void initState() {
    super.initState();
    _channel.stream.listen((message) {
      print('Received: $message');
    });
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
            const Text("Login",
                style: TextStyle(fontSize: 30, color: Colors.black87)),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: username,
              decoration: InputDecoration(
                  labelText: "Username",
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
              controller: password,
              decoration: InputDecoration(
                  labelText: "Password",
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
                  String signUpData =
                      "{'email':'$username','hash':'$password'}";
                  // _channel.sink.add(signUpData);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddPatients()),
                  );
                } on Exception catch (e) {
                  //TODO();
                }
              },
              child: Container(
                color: Colors.blue,
                alignment: Alignment.center,
                height: size.height / 14,
                width: size.width / 2,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
