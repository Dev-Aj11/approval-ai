/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _hasCheckedAuth = false;

  @override
  Widget build(BuildContext context) {
    if (!_hasCheckedAuth) {
      final User? user = FirebaseAuth.instance.currentUser;
      _hasCheckedAuth = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (user != null && user.emailVerified) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // Navigator.pushReplacementNamed(context, '/login');
        }
      });
    }

    return Container();
  }
}
*/
/*
Intentionally simplified authgate
class AuthGate extends StatelessWidget {
   FirebaseAuth _auth = FirebaseAuth.instance;
  const AuthGate({super.key});

  Future<void> _checkEmailVerificaitonAndNavigate(context, user) async {
    await user.reload();
    final updatedUser = FirebaseAuth.instance.currentUser;
    if (updatedUser != null && !updatedUser.emailVerified) {
      print('2. navigating from authgate');
      Navigator.pushReplacementNamed(context, '/verifyemail');
    } else {
      print('inside loading home');
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    
    // listens to a stream of data and automatically rebuilds UI whenever data changes
    // auto-rebuilds when new snapshot of data is provided
    // eg: if stock price changes, streambuilder will update UI to show new price
    return StreamBuilder(
      //  most common way to check if user is currently authenticated
      // returns a stream with either the current user (signed in) or null if not
      // triggers only during account creation, sign in and sign out (not on email verifiecaiton status)
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        print("9. stream builder triggered");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        if (!snapshot.hasData) {
          // allows you to schedule a callback to be executed after the current frame is rendered.
          // run navigation after the build phase
          WidgetsBinding.instance.addPostFrameCallback((_) {
            print("inside login");
            Navigator.pushReplacementNamed(context, '/login');
          });
          // placeholder widget
          return Container();
        }
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        final User? user = snapshot.data;
        if (user != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _checkEmailVerificaitonAndNavigate(context, user);
            // Navigator.pushNamed(context, '/home');
          });
        }
        return Container();
      },
    );
  }
}
*/
