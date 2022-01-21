import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e#active1',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.pink,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              height: 2,
              color: Colors.white),
          headline2: TextStyle(
              fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.pink),
          headline3: TextStyle(fontSize: 18.0, color: Colors.white),
          bodyText1: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
          bodyText2: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
          caption: TextStyle(
              fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.pink),
        ),
      ),
      home: const HomePage(
        title: 'e#active',
      ),
    );
  }
}
