import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  final String heading;
  final String message;
  final Timestamp timestamp;
  Notification({
    required this.message,
    required this.timestamp,
    required this.heading,
  });

  Map<String, dynamic> toJson() {
    return {
      'heading': heading,
      'message': message,
      'timestamp': timestamp,
    };
  }

  static Notification fromJson(Map<String, dynamic> json) {
    return Notification(
      heading: json['heading'],
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }
}
