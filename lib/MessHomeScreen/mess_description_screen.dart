import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liv_meal_app/MessHomeScreen/subcription_plan_screen.dart';

class DescriptionScreen extends StatefulWidget {
  final Map<String, dynamic> messData;
  const DescriptionScreen({super.key, required this.messData});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  // Color theme
  final Color _primaryColor = const Color(0xFF006494);
  final Color _secondaryColor = const Color(0xFF0582CA);
  final Color _accentColor = const Color(0xFFFFB703);
  final Color _darkColor = const Color(0xFF023047);
  final Color _lightColor = const Color(0xFFEDF6F9);
  final Color _textColor = const Color(0xFF2B2D42);
  final Color _promoColor = const Color(0xFFFEEFBF);

  @override
  void initState() {
    super.initState();
    log("${widget.messData}");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: CustomScrollView(
        slivers: [_buildAppBar(), _buildContentSection(size)],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 60,
      backgroundColor: Colors.blue,
      elevation: 0,
      title: Text(
        "Mess Profile",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            // gradient: LinearGradient(
            //   colors: [_primaryColor, _secondaryColor],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildContentSection(Size size) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          color: _lightColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGallery(size.height * 0.25),
            const SizedBox(height: 20),
            _buildRatingSection(
              '${widget.messData['rating']} (${widget.messData['reviewCount']} Reviews)',
            ),
            const SizedBox(height: 20),
            _buildTitleSection(
              widget.messData['name'] ?? 'Mess Name',
              widget.messData['description'] ?? 'Description not available',
            ),
            const SizedBox(height: 20),
            _buildLocationAndMapButton(
              widget.messData['location'] ?? 'Address not available',
            ),
            const SizedBox(height: 20),
            _buildTimingSection(widget.messData['timings'] ?? {}),
            const SizedBox(height: 20),
            _buildSubscriptionPlans(widget.messData['plans'] ?? []),
            const SizedBox(height: 20),
            _buildSubscribeButton(),
            const SizedBox(height: 20),
            _buildReviewsHeader(),
            const SizedBox(height: 15),
            _buildReviewList(size),
            const SizedBox(height: 20),
            _buildPromoBanner(),
            const SizedBox(height: 20),
            _buildSimilarServicesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery(double height) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: _darkColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(
                Icons.photo_camera,
                size: 50,
                color: _darkColor.withOpacity(0.3),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildThumbnail(),
            _buildThumbnail(),
            _buildMorePhotosThumbnail(),
          ],
        ),
      ],
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 100,
        height: 80,
        color: _darkColor.withOpacity(0.1),
        child: Center(
          child: Icon(
            Icons.photo,
            size: 30,
            color: _darkColor.withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  Widget _buildMorePhotosThumbnail() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 100,
            height: 80,
            color: _darkColor.withOpacity(0.2),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withOpacity(0.4),
            ),
            child: Center(
              child: Text(
                "+5\nMore",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection(String rating) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _darkColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _accentColor, width: 2),
                ),
                child: Icon(Icons.star, color: _accentColor, size: 16),
              ),
              const SizedBox(width: 8),
              Text(
                rating,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "Voted Best Mess in Area",
            style: GoogleFonts.poppins(
              color: _textColor,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection(String messName, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          messName,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: _darkColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: _textColor.withOpacity(0.8),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationAndMapButton(String address) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.location_on, color: _secondaryColor, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: _darkColor,
                  ),
                ),
                Text(
                  "10 min away | 2.4 km from you",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: _textColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _lightColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _secondaryColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.map, size: 18, color: _secondaryColor),
                  const SizedBox(width: 6),
                  Text(
                    "Map",
                    style: GoogleFonts.poppins(
                      color: _secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimingSection(Map<String, dynamic> timings) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mess Timings",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _darkColor,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeCard(
                "Breakfast",
                timings['breakfast'] ?? 'Not available',
              ),
              _buildTimeCard("Lunch", timings['lunch'] ?? 'Not available'),
              _buildTimeCard("Dinner", timings['dinner'] ?? 'Not available'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard(String meal, String time) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _lightColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              meal,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: _darkColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              time,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 13, color: _textColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionPlans(List<dynamic> subscriptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Subscription Plans",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _darkColor,
          ),
        ),
        const SizedBox(height: 12),
        if (subscriptions.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...subscriptions.map((plan) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _buildPlanCard(
                      plan['name'] ?? 'Plan',
                      plan['price'] ?? '₹0',
                      plan['duration'] ?? 'per month',
                    ),
                  );
                }),
              ],
            ),
          )
        else
          Center(
            child: Text(
              'No subscription plans available',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: _textColor.withOpacity(0.7),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlanCard(String plan, String price, String duration) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_secondaryColor, _primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: _secondaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: GoogleFonts.poppins(
              color: _accentColor,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            duration,
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton() {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 5,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SubscriptionScreen()),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_accentColor, Color(0xFFFFD166)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _accentColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              "Subscribe Now",
              style: GoogleFonts.poppins(
                color: _darkColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsHeader() {
    return Row(
      children: [
        Text(
          "Reviews & Ratings",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _darkColor,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(
            "View All",
            style: GoogleFonts.poppins(
              color: _secondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewList(Size size) {
    return Column(
      children: [
        _buildReviewItem(
          "Suraj Kalamkar",
          "4",
          "Tastes just like home! I've been trying mess services for months, and Spice Tiffins is by far the best. Clean, filling meals, and delivery is always on time. Totally worth the monthly plan.",
          "1 day ago",
        ),
        const SizedBox(height: 15),
        _buildReviewItem(
          "Priya Sharma",
          "5",
          "Absolutely love the food quality and variety. The staff is very cooperative and the packaging is excellent. Highly recommended!",
          "3 days ago",
        ),
        const SizedBox(height: 15),
        Center(
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Load More Reviews",
              style: GoogleFonts.poppins(
                color: _secondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(
    String name,
    String rating,
    String review,
    String time,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: _lightColor,
                child: Text(
                  name.substring(0, 1),
                  style: GoogleFonts.poppins(
                    color: _darkColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: _darkColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: _accentColor, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: GoogleFonts.poppins(
                          color: _textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text(
                time,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: _textColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review,
            style: GoogleFonts.poppins(
              color: _textColor.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _promoColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Limited Time Offer!",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _darkColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Get ₹400 Signup Bonus when you register today.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: _darkColor,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 15),
          Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 3,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: _darkColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Sign Up Now",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Similar Mess Services",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _darkColor,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildSimilarServiceCard(),
              const SizedBox(width: 12),
              _buildSimilarServiceCard(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarServiceCard() {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 120,
              color: _lightColor,
              child: Center(
                child: Icon(
                  Icons.photo,
                  size: 40,
                  color: _darkColor.withOpacity(0.3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Spice Tiffin's (Veg/Non-veg)",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: _darkColor,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: _secondaryColor),
              const SizedBox(width: 4),
              Text(
                "Narhe, Pune",
                style: GoogleFonts.poppins(fontSize: 13, color: _textColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, size: 16, color: _accentColor),
              const SizedBox(width: 4),
              Text(
                "4.3 (245)",
                style: GoogleFonts.poppins(fontSize: 13, color: _textColor),
              ),
              const Spacer(),
              Text(
                "₹70/meal",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _secondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
