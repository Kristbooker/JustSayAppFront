import 'package:flutter/material.dart';
import 'package:justsaying/menu/favorite_page.dart';
import 'package:justsaying/menu/feeds_page.dart';
import 'package:justsaying/menu/notifications_page.dart';
import 'package:justsaying/menu/profile_page.dart';

import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(), // เปลี่ยนจาก MyHomePage เป็น LoginScreen
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  final int userId;
  const MyHomePage({Key? key, required this.title, required this.userData, required this.userId})
      : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final tabs;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    print("main");
    print(widget.userData);

    tabs = [
      FeedsPage(userId : widget.userId),
      FavoritePage(userId : widget.userId),
      NotificationsPage(userId : widget.userId),
      ProfilePage(userData: widget.userData),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        iconSize: 35,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.feed),
              label: "Feeds",
              backgroundColor: Color.fromARGB(255, 34, 31, 35)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorite",
              backgroundColor: Color.fromARGB(255, 34, 31, 35)),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notification",
              backgroundColor: Color.fromARGB(255, 34, 31, 35)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: Color.fromARGB(255, 34, 31, 35)),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
