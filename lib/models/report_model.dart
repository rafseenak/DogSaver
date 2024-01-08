import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String username;
  final String phone;
  final String location;
  final Timestamp timestamp;
  Report({
    required this.username,
    required this.phone,
    required this.location,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'phone': phone,
      'location': location,
      'timestamp': timestamp,
    };
  }
}
