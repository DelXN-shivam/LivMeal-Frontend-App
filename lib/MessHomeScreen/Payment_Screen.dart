import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liv_meal_app/MessHomeScreen/payment_successfull_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with TickerProviderStateMixin {
  String? selectedPaymentMethod;
  String? selectedSubOption;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final Map<String, Map<String, dynamic>> paymentOptions = {
    'Debit Card': {
      'icon': Icons.credit_card,
      'color': const Color(0xFF4CAF50),
      'options': [
        {'name': 'Mastercard', 'icon': Icons.credit_card_outlined},
        {'name': 'VISA', 'icon': Icons.credit_card_outlined},
      ],
    },
    'UPI Payment': {
      'icon': Icons.account_balance_wallet,
      'color': const Color(0xFFFF9800),
      'options': [
        {'name': 'Google Pay', 'icon': Icons.payment},
        {'name': 'PhonePe', 'icon': Icons.smartphone},
      ],
    },
    'Bank Account': {
      'icon': Icons.account_balance,
      'color': const Color(0xFF9C27B0),
      'options': [
        {'name': 'Add bank account', 'icon': Icons.add_card},
        {'name': 'Saved Account', 'icon': Icons.account_balance},
      ],
    },
  };

  final Color _lightColor = const Color(0xFFEDF6F9);
  final Color _primaryColor = const Color(0xFF0077B6);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _primaryColor,
      body: CustomScrollView(
        slivers: [_buildAppBar(), _buildContentSection(size)],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 60,
      backgroundColor: _primaryColor,
      elevation: 0,
      title: Text(
        "Payment",
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
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          // Remove the fixed height constraint
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            color: _lightColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Payment Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // Payment method sections
              ...paymentOptions.entries.map((entry) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: PaymentMethodSection(
                    title: entry.key,
                    icon: entry.value['icon'],
                    color: entry.value['color'],
                    options: entry.value['options'],
                    isSelected: selectedPaymentMethod == entry.key,
                    onSelect: (method) {
                      setState(() {
                        selectedPaymentMethod = entry.key;
                        selectedSubOption = method;
                      });
                    },
                    selectedSubOption: selectedPaymentMethod == entry.key
                        ? selectedSubOption
                        : null,
                  ),
                );
              }),

              const SizedBox(height: 24),

              // Total payment amount
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.receipt_long, color: Colors.grey, size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Total Payment',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '₹ 2,400',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Pay Now button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: _primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedPaymentMethod == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Row(
                            children: [
                              Icon(Icons.warning, color: Colors.white),
                              SizedBox(width: 8),
                              Text('Please select a payment method'),
                            ],
                          ),
                          backgroundColor: Colors.orange,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                      return;
                    }

                    // Handle payment logic here
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: const Row(
                          children: [
                            Icon(Icons.payment, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('Payment Confirmation'),
                          ],
                        ),
                        content: Text(
                          'You are paying \$2,400 via $selectedPaymentMethod using $selectedSubOption',
                          style: const TextStyle(fontSize: 16),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Navigator.pop(context);
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PaymentSuccessfullScreen(),
                                ),
                                (route) => true,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Pay Now',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<Map<String, dynamic>> options;
  final bool isSelected;
  final Function(String) onSelect;
  final String? selectedSubOption;

  const PaymentMethodSection({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.options,
    required this.isSelected,
    required this.onSelect,
    this.selectedSubOption,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? color : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? color.withOpacity(0.1)
                : Colors.black.withOpacity(0.05),
            blurRadius: isSelected ? 8 : 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? color : Colors.black87,
                    ),
                  ),
                ),
                if (isSelected)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            ...options.map((option) {
              final optionName = option['name'] as String;
              final optionIcon = option['icon'] as IconData;

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: selectedSubOption == optionName
                      ? color.withOpacity(0.05)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: RadioListTile<String>(
                  title: Row(
                    children: [
                      Icon(
                        optionIcon,
                        size: 20,
                        color: selectedSubOption == optionName
                            ? color
                            : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        optionName,
                        style: TextStyle(
                          fontWeight: selectedSubOption == optionName
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: selectedSubOption == optionName
                              ? color
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  value: optionName,
                  groupValue: selectedSubOption,
                  onChanged: (value) {
                    if (value != null) {
                      onSelect(value);
                    }
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  dense: true,
                  activeColor: color,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen>
//     with TickerProviderStateMixin {
  // String? selectedPaymentMethod;
  // String? selectedSubOption;
  // late AnimationController _animationController;
  // late Animation<double> _fadeAnimation;

  // final Map<String, Map<String, dynamic>> paymentOptions = {
  //   'Debit Card': {
  //     'icon': Icons.credit_card,
  //     'color': const Color(0xFF4CAF50),
  //     'options': [
  //       {'name': 'Mastercard', 'icon': Icons.credit_card_outlined},
  //       {'name': 'VISA', 'icon': Icons.credit_card_outlined},
  //     ],
  //   },
  //   'UPI Payment': {
  //     'icon': Icons.account_balance_wallet,
  //     'color': const Color(0xFFFF9800),
  //     'options': [
  //       {'name': 'Google Pay', 'icon': Icons.payment},
  //       {'name': 'PhonePe', 'icon': Icons.smartphone},
  //     ],
  //   },
  //   'Bank Account': {
  //     'icon': Icons.account_balance,
  //     'color': const Color(0xFF9C27B0),
  //     'options': [
  //       {'name': 'Add bank account', 'icon': Icons.add_card},
  //       {'name': 'Saved Account', 'icon': Icons.account_balance},
  //     ],
  //   },
  // };

  // @override
  // void initState() {
  //   super.initState();
  //   _animationController = AnimationController(
  //     duration: const Duration(milliseconds: 300),
  //     vsync: this,
  //   );
  //   _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
  //     CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
  //   );
  //   _animationController.forward();
  // }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: const Text(
//           'Payment',
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
                // const Text(
                //   'Choose Payment Method',
                //   style: TextStyle(
                //     fontSize: 22,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black87,
                //   ),
                // ),
                // const SizedBox(height: 16),

                // // Payment method sections
                // ...paymentOptions.entries.map((entry) {
                //   return AnimatedContainer(
                //     duration: const Duration(milliseconds: 200),
                //     margin: const EdgeInsets.only(bottom: 16),
                //     child: PaymentMethodSection(
                //       title: entry.key,
                //       icon: entry.value['icon'],
                //       color: entry.value['color'],
                //       options: entry.value['options'],
                //       isSelected: selectedPaymentMethod == entry.key,
                //       onSelect: (method) {
                //         setState(() {
                //           selectedPaymentMethod = entry.key;
                //           selectedSubOption = method;
                //         });
                //       },
                //       selectedSubOption: selectedPaymentMethod == entry.key
                //           ? selectedSubOption
                //           : null,
                //     ),
                //   );
                // }).toList(),

                // const SizedBox(height: 24),

                // // Total payment amount
                // Container(
                //   padding: const EdgeInsets.all(20),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(16),
                //     border: Border.all(color: Colors.grey.shade200),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.05),
                //         blurRadius: 10,
                //         offset: const Offset(0, 2),
                //       ),
                //     ],
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const Row(
                //         children: [
                //           Icon(
                //             Icons.receipt_long,
                //             color: Colors.grey,
                //             size: 24,
                //           ),
                //           SizedBox(width: 12),
                //           Text(
                //             'Total Payment',
                //             style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.w600,
                //               color: Colors.black87,
                //             ),
                //           ),
                //         ],
                //       ),
                //       Container(
                //         padding: const EdgeInsets.symmetric(
                //           horizontal: 12,
                //           vertical: 6,
                //         ),
                //         decoration: BoxDecoration(
                //           color: Theme.of(
                //             context,
                //           ).primaryColor.withOpacity(0.1),
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //         child: Text(
                //           '\$2,400',
                //           style: TextStyle(
                //             fontSize: 20,
                //             fontWeight: FontWeight.bold,
                //             color: Theme.of(context).primaryColor,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // const SizedBox(height: 32),

                // // Pay Now button
                // Container(
                //   width: double.infinity,
                //   height: 56,
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [
                //         Theme.of(context).primaryColor,
                //         Theme.of(context).primaryColor.withOpacity(0.8),
                //       ],
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomRight,
                //     ),
                //     borderRadius: BorderRadius.circular(16),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Theme.of(context).primaryColor.withOpacity(0.4),
                //         blurRadius: 12,
                //         offset: const Offset(0, 6),
                //       ),
                //     ],
                //   ),
                //   child: ElevatedButton(
                //     onPressed: () {
                //       if (selectedPaymentMethod == null) {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(
                //             content: const Row(
                //               children: [
                //                 Icon(Icons.warning, color: Colors.white),
                //                 SizedBox(width: 8),
                //                 Text('Please select a payment method'),
                //               ],
                //             ),
                //             backgroundColor: Colors.orange,
                //             behavior: SnackBarBehavior.floating,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //           ),
                //         );
                //         return;
                //       }

                //       // Handle payment logic here
                //       showDialog(
                //         context: context,
                //         builder: (context) => AlertDialog(
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(16),
                //           ),
                //           title: const Row(
                //             children: [
                //               Icon(Icons.payment, color: Colors.blue),
                //               SizedBox(width: 8),
                //               Text('Payment Confirmation'),
                //             ],
                //           ),
                //           content: Text(
                //             'You are paying \$2,400 via $selectedPaymentMethod using $selectedSubOption',
                //             style: const TextStyle(fontSize: 16),
                //           ),
                //           actions: [
                //             TextButton(
                //               onPressed: () => Navigator.pop(context),
                //               child: const Text(
                //                 'Cancel',
                //                 style: TextStyle(color: Colors.grey),
                //               ),
                //             ),
                //             ElevatedButton(
                //               onPressed: () {
                //                 Navigator.pop(context);
                //                 ScaffoldMessenger.of(context).showSnackBar(
                //                   SnackBar(
                //                     content: const Row(
                //                       children: [
                //                         Icon(
                //                           Icons.check_circle,
                //                           color: Colors.white,
                //                         ),
                //                         SizedBox(width: 8),
                //                         Text('Payment successful!'),
                //                       ],
                //                     ),
                //                     backgroundColor: Colors.green,
                //                     behavior: SnackBarBehavior.floating,
                //                     shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(8),
                //                     ),
                //                   ),
                //                 );
                //               },
                //               style: ElevatedButton.styleFrom(
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(8),
                //                 ),
                //               ),
                //               child: const Text('Confirm'),
                //             ),
                //           ],
                //         ),
                //       );
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.transparent,
                //       shadowColor: Colors.transparent,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(16),
                //       ),
                //     ),
                //     child: const Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(Icons.lock, color: Colors.white, size: 20),
                //         SizedBox(width: 8),
                //         Text(
                //           'Pay Now',
                //           style: TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.w600,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // const SizedBox(height: 16),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PaymentMethodSection extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Color color;
//   final List<Map<String, dynamic>> options;
//   final bool isSelected;
//   final Function(String) onSelect;
//   final String? selectedSubOption;

//   const PaymentMethodSection({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.color,
//     required this.options,
//     required this.isSelected,
//     required this.onSelect,
//     this.selectedSubOption,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: isSelected ? color : Colors.grey.shade200,
//           width: isSelected ? 2 : 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: isSelected
//                 ? color.withOpacity(0.1)
//                 : Colors.black.withOpacity(0.05),
//             blurRadius: isSelected ? 8 : 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(icon, color: color, size: 24),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: isSelected ? color : Colors.black87,
//                     ),
//                   ),
//                 ),
//                 if (isSelected)
//                   Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: color,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.check,
//                       color: Colors.white,
//                       size: 16,
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ...options.map((option) {
//               final optionName = option['name'] as String;
//               final optionIcon = option['icon'] as IconData;

//               return Container(
//                 margin: const EdgeInsets.only(bottom: 8),
//                 decoration: BoxDecoration(
//                   color: selectedSubOption == optionName
//                       ? color.withOpacity(0.05)
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: RadioListTile<String>(
//                   title: Row(
//                     children: [
//                       Icon(
//                         optionIcon,
//                         size: 20,
//                         color: selectedSubOption == optionName
//                             ? color
//                             : Colors.grey,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         optionName,
//                         style: TextStyle(
//                           fontWeight: selectedSubOption == optionName
//                               ? FontWeight.w600
//                               : FontWeight.normal,
//                           color: selectedSubOption == optionName
//                               ? color
//                               : Colors.black87,
//                         ),
//                       ),
//                     ],
//                   ),
//                   value: optionName,
//                   groupValue: selectedSubOption,
//                   onChanged: (value) {
//                     if (value != null) {
//                       onSelect(value);
//                     }
//                   },
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 8),
//                   dense: true,
//                   activeColor: color,
//                 ),
//               );
//             }).toList(),
//           ],
//         ),
//       ),
//     );
//   }
// }
