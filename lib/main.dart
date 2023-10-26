//Carlos Daniel Taveras Liranzo (2021-2021)
import 'package:couteau/screens/WordPressPageView.dart';
import 'package:couteau/screens/age.dart';
import 'package:couteau/screens/contact.dart';
import 'package:couteau/screens/genderize.dart';
import 'package:couteau/screens/home.dart';
import 'package:couteau/screens/university.dart';
import 'package:couteau/screens/weather.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Tools',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(0, 178, 227,0)),
      ),
      initialRoute: '/home',
      routes: {
        '/genderize':(context) => genderize(),
        '/age': (context) => age(),
        '/UniversitiesView': (context) => UniversitiesView(),
        '/weather': (context) => weather(),
        '/WordPressPageView': (context) => WordPressPageView(),
        '/contact':(context) => contact(),
        '/home':(context) => home()
      },
    );
  }
}