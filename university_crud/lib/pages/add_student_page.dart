import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();

  var year = "";
  var degree = "";
  var rollNo = "";

  final yearController = TextEditingController();
  final degreeController = TextEditingController();
  final rollNoController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller
    yearController.dispose();
    degreeController.dispose();
    rollNoController.dispose();
    super.dispose();
  }

  clearText() {
    yearController.clear();
    degreeController.clear();
    rollNoController.clear();
  }

  // Adding Student
  CollectionReference Ustudents =
      FirebaseFirestore.instance.collection('University_students');

  Future<void> addUser() {
    // print("User Added");
    return Ustudents.add({'year': year, 'degree': degree, 'rollNo': rollNo})
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Student"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Year: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: yearController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Year';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Degree: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: degreeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Degree';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Roll Number: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: rollNoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Roll Number';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            print("USer");
                            year = yearController.text;
                            degree = degreeController.text;
                            rollNo = rollNoController.text;
                            addUser();
                            clearText();
                          });
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {clearText()},
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
