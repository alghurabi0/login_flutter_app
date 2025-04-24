import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String username;
  final String phoneNumber;
  final String? password;
  final String? sessionId;

  UserModel({
    this.id,
    required this.username,
    required this.phoneNumber,
    this.password,
    this.sessionId,
  });

  // Static function to create an empty user model.
  static UserModel empty() => UserModel(username: '', phoneNumber: '');

  // Convert model to JSON structure.
  Map<String, dynamic> toJson() => {
    'username': username,
    'phone_number': phoneNumber,
    'session_id': sessionId,
  };

  // Convert JSON structure to model.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      sessionId: json['session_id'],
    );
  }

  // Covert Firestore document to model.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;
      return UserModel(
        id: doc.id,
        username: data['username'] ?? '',
        phoneNumber: data['phone_number'] ?? '',
        sessionId: data['session_id'],
      );
    } else {
      return UserModel.empty();
    }
  }
}
