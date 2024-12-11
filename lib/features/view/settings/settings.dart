import 'package:dfine_task/core/firestore_services/auth_services.dart';
import 'package:dfine_task/features/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeController>(context);
    final AuthServices authServices = AuthServices();
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.backgroundColor,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            color: themeProvider.textColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: themeProvider.backgroundColor,
                  backgroundImage: AssetImage(
                    'assets/Screenshot 2024-12-11 141142.png',
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Badusha p',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.textColor,
                      ),
                    ),
                    Text(
                      'Flutter Developer',
                      style: TextStyle(
                        fontSize: 14,
                        color: themeProvider.textColor,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit, color: themeProvider.textColor),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Hi I am Badusha P, I am Flutter Developer ',
              style: TextStyle(
                fontSize: 16,
                color: themeProvider.textColor,
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading:
                  Icon(Icons.notifications, color: themeProvider.textColor),
              title: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.textColor,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: themeProvider.textColor,
              ),
              title: Text(
                'General',
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.textColor,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person, color: themeProvider.textColor),
              title: Text(
                'Account',
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.textColor,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.info, color: themeProvider.textColor),
              title: Text(
                'About',
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.textColor,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.dark_mode, color: themeProvider.textColor),
              title: Text(
                'Dark / Light',
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.textColor,
                ),
              ),
              onTap: () {
                themeProvider.changeTheme();
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: themeProvider.textColor),
              title: Text(
                'Log out',
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.textColor,
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Are you sure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            authServices.logoutUser();
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
