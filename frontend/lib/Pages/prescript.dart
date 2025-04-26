import 'package:flutter/material.dart';
import 'package:my_app/Widgets/med_card.dart';
import '../Themes/AppColors.dart';

class PrescriptPage extends StatelessWidget {
  const PrescriptPage({super.key});

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