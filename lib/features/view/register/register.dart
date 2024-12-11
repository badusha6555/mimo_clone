import 'package:dfine_task/core/firestore_services/auth_services.dart';
import 'package:dfine_task/features/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final AuthServices authServices = AuthServices();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Email validation method
  bool isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeController>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(170),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                    ),
                    Gap(20),
                    Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: themeProvider.textColor,
                      ),
                    ),
                  ],
                ),
                Gap(10),
                // Full Name
                _buildTextField(
                  controller: fullNameController,
                  hintText: 'Full name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                Gap(10),
                // Email
                _buildTextField(
                  controller: emailController,
                  hintText: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!isValidEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                Gap(10),
                // Password
                _buildTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                Gap(10),
                // Confirm Password
                _buildTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                Gap(30),
                // Register Button
                ElevatedButton(
                  onPressed: () {
                    String email = emailController.text.trim(); // Remove spaces
                    if (!isValidEmail(email)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Invalid email format")),
                      );
                      return;
                    }

                    authServices
                        .registerUser(fullNameController.text, email,
                            passwordController.text)
                        .then((_) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }).catchError(
                      (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Registration failed: $error",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: themeProvider.buttonTextColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: themeProvider.buttonColor,
                  ),
                ),
                Gap(10),
                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: themeProvider.textColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: themeProvider.textColor,
                          decoration: TextDecoration.underline,
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

  // Helper widget for reusable TextFormField
  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      String? Function(String?)? validator,
      bool obscureText = false,
      String errortext = ""}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      elevation: 2,
      color: Colors.white,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black38),
            border: InputBorder.none,
            errorText: errortext),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
