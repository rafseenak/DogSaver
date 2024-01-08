import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_catcher/models/report_model.dart';

class ReportService {
  Future reportDogs(
    String username,
    String phone,
    String location,
  ) async {
    final issueDoc = FirebaseFirestore.instance.collection('issues');

    final data = Report(
      username: username,
      phone: phone,
      location: location,
      timestamp: Timestamp.now(),
    );
    await issueDoc.add(data.toJson());
  }
}
