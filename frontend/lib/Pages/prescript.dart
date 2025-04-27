import 'package:flutter/material.dart';
import 'package:my_app/Widgets/med_card.dart';
import '../Themes/AppColors.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class PrescriptPage extends StatefulWidget {
  const PrescriptPage({super.key});

  @override
  State<PrescriptPage> createState() => _PrescriptPageState();
}

class _PrescriptPageState extends State<PrescriptPage> {
  var jsonData;

  @override
  void initState() {
    super.initState();
    loadLocalJsonData();
  }

  Future<void> loadLocalJsonData() async {
  // Get the app's documents directory
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/medLabels.json';

  final file = File(filePath);
  if (await file.exists()) {
    final jsonString = await file.readAsString();
    final data = jsonDecode(jsonString);
    setState(() {
      jsonData = data;
    });
  } else {
    print("No local file found.");
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: const Text("Medicine Plans"),
        backgroundColor: AppColors.primaryBackground,
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return MedCard(
            medName: jsonData[index.toString()]["name"],
            dosage: jsonData[index.toString()]["dosage"],

          );
          },
      ),
      
     );
  }
}

