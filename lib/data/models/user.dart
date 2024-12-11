import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? fullName;
  String? email;
  DateTime? createdAt;
  UserModel({
    this.uid,
    this.fullName,
    this.email,
    this.createdAt,
  });

\
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      uid: documentId,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

 
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'createdAt': createdAt,
    };
  }
}
