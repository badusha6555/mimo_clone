import 'package:dfine_task/core/firestore_services/auth_services.dart';
import 'package:dfine_task/features/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthServices authServices = AuthServices();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeController>(context);

    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.backgroundColor,
        actions: [
          Consumer<ThemeController>(
            builder: (context, themeController, child) => IconButton(
              onPressed: () {
                themeController.changeTheme();
              },
              icon: const Icon(Icons.light_mode),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(70),
                Center(
                    child: Hero(
                        tag: "hi",
                        child: Image.asset(themeProvider.imageDark))),
                const SizedBox(height: 16),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  elevation: 2,
                  color: themeProvider.backgroundColor,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: themeProvider.textColor),
                        border: InputBorder.none),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                ),
                Gap(30),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  elevation: 2,
                  color: themeProvider.backgroundColor,
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: themeProvider.textColor),
                        border: InputBorder.none),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forget');
                  },
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                        color: themeProvider.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Gap(10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authServices
                            .loginUser(
                                emailController.text, passwordController.text)
                            .then((_) {
                          Navigator.pushReplacementNamed(context, '/home');
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Login failed: $error")),
                          );
                        });
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: themeProvider.buttonTextColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: themeProvider.buttonColor,
                    ),
                  ),
                ),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account?',
                      style: TextStyle(
                        color: themeProvider.textColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: themeProvider.textColor,
                            decoration: TextDecoration.underline),
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
}
