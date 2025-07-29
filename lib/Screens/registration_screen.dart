import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liv_meal_app/Screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isHostelOwner = false;
  bool _isLoading = false;

  // Color Scheme
  final Color primaryColor = const Color(0xFF1976D2);
  final Color secondaryColor = const Color(0xFF64B5F6);
  final Color textColor = const Color(0xFF212121);
  final Color lightTextColor = const Color(0xFF757575);
  final Color backgroundColor = const Color(0xFFFAFAFA);

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Log registration attempt
      log('Registration attempt started', name: 'Registration');
      log('Name: ${_nameController.text}', name: 'Registration');
      log('Phone: ${_phoneController.text}', name: 'Registration');
      log('Email: ${_emailController.text}', name: 'Registration');
      if (_isHostelOwner) {
        log('Address: ${_addressController.text}', name: 'Registration');
      }

      try {
        await Future.delayed(const Duration(seconds: 2)); // Simulate API call

        // Log successful registration
        log('Registration successful', name: 'Registration');

        // Navigate to login page after successful registration
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const OtpLoginPage()),
          (route) => false,
        );
      } catch (e) {
        log(
          'Registration failed: $e',
          name: 'Registration',
          error: e,
          stackTrace: StackTrace.current,
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo Section
                Hero(
                  tag: 'app-logo',
                  child: Image.asset(
                    'assets/images/loginScreenImage.png',
                    height: size.height * 0.2,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  'Create Account',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // User Type Toggle
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: _isHostelOwner ? Colors.blue : Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      // Hostel Owner Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (!_isHostelOwner) {
                              setState(() => _isHostelOwner = true);
                              log(
                                'User selected: Hostel Owner',
                                name: 'Registration',
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _isHostelOwner
                                  ? primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                'Hostel Owner',
                                style: TextStyle(
                                  color: _isHostelOwner
                                      ? Colors.white
                                      : textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Student Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (_isHostelOwner) {
                              setState(() => _isHostelOwner = false);
                              log(
                                'User selected: Student',
                                name: 'Registration',
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: !_isHostelOwner
                                  ? primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                'Student',
                                style: TextStyle(
                                  color: !_isHostelOwner
                                      ? Colors.white
                                      : textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Form Fields
                _buildTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  icon: Icons.person_outline,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),

                _buildTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Only allow digits
                    LengthLimitingTextInputFormatter(
                      10,
                    ), // Limit to 10 characters
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    if (value.length != 10) {
                      return 'Enter valid 10-digit number';
                    }
                    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                      // Indian phone number validation
                      return 'Enter valid Indian mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                _buildTextField(
                  controller: _emailController,
                  label: 'Email (Optional)',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                if (_isHostelOwner) ...[
                  _buildTextField(
                    controller: _addressController,
                    label: 'Property Address',
                    icon: Icons.location_on_outlined,
                    maxLines: 3,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter address' : null,
                  ),
                  const SizedBox(height: 16),
                ],

                // Register Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 16),

                // Login Prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: lightTextColor),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OtpLoginPage(),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //   Widget _buildTextField({
  //     required TextEditingController controller,
  //     required String label,
  //     required IconData icon,
  //     TextInputType? keyboardType,
  //     int? maxLines = 1,
  //     String? Function(String?)? validator,
  //   }) {
  //     return TextFormField(
  //       controller: controller,
  //       keyboardType: keyboardType,
  //       maxLines: maxLines,
  //       validator: validator,
  //       style: TextStyle(color: textColor),
  //       decoration: InputDecoration(
  //         labelText: label,
  //         labelStyle: TextStyle(color: lightTextColor),
  //         prefixIcon: Icon(icon, color: secondaryColor),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(color: Colors.grey.shade300),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(color: Colors.grey.shade300),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(color: primaryColor, width: 2),
  //         ),
  //         contentPadding: const EdgeInsets.symmetric(
  //           vertical: 16,
  //           horizontal: 16,
  //         ),
  //       ),
  //     );
  //   }
  // }
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int? maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
