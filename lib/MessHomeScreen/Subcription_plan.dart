import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liv_meal_app/constant/constants.dart';

class SubscribsionScreen extends StatefulWidget {
  const SubscribsionScreen({super.key});

  @override
  State<SubscribsionScreen> createState() => _SubscribsionScreenState();
}

class _SubscribsionScreenState extends State<SubscribsionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
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
    return Container(
      child: Column(
        children: [
          //     Padding(
          //       padding: const EdgeInsets.all(20),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Expanded(
          //             child: Text(
          //               "Flexible meal plans tailored to your routine. Choose what suits your appetite & schedule!",
          //               style: GoogleFonts.dmSans(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w500,
          //                 color: Color.fromRGBO(0, 0, 0, 1),
          //               ),
          //               softWrap: true,
          //               overflow: TextOverflow.visible,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     SizedBox(height: height * 0.02),
          //     _buildSubscriptionContainer(
          //       "Daily Plan",
          //       "₹100/",
          //       "meal per day",
          //       height,
          //       width,
          //     ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Liv',
                        style: GoogleFonts.dmSans(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      TextSpan(
                        text: 'Meal',
                        style: GoogleFonts.dmSans(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow[700],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 48), // For balance
              ],
            ),
          ),

          SizedBox(height: height * 0.02),

          // Plan cards with page view
          SizedBox(
            height: height * 0.5, // Reduced container height
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: 2,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                    }
                    return Center(
                      child: SizedBox(
                        height: Curves.easeOut.transform(value) * height * 0.45,
                        width: Curves.easeOut.transform(value) * width * 0.7,
                        child: child,
                      ),
                    );
                  },
                  child: _buildSubscriptionContainer(
                    index == 0 ? "Daily Plan" : "Weekly Plan",
                    index == 0 ? "₹100/" : "₹600/",
                    index == 0 ? "meal per day" : "week (6 meals)",
                    height,
                    width,
                  ),
                );
              },
            ),
          ),

          // Three dot indicator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.black : Colors.blue,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildPlanTypeButton(String text, int pageIndex) {
  //   return GestureDetector(
  //     onTap: () {
  //       _pageController.animateToPage(
  //         pageIndex,
  //         duration: Duration(milliseconds: 300),
  //         curve: Curves.easeInOut,
  //       );
  //     },
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //       decoration: BoxDecoration(
  //         color: _currentPage == pageIndex ? Colors.white : Colors.transparent,
  //         borderRadius: BorderRadius.circular(20),
  //         border: Border.all(color: Colors.white, width: 1.5),
  //       ),
  //       child: Text(
  //         text,
  //         style: GoogleFonts.dmSans(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w600,
  //           color: _currentPage == pageIndex ? Colors.blue : Colors.white,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSubscriptionContainer(
    String plan,
    String price,
    String duration,
    double height,
    double width,
  ) {
    return Container(
      width: width * 0.9,
      height: height * 0.7,

      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(237, 246, 249, 1),
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$plan\n\n",
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(255, 183, 3, 1),
                  ),
                ),
                TextSpan(
                  text: "$price$duration",
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(255, 183, 3, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  ".",
                  style: GoogleFonts.dmSans(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(255, 183, 3, 1),
                  ),
                ),
              ),
              SizedBox(width: width * 0.02),
              Expanded(
                child: Text(
                  "Perfect for: Trial or occasional users",
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(2, 48, 71, 1),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          // SizedBox(height: height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  ".",
                  style: GoogleFonts.dmSans(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(255, 183, 3, 1),
                  ),
                ),
              ),
              SizedBox(width: width * 0.02),
              Expanded(
                child: Text(
                  "Pay per meal, no commitment",
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(2, 48, 71, 1),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  ".",
                  style: GoogleFonts.dmSans(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(255, 183, 3, 1),
                  ),
                ),
              ),
              SizedBox(width: width * 0.02),
              Expanded(
                child: Text(
                  "Choose lunch, dinner, or both",
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(2, 48, 71, 1),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  ".",
                  style: GoogleFonts.dmSans(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(255, 183, 3, 1),
                  ),
                ),
              ),
              SizedBox(width: width * 0.02),
              Expanded(
                child: Text(
                  "Cancel anytime before the next meal",
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(2, 48, 71, 1),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.03),
          _MainSubscribeButton("Subscribe Now"),
        ],
      ),
    );
  }

  Widget _MainSubscribeButton(String text) {
    return Container(
      height: 40,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
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
