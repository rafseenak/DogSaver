import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String senderId;
  final String? senderEmail;
  final String message;
  final Timestamp timestamp;
  Chat({
    required this.senderId,
    required this.senderEmail,
    required this.message,
    required this.timestamp,
  });
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
