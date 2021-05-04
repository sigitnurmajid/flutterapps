import 'package:flutter/material.dart';
// import 'app.dart';
import 'screens/infinity_scroll.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.teal[400]),
      home: RandomWords(),
    );
  }
}

