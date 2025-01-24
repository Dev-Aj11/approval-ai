import 'package:approval_ai/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isOnboardingComplete = false;
  bool _isLoading = true;
  bool _isEmailVerified = false;

  AuthProvider() {
    // Listen to auth state changes
    // on every hot restart this constructor is called
    // firebase auth is persisted because it is in disk storeage whereas values of
    // all other local variables are not persisted.
    _auth.authStateChanges().listen((User? user) async {
      _user = user;
      if (_user != null) {
        await fetchOnboardingStatus();
        if (_user!.emailVerified) {
          _isEmailVerified = true;
        }
      } else {
        _isOnboardingComplete = false;
        _isEmailVerified = false;
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  bool get isAuthenticated =>
      _user != null; // is true if user signs up or logs in for the first time
  bool get isOnboardingComplete => _isOnboardingComplete;
  bool get isLoading => _isLoading;
  bool get isEmailVerified => _isEmailVerified;
  User? get user => _user;

  void setOnboardingComplete(bool value) {
    _isOnboardingComplete = value;
    notifyListeners();
  }

  // login with email and password
  Future<UserCredential> login(String email, String password) async {
    try {
      // check if user is already authenticated
      if (_user != null) {
        // get fresh instance of user from firebase (for eg: if user is signed up but email is not verified)
        await _user!.reload();
        _user = _auth.currentUser; // update local user state

        // check if user has completed onboarding & update local state
        await fetchOnboardingStatus();
        if (_user!.emailVerified) {
          _isEmailVerified = true;
        }
      } else {
        print("from auth provider: user is not already authenticated");
      }

      // if user is not authenticated, login with email and password
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("from auth provider: Login with email and pwd ${_user?.email}");
      // await _fetchOnboardingStatus();
      return userCredential;
    } catch (e) {
      print("from auth provider: login with email and pwd error: $e");
      rethrow;
    }
  }

  Future<UserCredential> signUp(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> fetchOnboardingStatus() async {
    try {
      final documentSnapshot = await FirebaseFunctions.getUserData();
      _isOnboardingComplete = documentSnapshot.data() != null;
    } catch (e) {
      print('Error fetching onboarding status: $e');
      _isOnboardingComplete = false;
    }
    return _isOnboardingComplete;
  }

  Future<void> logout() async {
    try {
      // this triggers the auth state changes listener in the
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
