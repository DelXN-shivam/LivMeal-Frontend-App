import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: CustomScrollView(
        slivers: [_buildAppBar(), _buildContentSection(height, width)],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: 150,
      backgroundColor: Colors.blue,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {},
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          child: IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text(
          "LivMeal",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          color: Colors.blue,
          padding: const EdgeInsets.only(bottom: 60),
          child: const Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: []),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildContentSection(double height, double width) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageGallery(height),
              const SizedBox(height: 20),
              _buildRatingSection("4.2 (245)"),
              const SizedBox(height: 20),
              _buildTitleSection(),
              const SizedBox(height: 20),
              _buildDescriptionSection(),
              const SizedBox(height: 20),
              _buildLocationAndMapButton(width, height),
              const SizedBox(height: 20),

              _buildTimingCard(width, "8-10 AM", "1-2 PM", "8-10 PM"),
              const SizedBox(height: 20),
              _buildSubscriptionPlans(),
              const SizedBox(height: 20),
              Center(child: _buildSubscribeButton()),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildReviewsSection(width, " 4.2 (245)"),

                  SizedBox(width: width * 0.09),
                  ratingReviewing(
                    "vary good \n",
                    "47 Users Reviews\n& 122 Ratings",
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),

              Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: 440,
                      decoration: BoxDecoration(
                        // color: const Color.fromRGBO(255, 255, 255, 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(5, -5),
                            blurRadius: 10,
                            spreadRadius:
                                -2, // Negative spread makes it more contained
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          PeopleRatingContainer(
                            "4",
                            "Suraj kalamkar",
                            """Tastes just like home! I've been trying mess services for months, and Spice Tiffins is by far the best. Clean, filling meals, and delivery is always on time. Totally worth the monthly plan.""",
                            "24-7-2025",
                            "1 DAY AGO",
                          ),

                          SizedBox(height: height * 0.01),
                          PeopleRatingContainer(
                            "4",
                            "Suraj kalamkar",
                            """Tastes just like home! I've been trying mess services for months, and Spice Tiffins is by far the best. Clean, filling meals, and delivery is always on time. Totally worth the monthly plan.""",
                            "24-7-2025",
                            "1 DAY AGO",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.53,
                    left: width * 0.2,
                    child: _buildSignupButton("View More.."),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildPromoBanner(height),
              const SizedBox(height: 20),
              _buildSimilarServicesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageGallery(double height) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            "assets/images/Rectangle 75.png",
            width: double.infinity,
            height: height * 0.2,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildThumbnail("assets/images/Rectangle 76.png"),
            _buildThumbnail("assets/images/Rectangle 77.png"),
            _buildMorePhotosThumbnail(),
          ],
        ),
      ],
    );
  }

  Widget _buildThumbnail(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(imagePath, width: 100, height: 100, fit: BoxFit.cover),
    );
  }

  Widget _buildMorePhotosThumbnail() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            "assets/images/Rectangle 79.png",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.5),
            ),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "+5\n",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "More Photos",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget ratingReviewing(String msg, String rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: msg,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromRGBO(255, 183, 3, 1),
                ),
              ),
              const TextSpan(text: " "),
              TextSpan(
                text: rating,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromRGBO(2, 48, 71, 1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(0, 119, 182, 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(255, 183, 3, 1),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.star,
              color: Color.fromRGBO(255, 183, 3, 1),
              size: 16,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Spice Tiffin's (Veg)",
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Home-style veg & non-veg meals with weekly menu and doorstep delivery.",
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return const SizedBox(); // Add your description widgets here
  }

  Widget _buildLocationAndMapButton(double width, double height) {
    return Row(
      children: [
        const Icon(
          Icons.location_pin,
          size: 16,
          color: Color.fromRGBO(2, 48, 71, 1),
        ),
        const SizedBox(width: 5),
        Text(
          "Nerhe, Pune | 10 min",
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(2, 48, 71, 1),
          ),
        ),
        const Spacer(),
        _buildMapButton(width, height),
      ],
    );
  }

  Widget _buildMapButton(double width, double height) {
    return Container(
      width: width * 0.3,
      height: height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color.fromRGBO(237, 246, 249, 1),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/Group 40.png", height: 20, width: 20),
            const SizedBox(width: 5),
            Text(
              "Map",
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(2, 48, 71, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionPlans() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildSubscriptionContainer("Daily Plan", "₹100/meal", "per day"),
          const SizedBox(width: 16),
          _buildSubscriptionContainer("Weekly Plan", "₹700/meal", "per day"),
          const SizedBox(width: 16),
          _buildSubscriptionContainer("Monthly Plan", "₹2800/meal", "per day"),
        ],
      ),
    );
  }

  Widget _buildSubscriptionContainer(
    String plan,
    String price,
    String duration,
  ) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(0, 119, 182, 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Subscribe to",
            style: GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$plan\n",
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(255, 183, 3, 1),
                  ),
                ),
                TextSpan(
                  text: "$price\n$duration",
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton() {
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
          "Subscribe Now!",
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsSection(double width, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reviews & Ratings",
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromRGBO(237, 246, 249, 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(255, 183, 3, 1),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.star,
                      color: Color.fromRGBO(255, 183, 3, 1),
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    text,
                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(2, 48, 71, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget PeopleRatingContainer(
    String rating,
    String name,
    String description,
    String date,
    String time,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.2),
        //     offset: Offset(-3, 3), // Negative Y value makes shadow appear above
        //     blurRadius: 6,
        //     spreadRadius: 1,
        //   ),
        // ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromRGBO(237, 246, 249, 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(255, 183, 3, 1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Color.fromRGBO(255, 183, 3, 1),
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        rating,
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(2, 48, 71, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  name,
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(2, 48, 71, 1),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: Text(
                    description,
                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(2, 48, 71, 1),
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    date,
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    time,
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner(double height) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(254, 236, 191, 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Limited Time Offer ₹400\nSignup Bonus!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(2, 48, 71, 1),
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            const Text(
              "Register now and claim your instant reward.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(2, 48, 71, 1),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: height * 0.04),
            _buildSignupButton("Sign Up!"),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupButton(String text) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromRGBO(255, 182, 0, 1),
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
      ),
    );
  }

  Widget _buildSimilarServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Similar Mess Services For You!",
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildServiceCard(),
              const SizedBox(width: 10),
              _buildServiceCard(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard() {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(237, 246, 249, 1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/Rectangle 35 (1).png",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Spice Tiffin's (Veg/ Non-veg)",
                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(2, 48, 71, 1),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_pin, size: 16),
                      const SizedBox(width: 5),
                      Text(
                        "Narhe, Pune | 2.4 km",
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(2, 48, 71, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(255, 183, 3, 1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Color.fromRGBO(255, 183, 3, 1),
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "4.3 (245)",
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₹70 /Meal",
                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromRGBO(0, 119, 182, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimingCard(
    double width,
    String breakfastTime,
    String lunchTime,
    String dinnerTime,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Color.fromRGBO(2, 48, 71, 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Mess Timing",
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(2, 48, 71, 1),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: width * 0.28,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Color.fromRGBO(2, 48, 71, 1)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Breakfast",
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(2, 48, 71, 1),
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          breakfastTime,
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(2, 48, 71, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: width * 0.28,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Color.fromRGBO(2, 48, 71, 1)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Lunch",
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(2, 48, 71, 1),
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          breakfastTime,
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(2, 48, 71, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: width * 0.28,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Dinner",
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(2, 48, 71, 1),
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          breakfastTime,
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(2, 48, 71, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
