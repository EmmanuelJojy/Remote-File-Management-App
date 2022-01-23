import 'package:flutter/material.dart';

import './routes/login.dart';
import './routes/home.dart';
import './routes/view.dart';
import './routes/edit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client App',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/home/view': (context) => const ViewPage(),
        '/home/edit': (context) => const EditPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'QuickSand',
      ),
    );
  }
}