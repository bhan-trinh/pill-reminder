import 'package:flutter/material.dart';
import 'package:my_app/Widgets/med_card.dart';
import '../Themes/AppColors.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


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
    loadJsonAsset();
  }

  Future<void> loadJsonAsset() async {
    final String jsonString =
        await rootBundle.loadString('lib/database/medLabels.json');
        
    var data = jsonDecode(jsonString);
    print(data);
    setState(() {
      jsonData = data;
    });
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

