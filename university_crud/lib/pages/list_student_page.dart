import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:university_crud/pages/update_student_page.dart';

class ListStudentPage extends StatefulWidget {
  ListStudentPage({Key? key}) : super(key: key);

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('University_students').snapshots();

  CollectionReference Ustudents =
      FirebaseFirestore.instance.collection('University_students');

  Future<void> deleteUser(id) {
    return Ustudents.doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to Delete User: $error"));
    // print("user deleted $id");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map StList = document.data() as Map<String, dynamic>;
            storedocs.add(StList);
            StList['id'] = document.id;
          }).toList();

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(80),
                    1: FixedColumnWidth(80),
                    2: FixedColumnWidth(90)
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            color: Colors.yellowAccent,
                            child: Center(
                              child: Text(
                                'Year',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            color: Colors.yellowAccent,
                            child: Center(
                              child: Text(
                                'Degree',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            color: Colors.yellowAccent,
                            child: Center(
                              child: Text(
                                'Roll No.',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            color: Colors.yellowAccent,
                            child: Center(
                              child: Text(
                                'Action',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    for (var i = 0; i < storedocs.length; i++) ...[
                      TableRow(
                        children: [
                          TableCell(
                            child: Center(
                                child: Text(storedocs[i]['year'],
                                    style: TextStyle(fontSize: 18.0))),
                          ),
                          TableCell(
                            child: Center(
                                child: Text(storedocs[i]['degree'],
                                    style: TextStyle(fontSize: 18.0))),
                          ),
                          TableCell(
                            child: Center(
                                child: Text(storedocs[i]['rollNo'],
                                    style: TextStyle(fontSize: 18.0))),
                          ),
                          TableCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateStudentPage(
                                            id: storedocs[i]['id']),
                                      ),
                                    )
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      {deleteUser(storedocs[i]['id'])},
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        });
  }
}
