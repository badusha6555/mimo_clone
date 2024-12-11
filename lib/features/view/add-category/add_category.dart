import 'package:dfine_task/features/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final List<Map<String, dynamic>> tasks = [
    {
      'header': 'Today',
      'items': [
        {'title': '10 min Running', 'done': true},
        {'title': '5 min Rope Skipping', 'done': true}
      ]
    },
    {
      'header': 'Tomorrow',
      'items': [
        {'title': '10 Push ups', 'done': false},
        {'title': '10 Pull ups', 'done': false},
        {'title': '20 Squads', 'done': false},
        {'title': '30 Jump', 'done': false}
      ]
    },
    {
      'header': 'Fri, Oct 04, 2019',
      'items': [
        {'title': 'Lose 20 Kg', 'done': false},
        {'title': 'Reach 50 Push ups', 'done': false},
        {'title': 'Reach 15 min Rope Skipping', 'done': false},
        {'title': 'Reach 100 Squads', 'done': false}
      ]
    },
    {
      'header': 'Wed, Jan 01, 2020',
      'items': [
        {'title': 'Lose 10 Kg', 'done': false},
        {'title': 'Reach 100 Push ups', 'done': false},
        {'title': 'Reach 20 min Rope Skipping', 'done': false}
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeController>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.backgroundColor,
        title: Text('Sport', style: TextStyle(color: themeProvider.textColor)),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: themeProvider.textColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final section = tasks[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  section['header'],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.textColor),
                ),
              ),
              ...section['items'].map<Widget>((item) {
                return ListTile(
                  leading: IconButton(
                    icon: Icon(
                      item['done']
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: item['done'] ? Colors.green : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        item['done'] = !item['done'];
                      });
                    },
                  ),
                  title: Text(
                    item['title'],
                    style: TextStyle(color: themeProvider.textColor),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: themeProvider.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                content: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Type your task...',
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: themeProvider.addButtonColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        backgroundColor: themeProvider.buttonColor,
      ),
    );
  }
}
