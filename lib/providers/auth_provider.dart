import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseUser _user;
  AuthResult _authResult;

  FirebaseUser get user => _user;

  void init() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    _authResult = await _firebaseAuth.signInAnonymously();
    _user = _authResult.user;
  }
}