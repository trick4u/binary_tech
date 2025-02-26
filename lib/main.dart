
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'drag_drop_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DragDropScreen(),
    );
  }
}

