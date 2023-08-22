import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Fetch_CheckBox.dart';
import 'package:flutter_firebase/Fetch_Data.dart';
import 'package:flutter_firebase/Fetch_Data_1.dart';
import 'package:flutter_firebase/Home_Screen.dart';
import 'package:flutter_firebase/Registration_Form.dart';
import 'Fetch_1.dart';
import 'FireBase_Update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FireBase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Update_1(),
    );
  }
}

