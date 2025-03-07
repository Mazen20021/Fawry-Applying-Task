import 'package:fawrytask/Desktop/Common_Pages/login.dart';
import 'package:fawrytask/Desktop/Common_Pages/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => const Login(),
        '/home/admin': (context) => const Login(),
        '/home/admin/settings': (context) => const Login(),
        '/home/settings': (context) => const Login(),
        '/home/movies': (context) => const Login(),
        '/home/search': (context) => const Login(),
        '/signup': (context) => const Signup(),
      },
       initialRoute: '/login',
    );
  }
}
