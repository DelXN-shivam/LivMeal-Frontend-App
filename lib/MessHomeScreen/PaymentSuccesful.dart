import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Paymentsuccesful extends StatefulWidget {
  const Paymentsuccesful({super.key});

  @override
  State<Paymentsuccesful> createState() => _PaymentsuccesfulState();
}

class _PaymentsuccesfulState extends State<Paymentsuccesful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Liv',
                          style: GoogleFonts.dmSans(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Meal',
                          style: GoogleFonts.dmSans(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Image.asset("assets/images/Group 113.png"),
            // SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Congratulations!\nyour payment was   \nsuccessful!",
                  style: GoogleFonts.dmSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),

                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
            SizedBox(height: 80),
            _MainSubscribeButton("Go To HomePage"),
          ],
        ),
      ),
    );
  }

  Widget _MainSubscribeButton(String text) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        // gradient: const LinearGradient(
        //   colors: [
        //     Color.fromRGBO(0, 167, 255, 1),
        //     Color.fromRGBO(0, 119, 182, 1),
        //   ],
        //   begin: Alignment.bottomCenter,
        //   end: Alignment.topCenter,
        // ),
        color: Color.fromRGBO(255, 182, 0, 1),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
