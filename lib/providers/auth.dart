import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  Future<void> SignUp() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: 'xx', password: 'xx');
    } on FirebaseAuthException catch (error) {
      rethrow;
    }
  }
}
