import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String username;
  String email;
  String phoneNumber;
  String address;
  String imageUrl;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.imageUrl,
  });

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      username: doc['username'],
      email: doc['email'],
      phoneNumber: doc['phoneNumber'],
      address: doc['address'],
      imageUrl: doc['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'imageUrl': imageUrl,
    };
  }
}
