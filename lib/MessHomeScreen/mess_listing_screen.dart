import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liv_meal_app/MessHomeScreen/mess_description_screen.dart';
import 'package:liv_meal_app/constant/mess_filter_drawer.dart';
import 'package:liv_meal_app/models/mess_model.dart';

class MessListingScreen extends StatefulWidget {
  final List<MessModel>? allMesses;

  const MessListingScreen({super.key, this.allMesses});

  @override
  State<MessListingScreen> createState() => _MessListingScreenState();
}

class _MessListingScreenState extends State<MessListingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _searchController = TextEditingController();

  List<bool> isFavoriteList = [];
  String? _selectedSortOption;
  List<MessModel> displayMesses = [];

  // Dummy data for messes in JSON format
  final List<Map<String, dynamic>> messes = [
    {
      "id": 1,
      "image": "assets/images/Photos.png",
      "name": "Spice Tiffin's (Veg)",
      "rating": "4.3 (245)",
      "location": "Narhe, Pune | 10 min",
      "price": "₹100/meal \n ₹2,800/month",
      "timing": "8-10 AM | 12-3 PM | 7-9 PM",
      "description":
          "Home-style veg meals with weekly menu and doorstep delivery.",
      "isVeg": true,
      "distance": "2.4 km",
      "menu": ["Roti", "Dal", "Rice", "Sabzi", "Salad"],
      "reviews": [
        {
          "rating": 4,
          "name": "Suraj kalamkar",
          "comment":
              "Tastes just like home! I've been trying mess services for months, and Spice Tiffins is by far the best.",
          "date": "24-7-2025",
          "time": "1 DAY AGO",
        },
      ],
    },
    {
      "id": 2,
      "image": "assets/images/Photos (1).png",
      "name": "Royal Kitchen (Non-Veg)",
      "rating": "4.5 (320)",
      "location": "Kothrud, Pune | 15 min",
      "price": "₹120/meal \n ₹3,400/month",
      "timing": "8-10 AM | 1-3 PM | 8-10 PM",
      "description":
          "Delicious non-veg meals with variety of dishes and timely delivery.",
      "isVeg": false,
      "distance": "3.1 km",
      "menu": ["Chicken Curry", "Roti", "Rice", "Dal", "Salad"],
      "reviews": [
        {
          "rating": 5,
          "name": "Rahul Sharma",
          "comment":
              "Amazing food quality and taste. Highly recommended for non-veg lovers!",
          "date": "22-7-2025",
          "time": "3 DAYS AGO",
        },
      ],
    },
    {
      "id": 3,
      "image": "assets/images/Photos.png",
      "name": "Green Leaf (Pure Veg)",
      "rating": "4.1 (180)",
      "location": "Baner, Pune | 20 min",
      "price": "₹90/meal \n ₹2,500/month",
      "timing": "7:30-10 AM | 12:30-3 PM | 7:30-10 PM",
      "description": "Healthy pure vegetarian meals with organic ingredients.",
      "isVeg": true,
      "distance": "5.2 km",
      "menu": ["Jowar Roti", "Dal", "Brown Rice", "Sabzi", "Curd"],
      "reviews": [
        {
          "rating": 4,
          "name": "Priya Patel",
          "comment":
              "Healthy and tasty food. Perfect for weight watchers and health conscious people.",
          "date": "20-7-2025",
          "time": "5 DAYS AGO",
        },
      ],
    },
    {
      "id": 4,
      "image": "assets/images/Photos (1).png",
      "name": "Taste of Home (Veg/Non-Veg)",
      "rating": "4.4 (275)",
      "location": "Wakad, Pune | 25 min",
      "price": "₹110/meal \n ₹3,100/month",
      "timing": "8-10:30 AM | 12:30-3:30 PM | 7:30-10:30 PM",
      "description": "Homely food with both veg and non-veg options available.",
      "isVeg": false,
      "distance": "7.5 km",
      "menu": ["Chapati", "Dal", "Rice", "Chicken Curry", "Salad"],
      "reviews": [
        {
          "rating": 4,
          "name": "Vikram Singh",
          "comment":
              "Good quality food that reminds me of home. Delivery is always on time.",
          "date": "18-7-2025",
          "time": "1 WEEK AGO",
        },
      ],
    },
    {
      "id": 5,
      "image": "assets/images/Photos.png",
      "name": "Annapurna (Veg)",
      "rating": "4.2 (210)",
      "location": "Hinjewadi, Pune | 30 min",
      "price": "₹95/meal \n ₹2,700/month",
      "timing": "8-10 AM | 1-3 PM | 8-10 PM",
      "description": "Traditional Maharashtrian meals with authentic taste.",
      "isVeg": true,
      "distance": "10.2 km",
      "menu": ["Bhakri", "Zunka", "Rice", "Amti", "Papad"],
      "reviews": [
        {
          "rating": 5,
          "name": "Neha Deshpande",
          "comment":
              "Authentic Maharashtrian taste. Reminds me of my grandmother's cooking!",
          "date": "15-7-2025",
          "time": "2 WEEKS AGO",
        },
      ],
    },
  ];

  final List<String> _sortOptions = [
    "Popularity",
    "Price high to low",
    "Price low to high",
    "Highest Rating",
    "Lowest Price & Best Rated",
  ];

  @override
  void initState() {
    super.initState();
    log("****** ${widget.allMesses} ********");
    // Use API data if available, otherwise use dummy data
    displayMesses = widget.allMesses ?? [];
    log("!!!!!!! $displayMesses !!!!!!!!");
    // Initialize favorite list with false for each mess
    isFavoriteList = List.filled(
      displayMesses.isNotEmpty ? displayMesses.length : messes.length,
      false,
    );
  }

  // Helper method to convert MessModel to Map for DescriptionScreen
  // Map<String, dynamic> _convertMessModelToMap(MessModel mess) {
  //   return {
  //     'name': mess.messName,
  //     'description':
  //         'Quality ${mess.mealTypeDisplay.toLowerCase()} meals with home-style cooking.',
  //     'location': mess.messAddress,
  //     'rating': 4.0, // Default rating since API doesn't provide this
  //     'reviewCount': 0, // Default review count
  //     'images': [
  //       'assets/images/Photos.png', // Default images
  //       'assets/images/Photos (1).png',
  //       'assets/images/Photos.png',
  //     ],
  //     'timings': {
  //       'breakfast': mess.messTimings.breakfast.displayTime,
  //       'lunch': mess.messTimings.lunch.displayTime,
  //       'dinner': mess.messTimings.dinner.displayTime,
  //     },
  //     'plans': mess.subscription
  //         .map(
  //           (sub) => {
  //             'name': 'Monthly Plan',
  //             'price': '₹${sub.monthlyMealPrice.toInt()}/month',
  //             'duration': 'per month',
  //           },
  //         )
  //         .toList(),
  //     'reviews': [], // Empty reviews for now
  //     'similarServices': [], // Empty similar services for now
  //   };
  // }

  Map<String, dynamic> _convertMessModelToMap(MessModel mess) {
    return {
      'name': mess.messName,
      'description':
          'Quality ${mess.mealTypeDisplay.toLowerCase()} meals with home-style cooking.',
      'location': mess.messAddress,
      'rating': 4.0, // Default rating
      'reviewCount': 0, // Default review count
      'images': [
        'assets/images/Photos.png',
        'assets/images/Photos (1).png',
        'assets/images/Photos.png',
      ],
      'timings': {
        'breakfast': mess.messTimings.breakfast.displayTime,
        'lunch': mess.messTimings.lunch.displayTime,
        'dinner': mess.messTimings.dinner.displayTime,
      },
      'plans': mess.subscription.expand((sub) {
        final List<Map<String, String>> plans = [];

        if (sub.dailyMealPrice > 0) {
          plans.add({
            'name': 'Daily Plan',
            'price': '₹${sub.dailyMealPrice.toInt()}/day',
            'duration': 'per day',
          });
        }

        if (sub.weeklyMealPrice > 0) {
          plans.add({
            'name': 'Weekly Plan',
            'price': '₹${sub.weeklyMealPrice.toInt()}/week',
            'duration': 'per week',
          });
        }

        if (sub.monthlyMealPrice > 0) {
          plans.add({
            'name': 'Monthly Plan',
            'price': '₹${sub.monthlyMealPrice.toInt()}/month',
            'duration': 'per month',
          });
        }

        if (sub.trialMealPrice > 0) {
          plans.add({
            'name': 'Trial Plan',
            'price': '₹${sub.trialMealPrice.toInt()}/trial',
            'duration': 'trial offer',
          });
        }

        return plans;
      }).toList(),
      'reviews': [],
      'similarServices': [],
    };
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Sort By",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._sortOptions.map((option) {
                    return RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: _selectedSortOption,
                      onChanged: (String? value) {
                        setModalState(() {
                          _selectedSortOption = value;
                        });
                        setState(() {
                          _selectedSortOption = value;
                        });
                        Navigator.pop(context);
                      },
                      contentPadding: EdgeInsets.zero,
                      activeColor: Colors.blue,
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      drawer: MyCustomDrawer(),
      backgroundColor: Colors.blue,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 110,
            backgroundColor: Colors.blue,
            centerTitle: true,
            title: const Text(
              "All Messes",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            leading: const SizedBox(),
            // leading: IconButton(
            //   onPressed: () => Navigator.of(context).pop(),
            //   icon: Icon(Icons.arrow_back_ios),
            //   color: Colors.white,
            //   iconSize: 26,
            // ),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(right: 16),
            //     child: CircleAvatar(
            //       backgroundColor: Colors.white.withOpacity(0.2),
            //       child: Icon(Icons.person_outline, color: Colors.white),
            //     ),
            //   ),
            // ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 20),
              background: Container(
                color: Colors.blue,
                padding: EdgeInsets.only(bottom: 10, left: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: SuggestionContainer(
                          "Map",
                          imagePath: "assets/images/Group 40.png",
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          _showSortBottomSheet();
                        },
                        child: SuggestionContainer("Sort By", icon: Icons.tune),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: SuggestionContainer(
                          "Filter",
                          icon: Icons.filter_alt_outlined,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
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
                          hintText: 'Search for Mess...',
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.blue[700],
                          ),
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
                    const SizedBox(height: 14),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mess Near You in Pune",
                        style: GoogleFonts.manrope(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    // Build mess cards from API data or dummy data
                    ...displayMesses.isNotEmpty
                        ? displayMesses.asMap().entries.map((entry) {
                            final index = entry.key;
                            final mess = entry.value;
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Convert MessModel to Map for DescriptionScreen
                                    final messData = _convertMessModelToMap(
                                      mess,
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DescriptionScreen(
                                          messData: messData,
                                        ),
                                      ),
                                    );
                                  },
                                  child: _buildAPIMessCard(
                                    context,
                                    mess,
                                    index,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                              ],
                            );
                          }).toList()
                        : messes.asMap().entries.map((entry) {
                            final index = entry.key;
                            final mess = entry.value;
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to description screen with mess data
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DescriptionScreen(messData: mess),
                                      ),
                                    );
                                  },
                                  child: _buildMessCard(
                                    context,
                                    mess['image'],
                                    mess['name'],
                                    mess['rating'],
                                    mess['location'],
                                    mess['price'],
                                    index,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                              ],
                            );
                          }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAPIMessCard(BuildContext context, MessModel mess, int index) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color.fromRGBO(237, 246, 249, 1),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder image section with gradient
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  width: width,
                  height: height * 0.2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(2, 48, 71, 1).withOpacity(0.3),
                        Color.fromRGBO(0, 119, 182, 1).withOpacity(0.3),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.restaurant,
                      size: 50,
                      color: Color.fromRGBO(2, 48, 71, 1).withOpacity(0.6),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Verification status badge
                          if (mess.isVerified == 'verified')
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.green,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.verified,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Verified',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: 8),
                          Text(
                            '${mess.messName} (${mess.mealTypeDisplay})',
                            style: GoogleFonts.dmSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(2, 48, 71, 1),
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                size: 14,
                                color: Colors.black,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  mess.messAddress,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(2, 48, 71, 1),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.alarm, size: 14, color: Colors.black),
                              SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  '${mess.messTimings.breakfast.displayTime} | ${mess.messTimings.lunch.displayTime} | ${mess.messTimings.dinner.displayTime}',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(2, 48, 71, 1),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          if (mess.deliveryAvailable)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.blue[50],
                                ),
                                child: Text(
                                  'Delivery Available',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 119, 182, 1),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      height: 100,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          mess.dailyMealPrice > 0
                              ? '₹${mess.dailyMealPrice.toInt()}/meal\n₹${mess.monthlyMealPrice.toInt()}/month'
                              : 'Price on inquiry',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(0, 119, 182, 1),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: height * 0.02,
            right: width * 0.14,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromRGBO(255, 255, 255, 0.6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavoriteList[index] = !isFavoriteList[index];
                      });
                    },
                    child: Icon(
                      Icons.favorite,
                      color: isFavoriteList[index] ? Colors.red : Colors.amber,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.02,
            right: width * 0.03,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromRGBO(255, 255, 255, 0.6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Icon(
                    Icons.more_horiz,
                    color: Color.fromRGBO(255, 183, 3, 1),
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessCard(
    BuildContext context,
    String imagePath,
    String title,
    String rating,
    String location,
    String price,
    int index,
  ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color.fromRGBO(237, 246, 249, 1),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  imagePath,
                  width: width,
                  height: height * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color.fromRGBO(0, 119, 182, 1),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromRGBO(255, 183, 3, 1),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Icon(
                                    Icons.star,
                                    color: Color.fromRGBO(255, 183, 3, 1),
                                    size: 12,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  rating,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            title,
                            style: GoogleFonts.dmSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(2, 48, 71, 1),
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                size: 14,
                                color: Colors.black,
                              ),
                              SizedBox(width: 4),
                              Text(
                                location,
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(2, 48, 71, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.alarm, size: 14, color: Colors.black),
                              SizedBox(width: 4),
                              Text(
                                "8-10 AM | 12-3 PM | 7-9 PM",
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(2, 48, 71, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      height: 100,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          price,
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(0, 119, 182, 1),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: height * 0.02,
            right: width * 0.14,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromRGBO(255, 255, 255, 0.6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavoriteList[index] = !isFavoriteList[index];
                      });
                    },
                    child: Icon(
                      Icons.favorite,
                      color: isFavoriteList[index] ? Colors.red : Colors.amber,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.02,
            right: width * 0.03,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromRGBO(255, 255, 255, 0.6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Icon(
                    Icons.more_horiz,
                    color: Color.fromRGBO(255, 183, 3, 1),
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SuggestionContainer(String text, {String? imagePath, IconData? icon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        children: [
          if (imagePath != null)
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Image.asset(imagePath, width: 20, height: 20),
            ),
          if (icon != null && imagePath == null)
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(icon, size: 24),
            ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(2, 48, 71, 1),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
