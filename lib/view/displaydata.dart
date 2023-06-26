import 'package:flutter/material.dart';

class DisplaydataPage extends StatelessWidget {
  final List<dynamic> data; // Add a field to store the received data

  DisplaydataPage(
      {required this.data}); // Update the constructor to accept the data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var student = data[index];
            return ListTile(
              title: Text('Student ID: ${student['id']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(".........................................."),
                  Text('Student Name: ${student['sname']}'),
                  Text('Course ID: ${student['cid']}'),
                  Text('Course Name: ${student['courseName']}'),
                  Text('subject id: ${student['suid']}'),
                  Text('all Subjects: ${student['allSubjectName']}'),
                  Text('mobile: ${student['mobile']}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
