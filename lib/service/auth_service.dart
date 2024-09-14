import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  //method for create account
  Future<User?> createUserWithEmailAndPassword(
      String email, String pass, BuildContext context) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      Helper.showMessage("تم انشاء حساب بنجاح", Colors.green, "#4CAF50FF");

      return cred.user;
    } on FirebaseAuthException catch (e) {
      // Handle specific error codes
      switch (e.code) {
        case 'email-already-in-use':
          Helper.showMessage("الحساب موجود بالفعل لهذا البريد الإلكتروني.",
              Colors.red, "#FF0000");
          break;
      }
    } catch (e) {
      log("message: Create Account Failure");
    }
    return null;
  }

  //method for login by email and password
  Future<User?> loginWithEmailAndPassword(String email, String pass) async {
    try {
      final cred =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return cred.user;
    } catch (e) {
      log("message: login Failure${e.toString()}");
    }
    return null;
  }

  //method for logout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("message: login Failure");
    }
  }

  // Check if the user is logged in
  Future<bool> isLoggedIn() async {
    User? user = _auth.currentUser;

    return user != null;
  }
}
