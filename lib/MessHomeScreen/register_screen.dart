import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class MessRegistrationScreen extends StatefulWidget {
  @override
  _MessRegistrationScreenState createState() => _MessRegistrationScreenState();
}

class _MessRegistrationScreenState extends State<MessRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final _serviceRadiusController = TextEditingController();
  final _dailyPriceController = TextEditingController();
  final _weeklyPriceController = TextEditingController();
  final _monthlyPriceController = TextEditingController();
  final _trialPriceController = TextEditingController();
  final _offerController = TextEditingController();

  bool _isLoading = false;
  int _currentStep = 0;
  late PageController _pageController;

  String? _selectedMessType;
  String? _selectedDeliveryAvailable;
  String? _selectedHasOffers;
  TimeOfDay? _breakfastStartTime;
  TimeOfDay? _breakfastEndTime;
  TimeOfDay? _lunchStartTime;
  TimeOfDay? _lunchEndTime;
  TimeOfDay? _dinnerStartTime;
  TimeOfDay? _dinnerEndTime;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentStep) {
        setState(() => _currentStep = page);
      }
    });
  }

  @override
  void dispose() {
    _messNameController.dispose();
    _ownerNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    _serviceRadiusController.dispose();
    _dailyPriceController.dispose();
    _weeklyPriceController.dispose();
    _monthlyPriceController.dispose();
    _trialPriceController.dispose();
    _offerController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // List to store selected images
  List<File> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Image.asset("assets/LogoWithSlogan.png", width: 200),
            const SizedBox(height: 30),
            // Progress Indicator
            Row(
              children: [
                _buildProgressStep(
                  0,
                  'Basic',
                  Icons.info_outline,
                  isSmallScreen,
                ),
                _buildProgressLine(),
                _buildProgressStep(
                  1,
                  'Service',
                  Icons.restaurant_menu,
                  isSmallScreen,
                ),
                _buildProgressLine(),
                _buildProgressStep(
                  2,
                  'Pricing',
                  Icons.attach_money,
                  isSmallScreen,
                ),
                _buildProgressLine(),
                _buildProgressStep(
                  3,
                  'Photos',
                  Icons.photo_camera,
                  isSmallScreen,
                ),
              ],
            ),

            // Form Content
            Expanded(
              child: Form(
                key: _formKey,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    _buildBasicInfoStep(isSmallScreen),
                    _buildServiceDetailsStep(isSmallScreen),
                    _buildPricingStep(isSmallScreen),
                    _buildPhotosStep(isSmallScreen),
                  ],
                ),
              ),
            ),

            // Navigation Buttons
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (_currentStep > 0)
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.grey.shade400,
                                  Colors.grey.shade600,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _previousStep,
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
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Previous',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (_currentStep > 0) const SizedBox(width: 16),
                      if (_currentStep < 3)
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.blue.shade700,
                                  Colors.lightBlue.shade400,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleStepAction,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    )
                                  : const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          'Next',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      if (_currentStep == 3)
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.blue.shade700,
                                  Colors.lightBlue.shade400,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : _handleRegistration,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    )
                                  : const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.how_to_reg,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          'Register',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStep(
    int step,
    String title,
    IconData icon,
    bool isSmallScreen,
  ) {
    final isActive = _currentStep >= step;
    final isCompleted = _currentStep > step;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: isSmallScreen ? 36 : 44,
            height: isSmallScreen ? 36 : 44,
            decoration: BoxDecoration(
              gradient: isCompleted
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.green.shade600, Colors.green.shade400],
                    )
                  : isActive
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue.shade700, Colors.lightBlue.shade400],
                    )
                  : null,
              color: (!isCompleted && !isActive) ? Colors.grey[300] : null,
              shape: BoxShape.circle,
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: (isCompleted ? Colors.green : Colors.blue)
                            .withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              isCompleted ? Icons.check : icon,
              color: Colors.white,
              size: isSmallScreen ? 18 : 22,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.blue[800] : Colors.grey[600],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              fontSize: isSmallScreen ? 11 : 13,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressLine() {
    final isCompleted = _currentStep > 0;
    return Container(
      height: 3,
      width: 16,
      decoration: BoxDecoration(
        gradient: isCompleted
            ? LinearGradient(
                colors: [Colors.blue.shade700, Colors.lightBlue.shade400],
              )
            : null,
        color: !isCompleted ? Colors.grey[300] : null,
        borderRadius: BorderRadius.circular(1.5),
      ),
    );
  }

  Widget _buildBasicInfoStep(bool isSmallScreen) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome! Let\'s get your mess listed in just a few simple steps:',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              color: Colors.grey[900],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),

          FormFieldWithHeader(
            headerText: 'Mess Name',
            hintText: 'Enter your mess name',
            icon: Icons.restaurant,
            controller: _messNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter mess name';
              }
              return null;
            },
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),

          FormFieldWithHeader(
            headerText: 'Mess Owner Name',
            hintText: 'Enter your mess owner name',
            icon: Icons.person_outline,
            controller: _ownerNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter owner name';
              }
              return null;
            },
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),

          FormFieldWithHeader(
            headerText: 'Email Address',
            hintText: 'Enter your email address',
            keyboardType: TextInputType.emailAddress,
            icon: Icons.email_outlined,
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),

          FormFieldWithHeader(
            headerText: 'Mobile Number',
            hintText: 'Enter your mobile number',
            keyboardType: TextInputType.phone,
            icon: Icons.phone_outlined,
            controller: _mobileController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter mobile number';
              }
              if (value.length != 10) {
                return 'Please enter a valid 10-digit number';
              }
              return null;
            },
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),

          FormFieldWithHeader(
            headerText: 'Mess Address',
            hintText: 'Enter your mess address',
            icon: Icons.location_on_outlined,
            controller: _addressController,
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter address';
              }
              return null;
            },
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),
        ],
      ),
    );
  }

  Widget _buildServiceDetailsStep(bool isSmallScreen) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome! Let\'s get your mess listed in just a few simple steps:',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),

          Text(
            'Mess types offered',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          SizedBox(height: 4),
          Column(
            children: [
              RadioListTile<String>(
                title: Text('Veg'),
                value: 'Veg',
                groupValue: _selectedMessType,
                onChanged: (value) {
                  setState(() {
                    _selectedMessType = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Non-Veg'),
                value: 'Non-Veg',
                groupValue: _selectedMessType,
                onChanged: (value) {
                  setState(() {
                    _selectedMessType = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Both'),
                value: 'Both',
                groupValue: _selectedMessType,
                onChanged: (value) {
                  setState(() {
                    _selectedMessType = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),

          Text(
            'Mess timings',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          SizedBox(height: 8),
          _buildTimingRow('Breakfast', _breakfastStartTime, _breakfastEndTime),
          SizedBox(height: 8),
          _buildTimingRow('Lunch', _lunchStartTime, _lunchEndTime),
          SizedBox(height: 8),
          _buildTimingRow('Dinner', _dinnerStartTime, _dinnerEndTime),
          SizedBox(height: isSmallScreen ? 12 : 16),

          Text(
            'Delivery available',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          SizedBox(height: 4),
          Column(
            children: [
              RadioListTile<String>(
                title: Text('Yes'),
                value: 'Yes',
                groupValue: _selectedDeliveryAvailable,
                onChanged: (value) {
                  setState(() {
                    _selectedDeliveryAvailable = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('No'),
                value: 'No',
                groupValue: _selectedDeliveryAvailable,
                onChanged: (value) {
                  setState(() {
                    _selectedDeliveryAvailable = value;
                    _serviceRadiusController.text = '';
                  });
                },
              ),
              if (_selectedDeliveryAvailable == 'Yes') ...[
                SizedBox(height: 16),
                FormFieldWithHeader(
                  headerText: 'Service Radius',
                  hintText: 'Enter service radius in km',
                  keyboardType: TextInputType.number,
                  icon: Icons.delivery_dining,
                  controller: _serviceRadiusController,
                  suffixText: 'Km',
                  validator: (value) {
                    if (_selectedDeliveryAvailable == 'Yes' &&
                        (value == null || value.isEmpty)) {
                      return 'Please enter service radius';
                    }
                    return null;
                  },
                ),
              ],
            ],
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),
        ],
      ),
    );
  }

  Widget _buildTimingRow(
    String mealType,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  ) {
    return Row(
      children: [
        Expanded(child: Text(mealType)),
        Expanded(
          child: InkWell(
            onTap: () => _selectTime(context, true, mealType),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                startTime != null ? startTime.format(context) : 'From',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: InkWell(
            onTap: () => _selectTime(context, false, mealType),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                endTime != null ? endTime.format(context) : 'To',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime(
    BuildContext context,
    bool isStart,
    String mealType,
  ) async {
    final initialTime = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      setState(() {
        switch (mealType) {
          case 'Breakfast':
            if (isStart) {
              _breakfastStartTime = pickedTime;
            } else {
              _breakfastEndTime = pickedTime;
            }
            break;
          case 'Lunch':
            if (isStart) {
              _lunchStartTime = pickedTime;
            } else {
              _lunchEndTime = pickedTime;
            }
            break;
          case 'Dinner':
            if (isStart) {
              _dinnerStartTime = pickedTime;
            } else {
              _dinnerEndTime = pickedTime;
            }
            break;
        }
      });
    }
  }

  Widget _buildPricingStep(bool isSmallScreen) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome! Let\'s get your mess listed in just a few simple steps:',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),

          FormFieldWithHeader(
            headerText: 'Daily Meal Price',
            hintText: 'Enter daily meal price',
            keyboardType: TextInputType.number,
            icon: Icons.today,
            controller: _dailyPriceController,
            prefixText: '₹ ',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter daily price';
              }
              return null;
            },
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),

          FormFieldWithHeader(
            headerText: 'Weekly Meal Price',
            hintText: 'Enter weekly meal price',
            keyboardType: TextInputType.number,
            icon: Icons.date_range,
            controller: _weeklyPriceController,
            prefixText: '₹ ',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter weekly price';
              }
              return null;
            },
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),

          FormFieldWithHeader(
            headerText: 'Monthly Meal Price',
            hintText: 'Enter monthly meal price',
            keyboardType: TextInputType.number,
            icon: Icons.calendar_month,
            controller: _monthlyPriceController,
            prefixText: '₹ ',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter monthly price';
              }
              return null;
            },
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),

          FormFieldWithHeader(
            headerText: 'Trial Meal Price',
            hintText: 'Enter trial meal price',
            keyboardType: TextInputType.number,
            icon: Icons.star_outline,
            controller: _trialPriceController,
            prefixText: '₹ ',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter trial price';
              }
              return null;
            },
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),

          Text(
            'Any Ongoing Offers or Discounts?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade800,
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                RadioListTile<String>(
                  title: Text(
                    'Yes',
                    style: TextStyle(color: Colors.blue.shade800),
                  ),
                  value: 'Yes',
                  groupValue: _selectedHasOffers,
                  activeColor: Colors.blue.shade600,
                  onChanged: (value) {
                    setState(() {
                      _selectedHasOffers = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text(
                    'No',
                    style: TextStyle(color: Colors.blue.shade800),
                  ),
                  value: 'No',
                  groupValue: _selectedHasOffers,
                  activeColor: Colors.blue.shade600,
                  onChanged: (value) {
                    setState(() {
                      _selectedHasOffers = value;
                      _offerController.text = '';
                    });
                  },
                ),
              ],
            ),
          ),
          if (_selectedHasOffers == 'Yes') ...[
            SizedBox(height: isSmallScreen ? 16 : 24),
            FormFieldWithHeader(
              headerText: 'Offer Details',
              hintText: 'Enter your current offer',
              icon: Icons.local_offer_outlined,
              controller: _offerController,
              validator: (value) {
                if (_selectedHasOffers == 'Yes' &&
                    (value == null || value.isEmpty)) {
                  return 'Please enter offer details';
                }
                return null;
              },
            ),
          ],
          SizedBox(height: isSmallScreen ? 12 : 16),
        ],
      ),
    );
  }

  Widget _buildPhotosStep(bool isSmallScreen) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome! Let\'s get your mess listed in just a few simple steps:',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),

          Text(
            'Upload your Mess photos',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade700, Colors.lightBlue.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 40, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'Upload Image',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Uploaded photos',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border.all(color: Colors.blue.shade200, width: 1.5),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: _selectedImages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_library_outlined,
                          color: Colors.grey.shade400,
                          size: 32,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'No photos uploaded yet',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    children: _selectedImages.asMap().entries.map((entry) {
                      int index = entry.key;
                      File image = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(image, fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () => _removeImage(index),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade600,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Image Source',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImageSourceOption(
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImageFromSource(ImageSource.camera);
                    },
                  ),
                  _buildImageSourceOption(
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImageFromSource(ImageSource.gallery);
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.lightBlue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromSource(ImageSource source) async {
    try {
      final picker = ImagePicker();
      print('Attempting to pick image from: ${source.toString()}');

      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        print('Image picked successfully: ${pickedFile.path}');
        setState(() {
          _selectedImages.add(File(pickedFile.path));
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image added successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        print('No image was selected');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No image selected'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: Unable to access ${source == ImageSource.camera ? "camera" : "gallery"}. Please check app permissions.',
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleStepAction() {
    if (_currentStep < 3) {
      if (_validateCurrentStep()) {
        _nextStep();
      }
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _formKey.currentState!.validate() &&
            _messNameController.text.isNotEmpty &&
            _ownerNameController.text.isNotEmpty &&
            _emailController.text.isNotEmpty &&
            _mobileController.text.isNotEmpty &&
            _addressController.text.isNotEmpty;
      case 1:
        return _formKey.currentState!.validate() &&
            _selectedMessType != null &&
            _selectedDeliveryAvailable != null &&
            (_selectedDeliveryAvailable != 'Yes' ||
                _serviceRadiusController.text.isNotEmpty);
      case 2:
        return _formKey.currentState!.validate() &&
            _dailyPriceController.text.isNotEmpty &&
            _weeklyPriceController.text.isNotEmpty &&
            _monthlyPriceController.text.isNotEmpty &&
            _trialPriceController.text.isNotEmpty &&
            (_selectedHasOffers != 'Yes' || _offerController.text.isNotEmpty);
      case 3:
        return true; // Photos are optional
      default:
        return false;
    }
  }

  Future<void> _handleRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Here you would typically call your registration API
      // For now, we'll just simulate a delay
      await Future.delayed(Duration(seconds: 2));

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mess registration successful!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to home/dashboard
      // Navigator.of(context).pushReplacement(...);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

class FormFieldWithHeader extends StatelessWidget {
  final String headerText;
  final String hintText;
  final TextInputType? keyboardType;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final ValueChanged<String?>? onChanged;
  final IconData? icon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final String? suffixText;

  const FormFieldWithHeader({
    super.key,
    required this.headerText,
    required this.hintText,
    this.keyboardType,
    this.isDropdown = false,
    this.dropdownItems,
    this.onChanged,
    this.icon,
    this.controller,
    this.validator,
    this.maxLines = 1,
    this.inputFormatters,
    this.prefixText,
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            headerText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: isDropdown
              ? _buildDropdownField(context)
              : _buildTextField(context),
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.blue.shade300, fontSize: 16),
        prefixIcon: icon != null
            ? Icon(icon, color: Colors.blue.shade400, size: 22)
            : null,
        prefixText: prefixText,
        suffixText: suffixText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade500, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
      validator: validator,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
    );
  }

  Widget _buildDropdownField(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.blue.shade300, fontSize: 16),
        prefixIcon: icon != null
            ? Icon(icon, color: Colors.blue.shade400, size: 22)
            : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade500, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      dropdownColor: Colors.white,
      style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
      icon: Icon(Icons.keyboard_arrow_down, color: Colors.blue.shade400),
      items: dropdownItems?.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.blue.shade800)),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
