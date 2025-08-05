import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liv_meal_app/MessHomeScreen/checkout_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  late AnimationController _hoverAnimationController;
  late Animation<double> _hoverAnimation;

  // JSON-like data structure for subscription plans
  final List<Map<String, dynamic>> subscriptionPlans = [
    {
      "title": "Daily Plan",
      "price": "₹100",
      "period": "/meal per day",
      "features": [
        "Perfect for: Trial or occasional users",
        "Pay per meal, no commitment",
        "Choose lunch, dinner, or both",
        "Cancel anytime before the next meal",
      ],
      "buttonText": "Subscribe Now !",
      "color": Color(0xFFE8F4FD),
      "accentColor": Color(0xFF2196F3),
      "popular": "true",
    },
    {
      "title": "Weekly Plan",
      "price": "₹650",
      "period": "/week",
      "features": [
        "Perfect for: Regular weekly users",
        "Save 7% compared to daily plan",
        "All meals included for 7 days",
        "Cancel anytime with 24hr notice",
      ],
      "buttonText": "Choose Weekly",
      "color": Color(0xFFF3E5F5),
      "accentColor": Color(0xFF9C27B0),
    },
    {
      "title": "Monthly Plan",
      "price": "₹2,400",
      "period": "/month",
      "features": [
        "Perfect for: Regular monthly users",
        "Save 20% compared to daily plan",
        "All meals included for 30 days",
        "Priority customer support",
      ],
      "buttonText": "Go Monthly",
      "color": Color(0xFFE8F5E8),
      "accentColor": Color(0xFF4CAF50),
    },
    {
      "title": "Premium Plan",
      "price": "₹6,500",
      "period": "/3 months",
      "features": [
        "Perfect for: Long-term commitment",
        "Save 35% compared to daily plan",
        "Premium meal options included",
        "Free delivery & priority support",
      ],
      "buttonText": "Get Premium",
      "color": Color(0xFFFFF3E0),
      "accentColor": Color(0xFFFF9800),
    },
  ];

  // Color theme
  final Color _lightColor = const Color(0xFFEDF6F9);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.85, // This makes parts of adjacent cards visible
      initialPage: 0,
    );
    _hoverAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _hoverAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _hoverAnimationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _hoverAnimationController.dispose();
    super.dispose();
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
        "Subscription Plans",
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
    );
  }

  SliverToBoxAdapter _buildContentSection(Size size) {
    return SliverToBoxAdapter(
      child: Container(
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          color: _lightColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            // Page Description - Removed SizedBox with Expanded
            Text(
              "Flexible meal plans tailored to your routine. \nChoose what suits your appetite & schedule!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 30),
            // Cards PageView with fixed height
            SizedBox(
              height: size.height * 0.60,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: subscriptionPlans.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: _buildSubscriptionCard(
                      subscriptionPlans[index],
                      size,
                    ),
                  );
                },
              ),
            ),

            // Page Indicators
            const SizedBox(height: 16),
            _buildPageIndicators(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(Map<String, dynamic> plan, Size size) {
    return MouseRegion(
      onEnter: (_) => _hoverAnimationController.forward(),
      onExit: (_) => _hoverAnimationController.reverse(),
      child: AnimatedBuilder(
        animation: _hoverAnimationController,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective
              ..rotateX(0.008 * _hoverAnimation.value) // 3D tilt effect
              ..rotateY(0.005 * _hoverAnimation.value),
            alignment: FractionalOffset.center,
            child: Container(
              height: size.height * 0.6,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    plan['color'],
                    Color.lerp(plan['color'], Colors.black, 0.1)!,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: plan['accentColor'].withOpacity(
                      0.2 * _hoverAnimation.value,
                    ),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: Offset(0, 10 * _hoverAnimation.value),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Decorative elements
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: plan['accentColor'].withOpacity(0.1),
                      ),
                    ),
                  ),

                  // Main content
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title with badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              plan['title'],
                              style: TextStyle(
                                fontSize: size.width * 0.065,
                                fontWeight: FontWeight.bold,
                                color: plan['accentColor'],
                                letterSpacing: 0.5,
                              ),
                            ),
                            if (plan['popular'] == true)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: plan['accentColor'],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'POPULAR',
                                  style: TextStyle(
                                    fontSize: size.width * 0.025,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 8),

                        // Price with 3D effect
                        Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0, 20 * _hoverAnimation.value),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: plan['price'],
                                  style: TextStyle(
                                    fontSize: size.width * 0.08,
                                    fontWeight: FontWeight.bold,
                                    color: plan['accentColor'],
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                TextSpan(
                                  text: plan['period'],
                                  style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24),

                        // Features list with icons
                        Expanded(
                          child: ListView(
                            children: plan['features']
                                .map<Widget>(
                                  (feature) => Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 12.0,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.check_circle_rounded,
                                          color: plan['accentColor'],
                                          size: 20,
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            feature,
                                            style: TextStyle(
                                              fontSize: size.width * 0.038,
                                              color: Colors.black.withOpacity(
                                                0.9,
                                              ),
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),

                        // Subscribe Button with gradient and hover effect
                        Transform.translate(
                          offset: Offset(0, -5 * _hoverAnimation.value),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: plan['accentColor'].withOpacity(
                                    0.4 * _hoverAnimation.value,
                                  ),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  print('Selected plan: $plan');
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CheckoutScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: plan['accentColor'],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                ),
                                child: AnimatedDefaultTextStyle(
                                  duration: Duration(milliseconds: 200),
                                  style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5 * _hoverAnimation.value,
                                  ),
                                  child: Text(plan['buttonText']),
                                ),
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
          );
        },
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        subscriptionPlans.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentIndex == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? const Color(0xFFFFA726)
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
