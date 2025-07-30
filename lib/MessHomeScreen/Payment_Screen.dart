import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liv_meal_app/constant/constants.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isChecked = false;
  bool isGooglePaySelected = false;
  bool isPhonePeSelected = false;
  bool isPaytmSelected = false;
  bool isvisaCardSelected = false;
  bool isMastrecardSelected = false;
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
            height: height * 0.06,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromRGBO(237, 246, 249, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isMastrecardSelected = !isMastrecardSelected;
                    // Unselect others when selecting this
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mastercard",
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(2, 48, 71, 1),
                      ),
                    ),
                    // Icon(Icons.check_box_outline_blank_outlined),
                    Icon(
                      isMastrecardSelected
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank_outlined,
                      color: isMastrecardSelected ? Colors.blue : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.01),
          GestureDetector(
            onTap: () {
              setState(() {
                isvisaCardSelected = !isvisaCardSelected;
                // Unselect others when selecting this
              });
            },
            child: Container(
              height: height * 0.06,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(237, 246, 249, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Visa",
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(2, 48, 71, 1),
                      ),
                    ),
                    // Icon(Icons.check_box_outline_blank_outlined),
                    Icon(
                      isvisaCardSelected
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank_outlined,
                      color: isvisaCardSelected ? Colors.blue : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            "UPI Payment",
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          SizedBox(height: height * 0.02),
          GestureDetector(
            onTap: () {
              setState(() {
                isGooglePaySelected = !isGooglePaySelected;
              });
            },
            child: Container(
              height: height * 0.06,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(237, 246, 249, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Google Pay",
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(2, 48, 71, 1),
                      ),
                    ),
                    // Icon(Icons.check_box_outline_blank_outlined),
                    Icon(
                      isGooglePaySelected
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank_outlined,
                      color: isGooglePaySelected ? Colors.blue : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          GestureDetector(
            onTap: () {
              setState(() {
                isPhonePeSelected = !isPhonePeSelected;
              });
            },
            child: Container(
              height: height * 0.06,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(237, 246, 249, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phone pay",
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(2, 48, 71, 1),
                      ),
                    ),
                    // Icon(Icons.check_box_outline_blank_outlined),
                    Icon(
                      isPhonePeSelected
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank_outlined,
                      color: isPhonePeSelected ? Colors.blue : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            "Payment via bank account",
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          SizedBox(height: height * 0.02),

          GestureDetector(
            onTap: () {
              setState(() {
                isPaytmSelected = !isPaytmSelected;
              });
            },
            child: Container(
              height: height * 0.06,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(237, 246, 249, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color.fromRGBO(255, 183, 3, 1),
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Color.fromRGBO(255, 183, 3, 1),
                      ),
                    ),
                    Text(
                      "Add bank account",
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(2, 48, 71, 1),
                      ),
                    ),
                    // Icon(Icons.check_box_outline_blank_outlined),
                    Icon(
                      isPaytmSelected
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank_outlined,
                      color: isPaytmSelected ? Colors.blue : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            height: height * 0.06,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromRGBO(237, 246, 249, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Payment",
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(2, 48, 71, 1),
                    ),
                  ),

                  // Icon(Icons.check_box_outline_blank_outlined),
                  Text(
                    "₹2,400",
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
          _MainSubscribeButton("Pay now"),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _MainSubscribeButton(String text) {
    return Container(
      height: 50,
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
