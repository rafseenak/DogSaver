import 'package:dog_catcher/main.dart';
import 'package:dog_catcher/screens/chat_screen.dart';
import 'package:dog_catcher/screens/continue_login.dart';
import 'package:dog_catcher/screens/notification_screen.dart';
import 'package:dog_catcher/screens/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex = 0;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final sharedPreference = await SharedPreferences.getInstance();

    widgetList = (sharedPreference.getBool(ANONIMOUS_KEY) == true)
        ? [
            NotificationScreen(),
            const ContinueLogin(),
            const ContinueLogin(),
          ]
        : [
            NotificationScreen(),
            ReportScreen(),
            const ChatScreen(),
          ];
  }

  List<Widget> widgetList = (2 == 2)
      ? [
          NotificationScreen(),
          ReportScreen(),
          const ChatScreen(),
        ]
      : [
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
            icon: Icon(Icons.home),
            label: 'Home',
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
