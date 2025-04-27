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
    print(data);
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
        itemCount: jsonData != null ? jsonData.length : 0,
        itemBuilder: (BuildContext context, int index) {
          final medPlanRaw = jsonData[index.toString()];
          final medPlan = jsonDecode(medPlanRaw);
          print("HEY THIS IS $medPlan");
          print(medPlan.runtimeType);
          return MedCard(
            medName: medPlan["Medication"],
            dosage: medPlan["Dosage"],
            instructions: medPlan["Instructions"],
          );
          },
      ),
      
     );
  }
}

