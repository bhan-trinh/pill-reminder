import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/Widgets/med_card.dart';
import 'package:my_app/Widgets/noti_service.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import '../Themes/AppColors.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var logger = Logger();
  File? _image;
  final _picker = ImagePicker();

  // Receive ImageSource parameter and pick from source
  getImage(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {});
    }
  }

  Future ocr(File? image) async {
    if (image == null) {
      throw Exception("Null Image");
    }

    try {
      var uri = Uri.parse('https://pill-reminder-amj9.onrender.com/');

      var request =
          http.MultipartRequest("POST", uri)
            ..headers['Content-Type'] = 'multipart/form-data'
            ..files.add(
              await http.MultipartFile.fromPath(
                'file',
                image.path,
                contentType: MediaType('image', 'jpg'),
              ),
            );

      var response = await request.send().timeout(Duration(seconds: 60));

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        return responseString;
      } else {
        var responseString = await response.stream.bytesToString();
        throw Exception(
          "Failed to process image. Status: ${response.statusCode}, Response: $responseString",
        );
      }
    } catch (e) {
      throw Exception("Error during OCR request: $e");
    }
  }

  void saveData(jsonResponse) async {
    // Get the app's documents directory
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/medLabels.json';

    // Save data to a JSON file
    final file = File(filePath);

    // Smh write it to be " '1': {jsonData}" please
    Map<String, dynamic> jsonData = {
      "0": jsonResponse, // Not string, just real JSON
    };
    await file.writeAsString(jsonEncode(jsonData));

    print('JSON saved locally to: $filePath');
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
            onTap: () async {
              await getImage(ImageSource.camera);
              final response = await ocr(_image);
              final notificationService = NotiService();
              await notificationService.showNotificationWithDelay(
                title: "Time to take your medicaton.",
                body: "",
              );
              logger.d(response);
              saveData(response);
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 200,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(color: AppColors.accent2),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined, size: 75),
                      Text(
                        "Take Photo",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await getImage(ImageSource.gallery);
              final response = await ocr(_image);
              logger.d(response);
              saveData(response);
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
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
                      style: TextStyle(color: AppColors.primaryBackground, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text("Today's Plans",style: TextStyle(
                          fontSize: 20,
                        ),),
          SizedBox(
            height: 200,
            child: 
            Center(child:ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return MedCard(medName: "Ibuprofen", dosage: "2 pills");
              },
            ),),

          ),
        ],
      ),
    );
  }
}
