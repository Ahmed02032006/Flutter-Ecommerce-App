// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/choose_language_screen.dart';
import 'package:flutter_application_1/screens/forgot_password_screen.dart';
import 'package:flutter_application_1/screens/signup_screen.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_application_1/widgets/custom_text_field.dart';
import 'package:flutter_application_1/widgets/gradient_button.dart';
import 'package:flutter_application_1/widgets/social_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: AppTheme.primaryGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      )),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -50,
                        right: -50,
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 48,
                        left: 16,
                        right: 16,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const Expanded(
                              child: Center(
                                child: Text(
                                  "Welcome Back",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.20,
                left: 24,
                right: 24,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Login to your account",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Enter Your Credentials to continue shopping",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 32),
                        CustomTextField(
                          label: "Email",
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: "Password",
                          prefixIcon: Icons.lock_outline,
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be atleast 6 characters';
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: AppTheme.primaryColor,
                            ),
                            child: const Text("Forgot Password"),
                          ),
                        ),
                        const SizedBox(height: 24),
                        GradientButton(
                          text: "Login",
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ChooseLanguageScreen(),
                                ),
                              );
                            // }
                          },
                        ),
                        const SizedBox(height: 24),
                        const Center(
                          child: Text(
                            "Or continue with",
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: SocialLoginButton(
                                text: "Google",
                                iconPath: "assets/icons/google.png",
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: SocialLoginButton(
                                text: "Apple",
                                iconPath: "assets/icons/apple.png",
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen(),
                                    ),
                                  );
                                },
                                child: const Text("Sign Up"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
