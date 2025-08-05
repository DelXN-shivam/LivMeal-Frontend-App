import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Colors
  static const Color primaryColor = Color.fromRGBO(2, 48, 71, 1);
  static const Color secondaryColor = Color.fromRGBO(0, 119, 182, 1);
  static const Color accentColor = Color.fromRGBO(255, 183, 3, 1);

  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Order Delivered',
      'message': 'Your lunch order from Spice Tiffin\'s has been delivered.',
      'time': '2 min ago',
      'type': 'delivery',
      'isRead': false,
    },
    {
      'title': 'New Mess Available',
      'message': 'Royal Kitchen is now available in your area.',
      'time': '1 hour ago',
      'type': 'info',
      'isRead': true,
    },
    {
      'title': 'Payment Successful',
      'message': 'Your monthly subscription payment of ₹2,800 was successful.',
      'time': '2 hours ago',
      'type': 'payment',
      'isRead': false,
    },
    {
      'title': 'Menu Update',
      'message': 'Check out the new items added to Green Leaf menu.',
      'time': '1 day ago',
      'type': 'menu',
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var notification in notifications) {
                  notification['isRead'] = true;
                }
              });
            },
            child: Text(
              'Mark all read',
              style: GoogleFonts.dmSans(
                color: secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications yet',
                    style: GoogleFonts.dmSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationCard(notification, index);
              },
            ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: notification['isRead'] ? Colors.white : accentColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: notification['isRead'] ? Colors.grey[200]! : accentColor.withOpacity(0.2),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: _getNotificationIcon(notification['type']),
        title: Text(
          notification['title'],
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification['message'],
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              notification['time'],
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        trailing: notification['isRead']
            ? null
            : Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
              ),
        onTap: () {
          setState(() {
            notifications[index]['isRead'] = true;
          });
        },
      ),
    );
  }

  Widget _getNotificationIcon(String type) {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case 'delivery':
        iconData = Icons.delivery_dining;
        iconColor = Colors.green;
        break;
      case 'payment':
        iconData = Icons.payment;
        iconColor = secondaryColor;
        break;
      case 'menu':
        iconData = Icons.restaurant_menu;
        iconColor = accentColor;
        break;
      default:
        iconData = Icons.info;
        iconColor = primaryColor;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 24,
      ),
    );
  }
}
