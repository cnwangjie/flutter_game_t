import 'package:flutter/material.dart';

import './content.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ttt',
      home: Content(),
    );
  }
}
