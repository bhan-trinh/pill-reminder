import 'package:flutter/material.dart';
import 'package:my_app/Themes/AppColors.dart';

class MedCard extends Container {
  MedCard({super.key});

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
            Container(
              height: 80,
              width: 100,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(0),
              color: Colors.white,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ibuprofen", style: TextStyle(fontSize: 20)),
                Text("2 Pills")
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