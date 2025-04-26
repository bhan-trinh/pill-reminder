import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final _picker = ImagePicker();

  pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null){
      _image = File(pickedFile.path);
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: _image == null? Text("No Image") : Image.file(_image!)
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            pickImage();
          },
          child: const Icon(Icons.camera_alt)),

      );
  }
}