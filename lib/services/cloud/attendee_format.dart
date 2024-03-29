import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Attendee {
  final Timestamp created;
  final String userId;
  final String name;

  const Attendee({
    required this.name,
    required this.created,
    required this.userId,
  });

  Attendee.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : created = snapshot.data()['time'],
        name = snapshot.data()['name'],
        userId = snapshot.data()['userId'];
}
