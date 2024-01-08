import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_catcher/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> sendMessage(String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String? currentUserEmail = _firebaseAuth.currentUser!.email;
    final Timestamp timestamp = Timestamp.now();
    Chat newChat = Chat(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      message: message,
      timestamp: timestamp,
    );

    await _firebaseFirestore
        .collection('chat_room')
        .doc(currentUserId)
        .collection('messages')
        .add(
          newChat.toMap(),
        );
  }

  Stream<QuerySnapshot> getChats(String userId) {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    return _firebaseFirestore
        .collection('chat_room')
        .doc(currentUserId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
