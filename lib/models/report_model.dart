import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String username;
  final String phone;
  final String location;
  final String imagePath;
  final Timestamp timestamp;
  Report({
    required this.username,
    required this.phone,
    required this.location,
    required this.imagePath,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'phone': phone,
      'location': location,
      'imagepath': imagePath,
      'timestamp': timestamp,
    };
  }
}
