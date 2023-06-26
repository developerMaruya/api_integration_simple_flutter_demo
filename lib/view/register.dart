import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/displaydata.dart';
import 'package:flutter_application_1/view/successpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _empFormKey = GlobalKey<FormState>();
  final _studentFormKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  void _submitEmpForm() async {
    if (_empFormKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;

      // Create a map of the data to send
      Map<String, dynamic> data = {
        'empName': name,
        'empEmail': email,
      };

      // Convert the data to JSON format
      String jsonData = jsonEncode(data);

      // Send a POST request to the API endpoint
      var response = await http.post(
        Uri.parse('http://192.168.29.224:3000/api/users/employee'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Successful response
        // Display success page or show a success message
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessPage(),
          ),
        );
      } else {
        // Error handling
        // Display an error message or handle the error in an appropriate way
        print('Error: ${response.statusCode}');
      }

      // Placeholder logic, replace with your form submission code
      print('Name: $name');
      print('Email: $email');
    }
  }

  void showstudentdetails() async {
    var response = await http.get(
      Uri.parse('http://192.168.29.224:3000/api/users/studentsdetails'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // Check the response status
    if (response.statusCode == 200) {
      // Successful response
      // Extract the data from the response
      var responseData = jsonDecode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplaydataPage(
              data: responseData), // Pass the data to SuccessPage
        ),
      );

      // Display the details or handle the data in an appropriate way
      print(responseData);
    } else {
      // Error handling
      // Display an error message or handle the error in an appropriate way
      print('Error: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Form(
                key: _empFormKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Register Employee Using Api',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        // You can add more email validation logic if needed
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _submitEmpForm,
                      child: const Text('Submit'),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: showstudentdetails,
                    child: const Text('Student Details'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
