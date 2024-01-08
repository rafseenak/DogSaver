import 'package:dog_catcher/screens/chat_screen.dart';
import 'package:dog_catcher/screens/notification_screen.dart';
import 'package:dog_catcher/screens/report_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex = 0;

  List<Widget> widgetList = [
    NotificationScreen(),
    ReportScreen(),
    const ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myIndex,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 218, 162, 181),
        fixedColor: const Color.fromARGB(255, 0, 0, 0),
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: myIndex,
          children: widgetList,
        ),
      ),
    );
  }
}
