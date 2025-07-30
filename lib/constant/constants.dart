// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Widget GoogleMapScreen(double width) {
//   return Expanded(
//     child: Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey), // Visual boundary
//       ),
//       child: Column(
//         children: [
//           Expanded(
//             child: GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(37.427961, -122.085749),
//                 zoom: 14,
//               ),
//               // Essential parameters:
//               myLocationEnabled: true,
//               myLocationButtonEnabled: true,
//               onMapCreated: (controller) {
//                 print("Map created successfully!"); // Debug print
//               },
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Widget GoogleMapScreen(double width) {
  return Expanded(
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0), // Default center (0,0)
          zoom: 1, // Default zoom level
        ),
      ),
    ),
  );
}

Widget CustomScrollViewreturn(String title, Icon icon, context, Widget child) {
  var height = MediaQuery.of(context).size.height;
  return CustomScrollView(
    slivers: [
      SliverAppBar(
        pinned: true,
        floating: false,
        expandedHeight: 80,
        backgroundColor: Colors.blue,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: icon,
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
          child: child,
        ),
      ),
    ],
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
