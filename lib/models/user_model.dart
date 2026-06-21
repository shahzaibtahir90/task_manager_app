import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;
  final String? profileImageUrl;
  final String? profileImageBase64;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
    this.profileImageUrl,
    this.profileImageBase64,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
      'profileImageUrl': profileImageUrl ?? '',
      'profileImageBase64': profileImageBase64 ?? '',
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    DateTime parseDate(dynamic value) {
      if (value is Timestamp) {
        return value.toDate();
      } else if (value is DateTime) {
        return value;
      } else if (value is String) {
        return DateTime.tryParse(value) ?? DateTime.now();
      }
      return DateTime.now();
    }

    final imageUrl = map['profileImageUrl'] as String?;
    final imageBase64 = map['profileImageBase64'] as String?;

    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      createdAt: parseDate(map['createdAt']),
      profileImageUrl:
          imageUrl != null && imageUrl.isNotEmpty ? imageUrl : null,
      profileImageBase64:
          imageBase64 != null && imageBase64.isNotEmpty ? imageBase64 : null,
    );
  }
}
