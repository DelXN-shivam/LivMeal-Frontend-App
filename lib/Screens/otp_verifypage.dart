import 'package:flutter/material.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  bool _isLoading = false;
  bool _canResend = false;
  int _resendTimeout = 30;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_resendTimeout > 0) {
        setState(() => _resendTimeout--);
        _startResendTimer();
      } else {
        setState(() => _canResend = true);
      }
    });
  }

  Future<void> _verifyOtp() async {
    final otp = _otpControllers.fold<String>(
      '',
      (prev, controller) => prev + controller.text,
    );

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter complete 6-digit OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // Simulate verification
    setState(() => _isLoading = false);
    Navigator.pushReplacementNamed(context, '/home');
  }

  Future<void> _resendOtp() async {
    setState(() {
      _canResend = false;
      _resendTimeout = 30;
    });
    _startResendTimer();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OTP resent to ${widget.phoneNumber}'),
        backgroundColor: Colors.blue[800],
      ),
    );
  }

  void _handleOtpFieldChange(String value, int index) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]);
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('OTP Verification'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Icon(Icons.verified_user, size: 80, color: Colors.blue[800]),
              const SizedBox(height: 24),
              Text(
                'Enter OTP',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Sent to +91 ',
                  style: TextStyle(color: Colors.grey[600]),
                  children: [
                    TextSpan(
                      text: widget.phoneNumber,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 48,
                    child: TextFormField(
                      controller: _otpControllers[index],
                      focusNode: _otpFocusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) => _handleOtpFieldChange(value, index),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Verify Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Verify OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // Resend OTP
              TextButton(
                onPressed: _canResend ? _resendOtp : null,
                child: Text(
                  _canResend
                      ? 'Resend OTP'
                      : 'Resend OTP in $_resendTimeout seconds',
                  style: TextStyle(
                    color: _canResend ? Colors.blue[800] : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
