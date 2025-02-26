import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

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

class DragDropScreen extends StatefulWidget {
  @override
  _DragDropScreenState createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _setupDragAndDrop();
  }

  void _setupDragAndDrop() {
    final dropZone = html.document.body;
    if (dropZone != null) {
      dropZone.addEventListener("dragover", (event) {
        event.preventDefault();
      });
      dropZone.addEventListener("drop", (event) {
        event.preventDefault();
        final dataTransfer = (event as html.MouseEvent).dataTransfer;
        if (dataTransfer != null && dataTransfer.files!.isNotEmpty) {
          final file = dataTransfer.files![0];
          _handleFile(file);
        }
      });
    }
  }

  void _handleFile(html.File file) {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    reader.onLoadEnd.listen((event) {
      setState(() {
        _imageBytes = reader.result as Uint8List;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
            image: _imageBytes != null
                ? DecorationImage(
                    image: MemoryImage(_imageBytes!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          alignment: Alignment.center,
          child: _imageBytes == null
              ? Text("Drag & Drop an Image Here")
              : null,
        ),
      ),
    );
  }
}
