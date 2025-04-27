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
    var data = loadJsonAsset('medLabels');
    setState(() {
      jsonData = data;
    });

    // loadJsonAsset('history');
  }

    Future<void> loadJsonAsset(filename) async {
    final String jsonString =
        await rootBundle.loadString('../../../backend/database/$filename.json');
    var data = jsonDecode(jsonString);
    setState(() {
      jsonData = data;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: AppColors.primaryBackground,
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return MedCard();
          },
      ),
      
     );
  }
}

