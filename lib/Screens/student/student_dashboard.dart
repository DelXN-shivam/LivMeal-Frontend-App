import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liv_meal_app/MessHomeScreen/mess_listing_screen.dart';
import 'package:liv_meal_app/MessHomeScreen/mess_description_screen.dart';
import 'package:liv_meal_app/models/mess_model.dart';
import 'package:liv_meal_app/services/mess_api_service.dart';
import 'package:liv_meal_app/Screens/notifications_screen.dart';
import 'package:liv_meal_app/Screens/student/profile_screen.dart';
import 'package:liv_meal_app/widgets/mess_card_shimmer.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final TextEditingController _searchController = TextEditingController();
  List<MessModel> allMesses = [];
  List<MessModel> displayedMesses = [];
  bool isLoading = true;
  String? errorMessage;
  int _selectedIndex = 0;
  final List<Map<String, String>> cities = [
    {'image': 'assets/images/Group 7.png', 'name': 'Pune'},
    {'image': 'assets/images/Group 7 (2).png', 'name': 'Mumbai'},
    {'image': 'assets/images/Group 7 (3).png', 'name': 'Nashik'},
    {'image': 'assets/images/Group 7 (4).png', 'name': 'Kolhapur'},
    {'image': 'assets/images/Group 7.png', 'name': 'Pune'},
  ];

  final List<Map<String, dynamic>> messServices = [
    {
      'image': 'assets/images/Rectangle 35 (1).png',
      'title': "Spice Tiffin's (Veg/ Non-veg)",
      'location': "Narhe, Pune",
      'distance': "2.4 km",
      'rating': "4.3 (245)",
      'price': "₹70 /Meal",
    },
    {
      'image': 'assets/images/Rectangle 35 (1).png',
      'title': "Healthy Meal Box (Pure Veg)",
      'location': "Warje, Pune",
      'distance': "3.1 km",
      'rating': "4.6 (178)",
      'price': "₹80 /Meal",
    },
    {
      'image': 'assets/images/Rectangle 35 (1).png',
      'title': "Homely Tiffins (Veg)",
      'location': "Katraj, Pune",
      'distance': "1.9 km",
      'rating': "4.2 (312)",
      'price': "₹60 /Meal",
    },
    {
      'image': 'assets/images/Rectangle 35 (1).png',
      'title': "Tiffin Junction (Veg / Egg)",
      'location': "Sinhgad Road, Pune",
      'distance': "4.0 km",
      'rating': "4.5 (289)",
      'price': "₹75 /Meal",
    },
    {
      'image': 'assets/images/Rectangle 35 (1).png',
      'title': "Maa Ki Rasoi (North Indian)",
      'location': "Dhayari, Pune",
      'distance': "2.2 km",
      'rating': "4.4 (198)",
      'price': "₹85 /Meal",
    },
    {
      'image': 'assets/images/Rectangle 35 (1).png',
      'title': "Daily Bites (South Indian Veg)",
      'location': "Anand Nagar, Pune",
      'distance': "3.7 km",
      'rating': "4.1 (166)",
      'price': "₹65 /Meal",
    },
  ];

  // Colors
  static const Color primaryColor = Color.fromRGBO(2, 48, 71, 1);
  static const Color secondaryColor = Color.fromRGBO(0, 119, 182, 1);
  static const Color accentColor = Color.fromRGBO(255, 183, 3, 1);
  static const Color offerBackground = Color.fromRGBO(254, 236, 191, 1);

  // Text Styles
  TextStyle get titleStyle => GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: primaryColor,
  );

  TextStyle get itemTitleStyle => GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: primaryColor,
  );

  TextStyle get itemDetailStyle => GoogleFonts.dmSans(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  );

  TextStyle get priceStyle => GoogleFonts.dmSans(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: secondaryColor,
  );

  @override
  void initState() {
    super.initState();
    _fetchMesses();
  }

  Future<void> _fetchMesses({bool forceRefresh = false}) async {
    try {
      // Only show loading indicator if we don't have cached data
      if (allMesses.isEmpty || forceRefresh) {
        setState(() {
          isLoading = true;
          errorMessage = null;
        });
      }

      final messApiResponse = await MessApiService.getAllMesses(
        forceRefresh: forceRefresh,
      );

      if (mounted) {
        setState(() {
          allMesses = messApiResponse.data;
          displayedMesses = allMesses
              .take(5)
              .toList(); // Show first 5 on dashboard
          isLoading = false;
          errorMessage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.toString();
          isLoading = false;
        });
      }
    }
  }

  List<Widget> get _screens => [
    _buildDashboardContent(),
    MessListingScreen(allMesses: allMesses),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  Widget _buildDashboardContent() {
    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.blue,
          expandedHeight: 70.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: RichText(
              text: TextSpan(
                // style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Liv',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Meal',
                    style: TextStyle(
                      color: Colors.yellow[600],
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              log("Menu Button Pressed");
            },
            icon: Icon(Icons.menu, color: Colors.white, size: 28),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(360),
              ),
              child: IconButton(
                onPressed: () {
                  log("Profile Button Pressed");
                },
                icon: Icon(Icons.person, color: Colors.white, size: 28),
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search nearby...',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.blue[700]),
                      suffixIcon: Icon(Icons.tune, color: Colors.blue[700]),
                      filled: true,
                      fillColor: Colors.blue[50], // Light blue background
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none, // No border
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.blue[100]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.blue[400]!,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    style: TextStyle(color: Colors.grey[800], fontSize: 16),
                  ),
                ),
                const SizedBox(height: 24),

                // City Selection
                SizedBox(height: 90, child: _buildCityList()),

                const SizedBox(height: 24),

                // Best-Rated Mess Services Header
                _buildSectionTitle("Best-Rated Mess Services"),

                const SizedBox(height: 16),

                _buildMessSection(),

                const SizedBox(height: 24),

                Center(child: _buildViewMoreButton()),

                const SizedBox(height: 24),

                _buildOfferCard(size),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF1E88E5),
      backgroundColor: Colors.blue,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(30),
          //   topRight: Radius.circular(30),
          // ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withOpacity(0.9),
              primaryColor.withOpacity(1.0),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10.0,
          color: Colors.transparent,
          elevation: 0,
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavBarItem(Icons.home_outlined, Icons.home, 'Home', 0),
                _buildNavBarItem(
                  Icons.restaurant_outlined,
                  Icons.restaurant,
                  'Messes',
                  1,
                ),
                // const SizedBox(width: 40), // Space for FAB
                _buildNavBarItem(
                  Icons.notifications_outlined,
                  Icons.notifications,
                  'Notifications',
                  2,
                ),
                _buildNavBarItem(
                  Icons.person_outline,
                  Icons.person,
                  'Profile',
                  3,
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Container(
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     gradient: LinearGradient(
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //       colors: [accentColor, accentColor.withAlpha(204)],
      //     ),
      //     boxShadow: [
      //       BoxShadow(
      //         color: accentColor.withAlpha(102),
      //         blurRadius: 12,
      //         offset: const Offset(0, 4),
      //       ),
      //     ],
      //   ),
      //   child: FloatingActionButton(
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //     onPressed: () {
      //       // Handle FAB press - maybe show bottom sheet with quick actions
      //     },
      //     child: const Icon(Icons.add, color: Colors.white, size: 28),
      //   ),
      // ),
    );
  }

  // Updated _buildNavBarItem method with proper spacing
  Widget _buildNavBarItem(
    IconData icon,
    IconData activeIcon,
    String text,
    int index,
  ) {
    final bool isSelected = _selectedIndex == index;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.transparent,
          onTap: () => setState(() => _selectedIndex = index),
          child: SizedBox(
            height: 72, // Match the parent height
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, // Add this to prevent overflow
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isSelected ? activeIcon : icon,
                    size: isSelected ? 24 : 22, // Slightly reduced sizes
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 3), // Reduced spacing
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 12, // Slightly smaller font
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: titleStyle);
  }

  Widget _buildMessSection() {
    final height = MediaQuery.of(context).size.height;

    if (isLoading) {
      // Show shimmer loading effect instead of circular progress indicator
      return const MessListShimmer(itemCount: 3);
    }

    if (errorMessage != null) {
      return SizedBox(
        height: height * 0.25,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
              const SizedBox(height: 16),
              Text(
                'Failed to load mess data',
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.red.shade600,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _fetchMesses,
                child: Text(
                  'Retry',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: secondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (displayedMesses.isEmpty) {
      return SizedBox(
        height: height * 0.25,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_outlined,
                size: 48,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                'No messes available',
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: displayedMesses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == displayedMesses.length - 1 ? 20 : 16,
            ),
            child: _buildMessCard(displayedMesses[index]),
          );
        },
      ),
    );
  }

  Widget _buildMessCard(MessModel mess) {
    return GestureDetector(
      onTap: () {
        // Convert MessModel to Map for DescriptionScreen
        final messData = _convertMessModelToMap(mess);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DescriptionScreen(messData: messData),
          ),
        );
      },
      child: SizedBox(
        width: 280,
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Image section (fixed height)
                Container(
                  height: 100,
                  color: Colors.grey[200],
                  child: Stack(
                    children: [
                      // Main image placeholder (since we don't have actual images)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor.withAlpha(77),
                                secondaryColor.withAlpha(77),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.restaurant,
                              size: 40,
                              color: primaryColor.withAlpha(153),
                            ),
                          ),
                        ),
                      ),
                      // Verification badge
                      if (mess.isVerified == 'verified')
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withAlpha(230),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.verified,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  'Verified',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      // Favorite button
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(26),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            size: 18,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content section (flexible height)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Title and location
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${mess.messName} (${mess.mealTypeDisplay})',
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 12,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    mess.messAddress,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: primaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              mess.dailyMealPrice > 0
                                  ? '₹${mess.dailyMealPrice.toInt()}/meal\n₹${mess.monthlyMealPrice.toInt()}/month'
                                  : 'Price on inquiry',
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: secondaryColor,
                              ),
                            ),
                            if (mess.deliveryAvailable)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'Delivery',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: secondaryColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to convert MessModel to Map for DescriptionScreen
  Map<String, dynamic> _convertMessModelToMap(MessModel mess) {
    return {
      'name': mess.messName,
      'description':
          'Quality ${mess.mealTypeDisplay.toLowerCase()} meals with home-style cooking.',
      'location': mess.messAddress,
      'rating': 4.0, // Default rating since API doesn't provide this
      'reviewCount': 0, // Default review count
      'images': [
        'assets/images/Rectangle75.png', // Default images
        'assets/images/Rectangle76.png',
        'assets/images/Rectangle77.png',
      ],
      'timings': {
        'breakfast': mess.messTimings.breakfast.displayTime,
        'lunch': mess.messTimings.lunch.displayTime,
        'dinner': mess.messTimings.dinner.displayTime,
      },
      'plans': mess.subscription
          .map(
            (sub) => {
              'name': 'Monthly Plan',
              'price': '₹${sub.monthlyMealPrice.toInt()}/month',
              'duration': 'per month',
            },
          )
          .toList(),
      'reviews': [], // Empty reviews for now
      'similarServices': [], // Empty similar services for now
    };
  }

  Widget _buildCityList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: cities.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: index < cities.length - 1 ? 16 : 0),
          child: _buildCityCard(
            cities[index]['image']!,
            cities[index]['name']!,
          ),
        );
      },
    );
  }

  Widget _buildCityCard(String imagePath, String cityName) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withAlpha(102)],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  cityName,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewMoreButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = 1; // Navigate to Messes tab
        });
      },
      child: Container(
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
            "View More",
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

  // Widget _buildNavBarItem(
  //   IconData iconOutline,
  //   IconData icon,
  //   String label,
  //   int index,
  // ) {
  //   return InkWell(
  //     onTap: () {
  //       setState(() {
  //         _selectedIndex = index;
  //       });
  //       // Handle tab change
  //     },
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Icon(
  //           _selectedIndex == index ? icon : iconOutline,
  //           color: _selectedIndex == index ? accentColor : Colors.white,
  //         ),
  //         const SizedBox(height: 4),
  //         Text(
  //           label,
  //           style: TextStyle(
  //             color: _selectedIndex == index ? accentColor : Colors.white,
  //             fontSize: 12,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildOfferCard(Size size) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: offerBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Limited Time Offer ",
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: "₹400",
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromRGBO(255, 182, 0, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "\n     Signup Bonus!",
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
              const Text(
                "Register now and claim your instant reward.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              SizedBox(height: size.height * 0.04),
              GestureDetector(
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
                      "Signup Now!",
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
