import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liv_meal_app/Screens/auth/OTP_screen.dart';
import 'package:liv_meal_app/Screens/student/student_dashboard.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({super.key});

  @override
  State<StudentRegisterScreen> createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Top bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => StudentDashboard(),
                                ),
                                (route) => false,
                              );
                            },
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.only(right: 30),
                              ),
                            ),
                            child: Text(
                              "Skip ->",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),

                      /// 👇 Main scrollable form content
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  spacing: 15,
                                  children: [
                                    Image.asset(
                                      "assets/LogoWithSlogan.png",
                                      width: 200,
                                    ),
                                    const Text(
                                      "Registration",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "Welcome aboard! Your search for the perfect stay and meals starts here.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),

                              const FormFieldWithHeader(
                                headerText: 'Full Name',
                                hintText: 'Enter your full name',
                                icon: Icons.person_outline,
                              ),
                              const SizedBox(height: 24),

                              const FormFieldWithHeader(
                                headerText: 'Email Address',
                                hintText: 'Enter your email address',
                                keyboardType: TextInputType.emailAddress,
                                icon: Icons.email_outlined,
                              ),
                              const SizedBox(height: 24),

                              const FormFieldWithHeader(
                                headerText: 'Mobile Number',
                                hintText: 'Enter your mobile number',
                                keyboardType: TextInputType.phone,
                                icon: Icons.phone_outlined,
                              ),
                              const SizedBox(height: 24),

                              FormFieldWithHeader(
                                headerText: 'Gender',
                                hintText: 'Select your gender',
                                isDropdown: true,
                                dropdownItems: const [
                                  'Male',
                                  'Female',
                                  'Other',
                                  'Prefer not to say',
                                ],
                                icon: Icons.wc_outlined,
                                onChanged: (value) {},
                              ),
                              const SizedBox(height: 40),

                              Container(
                                width: double.infinity,
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
                                  onPressed: () {},
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
                                        Icons.person_add,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Create Account',
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

                              // const SizedBox(height: 24),

                              // Center(
                              //   child: TextButton(
                              //     onPressed: () {
                              //       Navigator.of(context).push(
                              //         MaterialPageRoute(
                              //           builder: (context) => OTPScreen(),
                              //         ),
                              //       );
                              //     },
                              //     child: RichText(
                              //       text: TextSpan(
                              //         text: 'Already have an account? ',
                              //         style: TextStyle(
                              //           color: Colors.blue.shade600,
                              //           fontSize: 16,
                              //         ),
                              //         children: [
                              //           TextSpan(
                              //             text: 'Sign In',
                              //             style: TextStyle(
                              //               color: Colors.blue.shade800,
                              //               fontWeight: FontWeight.bold,
                              //               decoration:
                              //                   TextDecoration.underline,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
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

  const FormFieldWithHeader({
    super.key,
    required this.headerText,
    required this.hintText,
    this.keyboardType,
    this.isDropdown = false,
    this.dropdownItems,
    this.onChanged,
    this.icon,
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
    return TextField(
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
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
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
    );
  }
}
