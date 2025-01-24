import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:flutter/material.dart';
import 'package:approval_ai/widgets/custom_text_field.dart';
import 'package:approval_ai/screens/authentication/widgets/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class ForgotPwdScreen extends StatelessWidget {
  const ForgotPwdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Header(
                label: 'Reset your password',
                subheading:
                    "Enter the email address linked to your account and we'll send you an email.",
              ),
            ),
            Expanded(flex: 2, child: ForgotPwdForm())
          ],
        ),
      ),
    );
  }
}

class ForgotPwdForm extends StatefulWidget {
  const ForgotPwdForm({super.key});

  @override
  State<ForgotPwdForm> createState() => _ForgotPwdFormState();
}

class _ForgotPwdFormState extends State<ForgotPwdForm> {
  final _emailController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  _emailCheck(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  Future<void> _onPressForgotPwd() async {
    final String email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email')),
      );
      return;
    }
    try {
      print("sending password reset email to $email");
      await _auth.sendPasswordResetEmail(email: email);
      print("sent password reset email to $email");
      // show confirmation screen
      context.push('/resetsuccessful');
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address.';
      } else {
        errorMessage = 'Something went wrong. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SizedBox(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // email text field
            CustomTextField(
              label: 'Email',
              focusNode: _focusNode,
              controller: _emailController,
              validator: (value) => _emailCheck(value),
            ),
            SizedBox(height: 40),
            PrimaryCta(
              label: "Send link",
              onPressCb: _onPressForgotPwd,
            ),
          ],
        ),
      ),
    );
  }
}
