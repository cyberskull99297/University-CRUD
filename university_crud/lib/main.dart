import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:university_crud/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(const MyApp());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // const MyApp({Key? key}) : super(key: key);
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // CHeck for Errors
        if (snapshot.hasError) {
          print("Something went Wrong");
        }
        // once Completed, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter Firestore CRUD',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: Homepage(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
