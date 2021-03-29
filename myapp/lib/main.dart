import 'package:flutter/material.dart';
import 'package:myapp/App.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Students',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new App());
  }
}
