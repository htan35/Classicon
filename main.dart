import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App with MYSQL',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  Future<void> sendData() async {
   final url = Uri.parse("http://10.0.2.2/createtable.php"); // Use 10.0.2.2 for Android Emulator
    final response = await http.post(
      url,
      body: {
        "name": nameController.text,
        "email": emailController.text,
        "mobile": mobileController.text,
      },
    );

    if (response.statusCode == 200) {
      print("Data inserted successfully");
    } else {
      print("Error inserting data: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.blue, // Change app bar color
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration( // Change background color
          color: Colors.grey[200],
        ),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(), // Add border
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(), // Add border
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(
                hintText: 'Mobile',
                border: OutlineInputBorder(), // Add border
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendData,
              child: const Text('Register'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Change button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}