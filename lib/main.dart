import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
// ignore: unused_import
import 'home.dart';
import 'login.dart';
import 'add_Screen.dart';

void main() async{
   await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const LoginScreen(), 
    );
  }
}
