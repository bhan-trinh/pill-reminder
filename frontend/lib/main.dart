import 'package:flutter/material.dart';
import 'Widgets/navigation_menu.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'Widgets/noti_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotiService().initNotification();
    // Get the app's documents directory
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/medLabels.json';

  // Save data to a JSON file
  final file = File(filePath);

  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const NavigationMenu(),
    );
  }
}

