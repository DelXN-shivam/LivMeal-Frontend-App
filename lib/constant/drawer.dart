import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomDrawer extends StatefulWidget {
  const MyCustomDrawer({super.key});

  @override
  State<MyCustomDrawer> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<MyCustomDrawer> {
  final List<String> drawerList = [
    "Rating",
    "Meal Type",
    "Mess Timing",
    "Location",
    "Verified Listing",
  ];
  int selectedIndex = 0;
  Widget _buildRightContent(int index) {
    switch (index) {
      case 0: // Menu
        return MenuContent();
      case 1: // Orders
        return OrdersContent();
      case 2: // Profile
        return ProfileContent();
      case 3: // Settings
        return SettingsContent();
      default:
        return MenuContent();
    }
  }

  Widget MenuContent() {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 15),
            SizedBox(width: 20),
            Container(
              height: 10,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.amber,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 15),
            SizedBox(width: 5),
            Icon(Icons.star, color: Colors.amber, size: 15),
            Container(
              height: 10,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.amber,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 15),
            SizedBox(width: 5),
            Icon(Icons.star, color: Colors.amber, size: 15),
            SizedBox(width: 5),
            Icon(Icons.star, color: Colors.amber, size: 15),
            SizedBox(width: 20),
            Container(
              height: 10,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.amber,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 15),
            SizedBox(width: 5),
            Icon(Icons.star, color: Colors.amber, size: 15),
            SizedBox(width: 5),
            Icon(Icons.star, color: Colors.amber, size: 15),
            SizedBox(width: 20),
            Container(
              height: 10,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.amber,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 15),
            SizedBox(width: 5),
            Icon(Icons.star, color: Colors.amber, size: 15),
            SizedBox(width: 5),
            Icon(Icons.star, color: Colors.amber, size: 15),
            SizedBox(width: 5),
            Icon(Icons.star, color: Colors.amber, size: 15),
            SizedBox(width: 5),
            Icon(Icons.star, color: Colors.amber, size: 15),

            Container(
              height: 10,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget OrdersContent() {
    return Container();
  }

  Widget ProfileContent() {
    return Container();
  }

  Widget SettingsContent() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 80,
            backgroundColor: Colors.blue,
            title: Text(
              "Filter",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 20),
              background: Container(
                color: Colors.blue,
                padding: EdgeInsets.only(bottom: 10, left: 20),
                child: SingleChildScrollView(scrollDirection: Axis.horizontal),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                color: Colors.white,
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    // Left side navigation
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: drawerList.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              color: selectedIndex == index
                                  ? Colors.blue[100]
                                  : Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 20,
                              ),
                              child: Text(
                                drawerList[index],
                                style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  fontWeight: selectedIndex == index
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: const Color.fromRGBO(2, 48, 71, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Right side content
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: _buildRightContent(selectedIndex),
                      ),
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
}
