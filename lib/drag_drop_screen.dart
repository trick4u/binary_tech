import 'dart:html' as html;

import 'dart:typed_data';

import 'package:flutter/material.dart';

class DragDropScreen extends StatefulWidget {
  @override
  _DragDropScreenState createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  //we need to store the image bytes in a variable
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    //setup drag and drop
    _setupDragAndDrop();
  }

  // simple drag and drop setup
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
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2),
            image: _imageBytes != null
                ? DecorationImage(
                    image: MemoryImage(_imageBytes!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          alignment: Alignment.center,
          child: _imageBytes == null ? Text("Drag & Drop Image here") : null,
        ),
      ),
    );
  }
}
