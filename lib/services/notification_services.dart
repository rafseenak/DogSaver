import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_catcher/models/notification_model.dart';

class NotificationService {
  Future addNotification(String heading, String message) async {
    final notificationDoc =
        FirebaseFirestore.instance.collection('notifications');

    final data = Notification(
      heading: heading,
      message: message,
      timestamp: Timestamp.now(),
    );
    await notificationDoc.add(data.toJson());
  }

  Stream<QuerySnapshot> getNotifications() {
    return FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
