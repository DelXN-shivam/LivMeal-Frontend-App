import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:liv_meal_app/constant/constants.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  DateTime? _selectedDate;
  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollViewreturn(
        "Subcription",
        Icon(Icons.close, color: Colors.white),
        context,
        ProductScreen(),
      ),
    );
  }

  Widget ProductScreen() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            "Your plan",
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.black,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Monthly Plan",
                filled: true,
                fillColor: Color.fromRGBO(237, 246, 249, 1),

                border: InputBorder.none,
                suffix: Icon(Icons.edit, color: Color.fromRGBO(255, 183, 3, 1)),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            "Date",
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              // color: Colors.black,
            ),
            child: TextField(
              controller: _dateController,
              decoration: InputDecoration(
                hintText: "Select Date",

                // labelText: "Plan",
                filled: true,
                fillColor: Color.fromRGBO(237, 246, 249, 1),
                suffix: Icon(
                  Icons.edit_calendar,
                  color: Color.fromRGBO(255, 183, 3, 1),
                ),
                border: InputBorder.none,
              ),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            "Your plan",
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            height: height * 0.15,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromRGBO(237, 246, 249, 1),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Monthly Plan",
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(2, 48, 71, 1),
                        ),
                      ),
                      Text(
                        "₹2,700",
                        style: GoogleFonts.dmSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: const Color.fromRGBO(0, 119, 182, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Monthly Plan",
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(2, 48, 71, 1),
                        ),
                      ),
                      Text(
                        "₹300",
                        style: GoogleFonts.dmSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: const Color.fromRGBO(0, 119, 182, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            height: height * 0.05,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromRGBO(237, 246, 249, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Monthly Plan",
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(2, 48, 71, 1),
                    ),
                  ),

                  Text(
                    "₹300",
                    style: GoogleFonts.dmSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromRGBO(0, 119, 182, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          _MainSubscribeButton("Checkout"),
        ],
      ),
    );
  }

  Widget _MainSubscribeButton(String text) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(0, 167, 255, 1),
            Color.fromRGBO(0, 119, 182, 1),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
