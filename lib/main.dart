import 'package:flutter/material.dart';
import 'package:liv_meal_app/MessHomeScreen/Checkout_Screen.dart';
import 'package:liv_meal_app/MessHomeScreen/Description_Screen.dart';
import 'package:liv_meal_app/MessHomeScreen/PaymentSuccesful.dart';
import 'package:liv_meal_app/MessHomeScreen/Payment_Screen.dart';
import 'package:liv_meal_app/MessHomeScreen/Subcription_plan.dart';
import 'package:liv_meal_app/MessHomeScreen/homescreen.dart';
import 'package:liv_meal_app/Screens/home_page.dart';
import 'package:liv_meal_app/Screens/login_screen.dart';
import 'package:liv_meal_app/Screens/registration_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SubscribsionScreen(),
    );
  }
}
