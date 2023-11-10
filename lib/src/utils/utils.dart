import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  static Timestamp convertMapToTimestamp(dynamic data) {
    if (data != null) {
      if (data is int) {
        return Timestamp.fromMillisecondsSinceEpoch(data);
      } else if (data is Timestamp) {
        return data;
      }
    }
    return Timestamp.now();
  }
}
