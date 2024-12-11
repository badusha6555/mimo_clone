import 'package:dfine_task/core/firestore_services/auth_services.dart';
import 'package:dfine_task/features/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final AuthServices authServices = AuthServices();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeController>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(26),
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  Gap(20),
                  Text(
                    'Create an Account',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: themeProvider.textColor),
                  ),
                ],
              ),
              Gap(10),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                elevation: 2,
                color: Colors.white,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.black38),
                      border: InputBorder.none),
                ),
              ),
              Gap(10),
              Text(
                "Enter the email address you used to create  your account and we will email you a link to reset your password.",
                style: TextStyle(color: themeProvider.textColor),
              ),
              Gap(30),
              ElevatedButton(
                onPressed: () {
                  authServices.resetPassword(
                    emailController.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeProvider.buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  minimumSize: Size(300, 50),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
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
    );
  }
}
