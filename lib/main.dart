import 'package:flutter/material.dart';
import 'package:liv_meal_app/MessHomeScreen/Description_Screen.dart';
import 'package:liv_meal_app/MessHomeScreen/homescreen.dart';
import 'package:liv_meal_app/Screens/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MesshomeScreen(),
    );
  }
}
