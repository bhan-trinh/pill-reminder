import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../Themes/AppColors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final _picker = ImagePicker();

  // Receive ImageSource parameter and pick from source
  getImage(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null){
      _image = File(pickedFile.path);
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: AppColors.primaryBackground,
      ),
      body: Column(
        children: [
          GestureDetector(
              onTap: () => getImage(ImageSource.camera),
              child: Stack (
                alignment: Alignment.center,
                children: <Widget> [
                Container(
                  height: 300,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(color: AppColors.accent2),
                ),
                Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_outlined, size: 100),
                          Text("Take Photo"),
                        ],
                      )
                )
                ]  )
              ),
          GestureDetector(
            onTap: () => getImage(ImageSource.gallery),
              child: Stack (
                alignment: Alignment.center,
                children: <Widget> [
                Container(
                  height: 100,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(color: AppColors.accent1),
                ),
                Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Choose from Gallery",
                        style: TextStyle(color: AppColors.primaryBackground),)
                )
                )
                ]  )
              ),

          
      ]
    )
   );
  }
}