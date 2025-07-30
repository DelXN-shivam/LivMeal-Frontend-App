import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var heigth = MediaQuery.of(context).size.height;
    TextEditingController searchcontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("LIVMEAL"),
        centerTitle: true,
        leading: Icon(Icons.menu),

        actions: [Icon(Icons.person_2_outlined)],
        backgroundColor: Colors.yellowAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),

        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 20),

              Column(
                children: [
                  TextField(
                    controller: searchcontroller,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                          right: 12,
                        ), // Space between icon and text
                        child: Icon(Icons.search, size: 20),
                      ),
                      hintText: "Search...",
                      labelText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: heigth * 0.02),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildContainer("assets/images/Group 7.png", "Pune"),
                        SizedBox(width: width * 0.02),
                        buildContainer(
                          "assets/images/Group 7 (2).png",
                          "Mumbai",
                        ),
                        SizedBox(width: width * 0.02),
                        buildContainer(
                          "assets/images/Group 7 (3).png",
                          "Nashik",
                        ),
                        SizedBox(width: width * 0.02),
                        buildContainer(
                          "assets/images/Group 7 (4).png",
                          "Kolhapur",
                        ),
                        SizedBox(width: width * 0.02),
                        buildContainer("assets/images/Group 7.png", "Pune"),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: heigth * 0.02),
              // Row(
              //   children: [
              //     Text(
              //       "Top PGs for you",
              //       style: GoogleFonts.manrope(
              //         fontSize: 18,
              //         fontWeight: FontWeight.w700,
              //         fontStyle: FontStyle.normal,
              //         color: Color.fromRGBO(2, 48, 71, 1),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: heigth * 0.02),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Container(
              //         decoration: BoxDecoration(
              //           color: Color.fromRGBO(237, 246, 249, 1),

              //           borderRadius: BorderRadius.circular(14),
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Row(
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.only(right: 8),
              //                 child: Image.asset(
              //                   "assets/images/Rectangle 35.png",
              //                   fit: BoxFit.cover,
              //                 ),
              //               ),
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   ConstrainedBox(
              //                     constraints: BoxConstraints(
              //                       maxWidth:
              //                           200, // Set your desired maximum width
              //                     ),

              //                     child: Text(
              //                       "Sunrise Residency PG",
              //                       style: GoogleFonts.dmSans(
              //                         fontSize: 18,
              //                         fontWeight: FontWeight.w500,
              //                         fontStyle: FontStyle.normal,
              //                         color: Color.fromRGBO(2, 48, 71, 1),
              //                       ),
              //                       softWrap: true,
              //                       maxLines: 2,
              //                       overflow: TextOverflow.ellipsis,
              //                     ),
              //                   ),

              //                   Row(
              //                     children: [
              //                       Icon(
              //                         Icons.location_pin,
              //                         color: Colors.black,
              //                       ),
              //                       SizedBox(width: 5),
              //                       Text(
              //                         "Narhe,Pune",
              //                         style: GoogleFonts.dmSans(
              //                           fontSize: 13,
              //                           fontWeight: FontWeight.w400,
              //                           fontStyle: FontStyle.normal,
              //                           color: Color.fromRGBO(2, 48, 71, 1),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   SizedBox(height: 8),
              //                   Row(
              //                     children: [
              //                       Container(
              //                         decoration: BoxDecoration(
              //                           color: Color.fromRGBO(161, 188, 255, 1),

              //                           borderRadius: BorderRadius.circular(24),
              //                         ),
              //                         child: Padding(
              //                           padding: const EdgeInsets.all(4),
              //                           child: Icon(
              //                             Icons.person_3,
              //                             color: Color.fromRGBO(2, 48, 71, 1),
              //                           ),
              //                         ),
              //                       ),
              //                       SizedBox(width: 10),
              //                       Text(
              //                         "Boys/Male PG",
              //                         style: GoogleFonts.dmSans(
              //                           fontSize: 13,
              //                           fontWeight: FontWeight.w400,
              //                           fontStyle: FontStyle.normal,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   SizedBox(height: 8),
              //                   Row(
              //                     children: [
              //                       SizedBox(width: 10),
              //                       Text(
              //                         "₹8,500/month",
              //                         style: GoogleFonts.dmSans(
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.w700,
              //                           color: Color.fromRGBO(0, 119, 182, 1),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       SizedBox(width: 10),
              //       Container(
              //         decoration: BoxDecoration(
              //           color: Color.fromRGBO(237, 246, 249, 1),

              //           borderRadius: BorderRadius.circular(14),
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Row(
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.only(right: 8),
              //                 child: Image.asset(
              //                   "assets/images/Rectangle 35.png",
              //                   fit: BoxFit.cover,
              //                 ),
              //               ),
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   ConstrainedBox(
              //                     constraints: BoxConstraints(
              //                       maxWidth:
              //                           200, // Set your desired maximum width
              //                     ),

              //                     child: Text(
              //                       "Sunrise Residency PG",
              //                       style: GoogleFonts.dmSans(
              //                         fontSize: 18,
              //                         fontWeight: FontWeight.w500,
              //                         fontStyle: FontStyle.normal,
              //                         color: Color.fromRGBO(2, 48, 71, 1),
              //                       ),
              //                       softWrap: true,
              //                       maxLines: 2,
              //                       overflow: TextOverflow.ellipsis,
              //                     ),
              //                   ),

              //                   Row(
              //                     children: [
              //                       Icon(
              //                         Icons.location_pin,
              //                         color: Colors.black,
              //                       ),
              //                       SizedBox(width: 5),
              //                       Text(
              //                         "Narhe,Pune",
              //                         style: GoogleFonts.dmSans(
              //                           fontSize: 13,
              //                           fontWeight: FontWeight.w400,
              //                           fontStyle: FontStyle.normal,
              //                           color: Color.fromRGBO(2, 48, 71, 1),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   SizedBox(height: 8),
              //                   Row(
              //                     children: [
              //                       Container(
              //                         decoration: BoxDecoration(
              //                           color: Color.fromRGBO(161, 188, 255, 1),

              //                           borderRadius: BorderRadius.circular(24),
              //                         ),
              //                         child: Padding(
              //                           padding: const EdgeInsets.all(4),
              //                           child: Icon(
              //                             Icons.person_3,
              //                             color: Color.fromRGBO(2, 48, 71, 1),
              //                           ),
              //                         ),
              //                       ),
              //                       SizedBox(width: 10),
              //                       Text(
              //                         "Boys/Male PG",
              //                         style: GoogleFonts.dmSans(
              //                           fontSize: 13,
              //                           fontWeight: FontWeight.w400,
              //                           fontStyle: FontStyle.normal,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   SizedBox(height: 8),
              //                   Row(
              //                     children: [
              //                       SizedBox(width: 10),
              //                       Text(
              //                         "₹8,500/month",
              //                         style: GoogleFonts.dmSans(
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.w700,
              //                           color: Color.fromRGBO(0, 119, 182, 1),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       SizedBox(width: 20),
              //     ],
              //   ),
              // ),

              // SizedBox(height: heigth * 0.02),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //       onTap: () {},
              //       child: gradientButton("View More"),
              //     ),
              //   ],
              // ),
              SizedBox(height: heigth * 0.02),
              Row(
                children: [
                  Text(
                    "Best-Rated Mess Services",
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: Color.fromRGBO(2, 48, 71, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: heigth * 0.02),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(237, 246, 249, 1),

                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Image.asset(
                                "assets/images/Rectangle 35 (1).png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        200, // Set your desired maximum width
                                  ),

                                  child: Text(
                                    "Spice Tiffin's  (Veg/ Non-veg)",
                                    style: GoogleFonts.dmSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: Color.fromRGBO(2, 48, 71, 1),
                                    ),
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Narhe,Pune",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        color: Color.fromRGBO(2, 48, 71, 1),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "2.4 km",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        color: Color.fromRGBO(2, 48, 71, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: Color.fromRGBO(161, 188, 255, 1),
                                        border: Border.all(
                                          color: Color.fromRGBO(255, 183, 3, 1),
                                          width: 4,
                                        ),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Icon(
                                        Icons.star,
                                        // color: Color.fromRGBO(2, 48, 71, 1),
                                        color: Color.fromRGBO(255, 183, 3, 1),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "4.3 (245)",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      "₹70 /Male",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(0, 119, 182, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(237, 246, 249, 1),

                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Image.asset(
                                "assets/images/Rectangle 35 (1).png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        200, // Set your desired maximum width
                                  ),

                                  child: Text(
                                    "Spice Tiffin's  (Veg/ Non-veg)",
                                    style: GoogleFonts.dmSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: Color.fromRGBO(2, 48, 71, 1),
                                    ),
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Narhe,Pune",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        color: Color.fromRGBO(2, 48, 71, 1),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "2.4 km",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        color: Color.fromRGBO(2, 48, 71, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: Color.fromRGBO(161, 188, 255, 1),
                                        border: Border.all(
                                          color: Color.fromRGBO(255, 183, 3, 1),
                                          width: 4,
                                        ),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Icon(
                                        Icons.star,
                                        // color: Color.fromRGBO(2, 48, 71, 1),
                                        color: Color.fromRGBO(255, 183, 3, 1),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "4.3 (245)",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      "₹70 /Male",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(0, 119, 182, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),

              SizedBox(height: heigth * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: gradientButton("View More"),
                  ),
                ],
              ),
              SizedBox(height: heigth * 0.02),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(254, 236, 191, 1),

                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Limited Time Offer ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(2, 48, 71, 1),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: "₹400",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(255, 182, 0, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "\n     Signup Bonus!", // \n creates new line
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(
                                      2,
                                      48,
                                      71,
                                      1,
                                    ), // Color for bonus text
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: heigth * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Register now and claim your instant reward.",
                            style: GoogleFonts.urbanist(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Color.fromRGBO(2, 48, 71, 1),
                            ),
                            softWrap: true,
                            maxLines: 2, // Allow up to 2 lines
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(height: heigth * 0.04),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color.fromRGBO(255, 182, 0, 1),
                          ),
                          child: Center(
                            child: Text(
                              "Signup Now!",
                              style: GoogleFonts.dmSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: heigth * 0.02),

              Row(
                children: [
                  Text(
                    "Available Rooms for Rent",
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: Color.fromRGBO(2, 48, 71, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: heigth * 0.02),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(237, 246, 249, 1),

                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Image.asset(
                                "assets/images/Rectangle 35 (2).png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        200, // Set your desired maximum width
                                  ),

                                  child: Text(
                                    "The Comfort Nest",
                                    style: GoogleFonts.dmSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: Color.fromRGBO(2, 48, 71, 1),
                                    ),
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Narhe,Pune",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        color: Color.fromRGBO(2, 48, 71, 1),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "2.4 km",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        color: Color.fromRGBO(2, 48, 71, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: Color.fromRGBO(161, 188, 255, 1),
                                        border: Border.all(
                                          color: Color.fromRGBO(255, 183, 3, 1),
                                          width: 4,
                                        ),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Icon(
                                        Icons.star,
                                        // color: Color.fromRGBO(2, 48, 71, 1),
                                        color: Color.fromRGBO(255, 183, 3, 1),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "4.3 (86)",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Single Occupancy",
                                  style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: Color.fromRGBO(2, 48, 71, 1),
                                  ),
                                ),

                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      "₹70 /Mal",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(0, 119, 182, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(237, 246, 249, 1),

                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Image.asset(
                                "assets/images/Rectangle 35 (2).png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        200, // Set your desired maximum width
                                  ),

                                  child: Text(
                                    "The Comfort Nest",
                                    style: GoogleFonts.dmSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: Color.fromRGBO(2, 48, 71, 1),
                                    ),
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Narhe,Pune",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        color: Color.fromRGBO(2, 48, 71, 1),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "2.4 km",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        color: Color.fromRGBO(2, 48, 71, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: Color.fromRGBO(161, 188, 255, 1),
                                        border: Border.all(
                                          color: Color.fromRGBO(255, 183, 3, 1),
                                          width: 4,
                                        ),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Icon(
                                        Icons.star,
                                        // color: Color.fromRGBO(2, 48, 71, 1),
                                        color: Color.fromRGBO(255, 183, 3, 1),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "4.3 (86)",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Single Occupancy",
                                  style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: Color.fromRGBO(2, 48, 71, 1),
                                  ),
                                ),

                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      "₹70 /Mal",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(0, 119, 182, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
              SizedBox(height: heigth * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: gradientButton("View More"),
                  ),
                ],
              ),
              SizedBox(height: heigth * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainer(String imagePath, String cityName) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Image with overlay
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
                    colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
                  ),
                ),
              ),
            ),

            // City name text
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

  Widget gradientButton(String text) {
    return Container(
      height: 40,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
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
            fontStyle: FontStyle.normal,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
    );
  }
}
