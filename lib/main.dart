import 'package:dfine_task/features/controllers/theme_controller.dart';
import 'package:dfine_task/features/controllers/todo_controller.dart';
import 'package:dfine_task/features/view/add-category/add_category.dart';
import 'package:dfine_task/features/view/home/homescreen.dart';
import 'package:dfine_task/features/view/login/forgot_password/forgot_password.dart';
import 'package:dfine_task/features/view/login/login.dart';
import 'package:dfine_task/features/view/register/register.dart';
import 'package:dfine_task/features/view/settings/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeController()),
        ChangeNotifierProvider(create: (context) => TodoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginScreen(),
        routes: {
          '/register': (context) => RegisterScreen(),
          '/login': (context) => LoginScreen(),
          '/forget': (context) => ForgotPassword(),
          '/home': (context) => HomeScreen(),
          '/addtask': (context) => AddCategory(),
          '/settings': (context) => SettingsPage(),
        },
      ),
    );
  }
}
