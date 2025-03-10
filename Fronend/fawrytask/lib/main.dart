import 'package:fawrytask/Desktop/Admin/current_movies.dart';
import 'package:fawrytask/Desktop/Admin/home_admin.dart';
import 'package:fawrytask/Desktop/Admin/movie_managment.dart';
import 'package:fawrytask/Desktop/Common_Pages/login.dart';
import 'package:fawrytask/Desktop/Common_Pages/movie_details.dart';
import 'package:fawrytask/Desktop/Common_Pages/signup.dart';
import 'package:fawrytask/Desktop/Users/home_user.dart';
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
        '/home/admin': (context) => const AdminPage(),
        '/home/admin/currentmovies': (context) =>  CurrentMovies(),
        '/home': (context) =>  UserPage(),
        '/home/settings': (context) => const Login(),
        '/home/movies': (context) => const Login(),
        '/home/admin/movies': (context) => const Login(),
        '/home/admin/moviemanagement': (context) => const MovieManagment(),
        '/signup': (context) => const Signup(),
      },
       initialRoute: '/login',
    );
  }
}
