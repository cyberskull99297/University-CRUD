import 'package:flutter/material.dart';
import 'package:university_crud/pages/add_student_page.dart';
import 'package:university_crud/pages/list_student_page.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('University CRUD'),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudentPage(),
                  ),
                )
              },
              child: Text('Add', style: TextStyle(fontSize: 20.0)),
              style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
            )
          ],
        ),
      ),
      body: ListStudentPage(),
    );
  }
}
