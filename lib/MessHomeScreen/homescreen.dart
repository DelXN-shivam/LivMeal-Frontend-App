import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liv_meal_app/constant/constants.dart';
import 'package:liv_meal_app/constant/drawer.dart';

class MesshomeScreen extends StatefulWidget {
  const MesshomeScreen({super.key});

  @override
  State<MesshomeScreen> createState() => _MesshomeScreenState();
}

class _MesshomeScreenState extends State<MesshomeScreen> {
  // bool iscolor = false;
  // Color getFavoriteColor(int index) {
  //   return isFavoriteList[index] ? Colors.red : Colors.amber;
  // }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> drawerList = [
    "Popularity",
    "Price hight to low",
    "Price low to high",
    "Highest Rating",
    "Lowest Price & Best Rated ",
  ];

  List<bool> isFavoriteList = [false, false, false];
  // List <Integer>sorte
  void _showSortBottomSheet(BuildContext context, double width, Widget method) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => method,
    );
  }

  // ignore: non_constant_identifier_names
  Widget SortedFieldConatainer(double width) {
    return Container(
      padding: EdgeInsets.all(20),
      // height: 300,
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.of(context).size.height * 0.8, // 80% of screen height
      ),

      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sort By',
            style: GoogleFonts.dmSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(2, 48, 71, 1),
            ),
          ),
          SizedBox(height: 20),
          Divider(color: Colors.black, thickness: 1),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Popularity",
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Price hight to low",
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Price low to high",
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Highest Rating",
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Lowest Price & Best Rated",
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
            floating: false,
            expandedHeight: 120,
            backgroundColor: Colors.blue,
            title: Text(
              "LivMeal",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {},
            ),
            actions: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: Icon(Icons.person, color: Colors.black),
                  onPressed: () {},
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 20),
              background: Container(
                color: Colors.blue,
                padding: EdgeInsets.only(bottom: 10, left: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => Scaffold(
                            //       appBar: AppBar(title: Text("Map View")),
                            //       body: GoogleMapScreen(width),
                            //     ),
                            //   ),
                            // );
                            // GoogleMapScreen(width);
                            _showSortBottomSheet(
                              context,
                              width,
                              GoogleMapScreen(width),
                            );
                          },
                          child: SuggestionContainer(
                            "Map",
                            imagePath: "assets/images/Group 40.png",
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _showSortBottomSheet(
                              context,
                              width,
                              SortedFieldConatainer(width),
                            );
                          },
                          child: SuggestionContainer(
                            "Sort By",
                            icon: Icons.tune,
                          ),
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
                    _buildMessCard(
                      context,
                      "assets/images/Photos.png",
                      "Spice Tiffin's (Veg)",
                      "4.3 (245)",
                      "Narhe,Pune | 10 min",
                      "₹100/meal \n ₹2,800/month",
                      0,
                    ),
                    SizedBox(height: height * 0.02),
                    _buildMessCard(
                      context,
                      "assets/images/Photos (1).png",
                      "Spice Tiffin's (Veg)",
                      "4.3 (245)",
                      "Narhe,Pune | 10 min",
                      "₹100/meal \n ₹2,800/month",
                      1,
                    ),
                    SizedBox(height: height * 0.02),
                    _buildMessCard(
                      context,
                      "assets/images/Photos.png",
                      "Spice Tiffin's (Veg)",
                      "4.3 (245)",
                      "Narhe,Pune | 10 min",
                      "₹100/meal \n ₹2,800/month",
                      2,
                    ),
                  ],
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
                        if (index >= isFavoriteList.length) {
                          isFavoriteList.addAll(
                            List.filled(
                              index - isFavoriteList.length + 1,
                              false,
                            ),
                          );
                        }
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

  // ignore: non_constant_identifier_names
  Widget SuggestionContainer(String text, {String? imagePath, IconData? icon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
          // OR display icon if provided
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

  // Widget DrawerOpen() {
  //   return Column();
  // }
}
