// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_catcher/main.dart';
import 'package:dog_catcher/screens/login_screen.dart';
import 'package:dog_catcher/services/auth_service.dart';
import 'package:dog_catcher/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final AuthService _auth = AuthService();
  final notificationService = NotificationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              await _auth.signOut();
              final sharedPreference = await SharedPreferences.getInstance();
              await sharedPreference.setBool(SAVE_KEY_NAME, false);
              await sharedPreference.setBool(ANONIMOUS_KEY, false);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildNotification(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotification() {
    return StreamBuilder(
      stream: notificationService.getNotifications(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error ${snapshot.error}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(
              'Loading...',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return ListTile(
      title: Text(
        data['heading'],
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      ),
      subtitle: Text(
        data['message'],
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
