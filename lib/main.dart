import 'package:flutter/material.dart';
import 'package:liv_meal_app/MessHomeScreen/register_screen.dart';
import 'package:liv_meal_app/MessHomeScreen/subcription_plan_screen.dart';
import 'package:liv_meal_app/Screens/auth/OTP_screen.dart';
import 'package:liv_meal_app/Screens/auth/register_options.dart';
import 'package:liv_meal_app/Screens/student/register_screen.dart';
import 'package:liv_meal_app/Screens/student/student_dashboard.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OTPScreen(),
      // home: StudentDashboard(),
      // home: StudentRegisterScreen(),
      // home: MessRegistrationScreen(),
      // home: RegisterOptions(),
      // home: SubscriptionScreen(),
    );
  }
}
