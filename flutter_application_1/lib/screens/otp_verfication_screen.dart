import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_application_1/widgets/gradient_button.dart';

class OtpVerficationScreen extends StatefulWidget {
  const OtpVerficationScreen({super.key});

  @override
  State<OtpVerficationScreen> createState() => _OtpVerficationScreenState();
}

class _OtpVerficationScreenState extends State<OtpVerficationScreen> {
  final int otpLength = 6;
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];

  bool _isVerifying = false;
  int _resendTimer = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < otpLength; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
          _startResendTimer();
        } else {
          _canResend = true;
        }
      });
    });
  }

  void _verifyOTP() {
    String otp = _controllers.map((controller) => controller.text).join();
    if (otp.length == otpLength) {
      setState(() => _isVerifying = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppTheme.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verify Phone",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                "Enter 6-digit code sent to +123 456 789 000",
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  otpLength,
                  (index) => SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppTheme.textSecondary.withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppTheme.primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < otpLength - 1) {
                            _focusNodes[index + 1].requestFocus();
                          } else {
                            _focusNodes[index].unfocus();
                            _verifyOTP();
                          }
                        } else if (index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              GradientButton(
                text: _isVerifying ? "Verifying..." : "Verify",
                onPressed: () {
                  if (!_isVerifying) {
                    _verifyOTP();
                  }
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Didn't receive the code?",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _canResend
                          ? () {
                              setState(() {
                                _canResend = false;
                                _resendTimer = 30;
                              });
                              _startResendTimer();
                            }
                          : null,
                      child: Text(
                        _canResend
                            ? "Resend Code"
                            : "Resend Code in ${_resendTimer}s",
                        style: TextStyle(
                          color: _canResend
                              ? AppTheme.primaryColor
                              : AppTheme.textSecondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
    );
  }
}
