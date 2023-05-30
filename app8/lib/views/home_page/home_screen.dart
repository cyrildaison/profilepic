// ignore_for_file: avoid_print, duplicate_ignore

import 'package:app8/views/home_page/Addstudent.dart';
import 'package:app8/views/home_page/edit.dart';
import 'package:app8/views/login_page/login_screen.dart';
import 'package:flutter/material.dart';

class Student {
  late final String name;
  late final String grade;

  Student({required this.name, required this.grade, required id});
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final List<Student> students = [
    Student(name: 'John Doe', grade: 'A', id: null),
    Student(name: 'Jane Smith', grade: 'B', id: null),
    Student(name: 'Mike Johnson', grade: 'C', id: null),
  ];

  // ignore: non_constant_identifier_names
  void AddStudent(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddStudentPage()),
    );
    if (result != null && result is Student) {
      students.add(result);
      print('New student added: ${result.name}');
    }
  }

  void editStudent(BuildContext context, Student student) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditStudentPage(student: student),
      ),
    );
    if (result != null && result is Student) {
      // Update the student record with the edited data
      student.name = result.name;
      student.grade = result.grade;
      // ignore: avoid_print
      print('Student edited: ${result.name}');
    }
  }

  void deleteStudent(Student student) {
    students.remove(student);
    // ignore: avoid_print
    print('Student deleted: ${student.name}');
  }

  void showLogoutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
                // Add your logout logic here

                // Print a message indicating logout
                print('User logged out');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showLogoutPopup(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('lib/assets/god.png'),
            ),
            title: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(student.name),
              ),
            ),
            subtitle: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(student.grade),
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                deleteStudent(student);
              },
            ),
            onTap: () {
              editStudent(context, student);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddStudent(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
