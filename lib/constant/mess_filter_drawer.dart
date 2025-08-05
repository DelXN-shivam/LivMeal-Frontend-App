import 'package:flutter/material.dart';

class MyCustomDrawer extends StatefulWidget {
  const MyCustomDrawer({super.key});

  @override
  _MyCustomDrawerState createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<MyCustomDrawer> {
  // Filter types
  String selectedFilterType = 'Price';

  // Price filter state
  double minPrice = 0;
  double maxPrice = 30000;
  List<Map<String, dynamic>> priceRanges = [
    {'range': '₹0 - ₹2000', 'count': 367, 'selected': true},
    {'range': '₹2000 - ₹5000', 'count': 300, 'selected': false},
    {'range': '₹5000 - ₹9000', 'count': 29, 'selected': false},
    {'range': '₹9000 - ₹15000', 'count': 15, 'selected': false},
    {'range': '₹15000 - ₹30000', 'count': 15, 'selected': false},
    {'range': '₹30000+', 'count': 4, 'selected': false},
  ];

  // Ratings filter state
  List<Map<String, dynamic>> ratings = [
    {'rating': '4.5+ Stars', 'count': 245, 'selected': false},
    {'rating': '4.0+ Stars', 'count': 156, 'selected': true},
    {'rating': '3.5+ Stars', 'count': 89, 'selected': false},
    {'rating': '3.0+ Stars', 'count': 67, 'selected': false},
    {'rating': 'Any Rating', 'count': 422, 'selected': false},
  ];

  // Meal Type filter state
  List<Map<String, dynamic>> mealTypes = [
    {'type': 'Vegetarian', 'count': 189, 'selected': false},
    {'type': 'Non-Vegetarian', 'count': 233, 'selected': true},
    {'type': 'Vegan', 'count': 45, 'selected': false},
    {'type': 'Jain', 'count': 23, 'selected': false},
    {'type': 'Swaminarayan', 'count': 12, 'selected': false},
  ];

  // Mess Timings filter state
  List<Map<String, dynamic>> messTimings = [
    {'timing': 'Breakfast (7-10 AM)', 'count': 156, 'selected': true},
    {'timing': 'Lunch (12-3 PM)', 'count': 234, 'selected': false},
    {'timing': 'Dinner (7-10 PM)', 'count': 198, 'selected': false},
    {'timing': 'All Day', 'count': 89, 'selected': false},
  ];

  // Location filter state
  List<Map<String, dynamic>> locations = [
    {'location': 'Kothrud', 'count': 89, 'selected': false},
    {'location': 'Karve Nagar', 'count': 67, 'selected': true},
    {'location': 'Warje', 'count': 45, 'selected': false},
    {'location': 'Baner', 'count': 78, 'selected': false},
    {'location': 'Aundh', 'count': 56, 'selected': false},
    {'location': 'Pimpri', 'count': 34, 'selected': false},
  ];

  // Verified Listings filter state
  bool verifiedOnly = true;
  bool premiumListings = false;
  bool newListings = true;

  void _applyFilters() {
    print('=== APPLIED FILTERS ===');

    // Price filters
    List<String> selectedPriceRanges = priceRanges
        .where((range) => range['selected'])
        .map((range) => range['range'].toString())
        .toList();
    print('Selected Price Ranges: $selectedPriceRanges');

    // Ratings filters
    List<String> selectedRatings = ratings
        .where((rating) => rating['selected'])
        .map((rating) => rating['rating'].toString())
        .toList();
    print('Selected Ratings: $selectedRatings');

    // Meal Type filters
    List<String> selectedMealTypes = mealTypes
        .where((meal) => meal['selected'])
        .map((meal) => meal['type'].toString())
        .toList();
    print('Selected Meal Types: $selectedMealTypes');

    // Mess Timings filters
    List<String> selectedTimings = messTimings
        .where((timing) => timing['selected'])
        .map((timing) => timing['timing'].toString())
        .toList();
    print('Selected Mess Timings: $selectedTimings');

    // Location filters
    List<String> selectedLocations = locations
        .where((location) => location['selected'])
        .map((location) => location['location'].toString())
        .toList();
    print('Selected Locations: $selectedLocations');

    // Verified Listings filters
    print('Verified Only: $verifiedOnly');
    print('Premium Listings: $premiumListings');
    print('New Listings: $newListings');

    print('=== END FILTERS ===');

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filters Applied'),
          content: Text('Check console for detailed filter selection log.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E88E5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: Colors.white, size: 24),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Filters',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Main content
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    // Left sidebar - Filter types
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildFilterTypeItem(
                            'Price',
                            Icons.attach_money,
                            Radius.circular(20),
                          ),
                          _buildFilterTypeItem(
                            'Ratings',
                            Icons.star_outline,
                            Radius.circular(0),
                          ),
                          _buildFilterTypeItem(
                            'Meal Type',
                            Icons.restaurant_menu,
                            Radius.circular(0),
                          ),
                          _buildFilterTypeItem(
                            'Mess Timings',
                            Icons.access_time,
                            Radius.circular(0),
                          ),
                          _buildFilterTypeItem(
                            'Location',
                            Icons.location_on_outlined,
                            Radius.circular(0),
                          ),
                          _buildFilterTypeItem(
                            'Verified Listings',
                            Icons.verified_outlined,
                            Radius.circular(0),
                          ),
                        ],
                      ),
                    ),

                    // Right content area
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: _buildFilterContent(),
                            ),
                          ),
                          // Apply Button
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: Offset(0, -2),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _applyFilters,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1E88E5),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTypeItem(String title, IconData icon, Radius radius) {
    bool isSelected = selectedFilterType == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilterType = title;
        });
      },
      child: Container(
        width: 120,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isSelected ? Color(0xFFFF9800) : Colors.transparent,
              width: 4,
            ),
          ),
          borderRadius: BorderRadius.only(topLeft: radius),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Color(0xFF333333) : Color(0xFF999999),
              size: 24,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Color(0xFF333333) : Color(0xFF999999),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterContent() {
    switch (selectedFilterType) {
      case 'Price':
        return _buildPriceFilter();
      case 'Ratings':
        return _buildRatingsFilter();
      case 'Meal Type':
        return _buildMealTypeFilter();
      case 'Mess Timings':
        return _buildMessTimingsFilter();
      case 'Location':
        return _buildLocationFilter();
      case 'Verified Listings':
        return _buildVerifiedListingsFilter();
      default:
        return Container();
    }
  }

  Widget _buildPriceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price range inputs
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Minimum',
                      style: TextStyle(
                        color: Color(0xFFFF9800),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '₹${minPrice.toInt()}',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Maximum',
                      style: TextStyle(
                        color: Color(0xFFFF9800),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '₹${maxPrice.toInt()}+',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 24),

        // Price range checkboxes
        Expanded(
          child: ListView.builder(
            itemCount: priceRanges.length,
            itemBuilder: (context, index) {
              return _buildCheckboxItem(
                priceRanges[index]['range'],
                priceRanges[index]['count'],
                priceRanges[index]['selected'],
                (value) {
                  setState(() {
                    priceRanges[index]['selected'] = value;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRatingsFilter() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: ratings.length,
            itemBuilder: (context, index) {
              return _buildCheckboxItem(
                ratings[index]['rating'],
                ratings[index]['count'],
                ratings[index]['selected'],
                (value) {
                  setState(() {
                    ratings[index]['selected'] = value;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMealTypeFilter() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: mealTypes.length,
            itemBuilder: (context, index) {
              return _buildCheckboxItem(
                mealTypes[index]['type'],
                mealTypes[index]['count'],
                mealTypes[index]['selected'],
                (value) {
                  setState(() {
                    mealTypes[index]['selected'] = value;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMessTimingsFilter() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messTimings.length,
            itemBuilder: (context, index) {
              return _buildCheckboxItem(
                messTimings[index]['timing'],
                messTimings[index]['count'],
                messTimings[index]['selected'],
                (value) {
                  setState(() {
                    messTimings[index]['selected'] = value;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLocationFilter() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return _buildCheckboxItem(
                locations[index]['location'],
                locations[index]['count'],
                locations[index]['selected'],
                (value) {
                  setState(() {
                    locations[index]['selected'] = value;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVerifiedListingsFilter() {
    return Column(
      children: [
        _buildSwitchItem(
          'Verified Only',
          'Show only verified mess listings',
          verifiedOnly,
          (value) {
            setState(() {
              verifiedOnly = value;
            });
          },
        ),
        SizedBox(height: 20),
        _buildSwitchItem(
          'Premium Listings',
          'Show premium featured listings first',
          premiumListings,
          (value) {
            setState(() {
              premiumListings = value;
            });
          },
        ),
        SizedBox(height: 20),
        _buildSwitchItem(
          'New Listings',
          'Show newly added listings',
          newListings,
          (value) {
            setState(() {
              newListings = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCheckboxItem(
    String title,
    int count,
    bool isSelected,
    Function(bool) onChanged,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF1E88E5) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Color(0xFF1E88E5) : Color(0xFFCCCCCC),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              '($count)',
              style: TextStyle(
                color: Color(0xFF1E88E5),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(color: Color(0xFF666666), fontSize: 14),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Color(0xFF1E88E5),
          activeTrackColor: Color(0xFF1E88E5).withOpacity(0.3),
        ),
      ],
    );
  }
}
