import 'package:flutter/material.dart';
import 'package:my_app/Themes/AppColors.dart';

class MedCard extends Container {
  final String medName;
  final String dosage;

  MedCard({
    required this.medName,
    required this.dosage,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accent2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(medName, style: TextStyle(fontSize: 20)),
                Text(dosage)
               ],
             )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {}, child: Icon(Icons.close)),
              ElevatedButton(onPressed: () {}, child: Icon(Icons.check))
            ]
          ),
        
        ]
        ),
    );
  }
}