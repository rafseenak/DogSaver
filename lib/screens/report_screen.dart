// ignore_for_file: use_build_context_synchronously

import 'package:dog_catcher/main.dart';
import 'package:dog_catcher/screens/login_screen.dart';
import 'package:dog_catcher/services/auth_service.dart';
import 'package:dog_catcher/services/notification_services.dart';
import 'package:dog_catcher/services/report_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  final AuthService _auth = AuthService();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Report',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 247, 172, 197),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
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
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 229, 229),
                      border: Border.all(
                        color: const Color.fromARGB(255, 230, 229, 229),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your Name',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 229, 229),
                      border: Border.all(
                        color: const Color.fromARGB(255, 230, 229, 229),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your Phone Number',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 229, 229),
                      border: Border.all(
                        color: const Color.fromARGB(255, 230, 229, 229),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Location of Dogs',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20,
                      ),
                    ),
                    onPressed: () {
                      final reportService = ReportService();
                      final notificationService = NotificationService();
                      if (_nameController.text.isNotEmpty &&
                          _phoneController.text.isNotEmpty &&
                          _locationController.text.isNotEmpty) {
                        reportService.reportDogs(
                          _nameController.text,
                          _phoneController.text,
                          _locationController.text,
                        );
                        notificationService.addNotification('Dog Found',
                            'Found Some Stray Dogs Near ${_locationController.text}');
                        _nameController.clear();
                        _phoneController.clear();
                        _locationController.clear();
                      }
                    },
                    child: const Text('SUBMIT'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
