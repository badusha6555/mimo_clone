import 'dart:developer';

import 'package:dfine_task/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  bool isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email);
  }

  Future<void> registerUser(
      String fullName, String email, String password) async {
    if (!isValidEmail(email)) {
      log("Error: Invalid email format");
      return;
    }

    try {
      // Create user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Save additional user details in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'fullName': fullName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      log("User registered successfully");
    } catch (e) {
      log("Error registering user: $e");
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      log("User logged in successfully");
    } catch (e) {
      log("Error logging in: $e");
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      log("Password reset email sent");
    } catch (e) {
      log("Error sending password reset email: $e");
    }
  }

  Future<void> saveUserToFirestore(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(user.toMap());
      log("User data saved successfully");
    } catch (e) {
      log("Error saving user data: $e");
    }
  }

  Future<UserModel?> getUserFromFirestore(String uid) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        log("User not found");
        return null;
      }
    } catch (e) {
      log("Error fetching user data: $e");
      return null;
    }
  }

  Future<void> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      log("User logged out successfully");
    } catch (e) {
      log("Error logging out: $e");
    }
  }
}
