// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:dog_catcher/main.dart';
import 'package:dog_catcher/screens/login_screen.dart';
import 'package:dog_catcher/services/auth_service.dart';
import 'package:dog_catcher/services/notification_services.dart';
import 'package:dog_catcher/services/report_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  File? _selectedImage;

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          gallaryImage();
                        },
                        icon: const Icon(Icons.image_rounded),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          captureImage();
                        },
                        icon: const Icon(Icons.camera_enhance_rounded),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  (_selectedImage != null)
                      ? Image.file(
                          _selectedImage!,
                          height: 50,
                        )
                      : const SizedBox(height: 10),
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
                          _locationController.text.isNotEmpty &&
                          _selectedImage != null) {
                        reportService.reportDogs(
                          _nameController.text,
                          _phoneController.text,
                          _locationController.text,
                          _selectedImage!.path,
                        );
                        notificationService.addNotification('Dog Found',
                            'Found Some Stray Dogs Near ${_locationController.text}');
                        uploadImage();
                        _nameController.clear();
                        _phoneController.clear();
                        _locationController.clear();
                        setState(() {
                          _selectedImage = null;
                        });
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

  Future<XFile?> gallaryImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
    return null;
  }

  Future<XFile?> captureImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
    return null;
  }

  Future uploadImage() async {
    final path = 'files/${_selectedImage!.path}';
    final file = File(_selectedImage!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }
}
