import 'package:approval_ai/screens/authentication/widgets/auth_text_button.dart';
import 'package:approval_ai/widgets/custom_text_field.dart';
import 'package:approval_ai/screens/authentication/widgets/header.dart';
import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:approval_ai/controllers/auth_provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Create Header
              Expanded(
                  flex: 1,
                  child: Header(
                      label: 'Sign up to\nstart saving', newAccount: true)),
              // Create Sign Up Form
              Expanded(flex: 2, child: SignUpForm())
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode(); // FocusNode for email field
  final FocusNode _passwordFocusNode =
      FocusNode(); // FocusNode for password field
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  _emailCheck(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  _passwordCheck(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  // send this function to be executed once login btn is executed
  Future<void> _signUpWithEmailAndPwd() async {
    try {
      final userCredential = await context.read<AuthProvider>().signUp(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
      final user = userCredential.user;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        // navigate to the verify email screen
        context.push('/verifyemail');
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      // String errorMessage = '';
      // if (e.code == 'email-already-in-use') {
      //   errorMessage = 'Account already exists';
      // } else if (e.code == 'invalid-email') {
      //   errorMessage = 'Invalid email address';
      // }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.code.toString())),
      );
    }
  }

  void _onPressLoginHere() {
    context.push('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // email text field
            CustomTextField(
              label: 'Email',
              focusNode: _emailFocusNode,
              controller: _emailController,
              validator: (value) => _emailCheck(value),
            ),
            SizedBox(height: 32),
            // password text field
            CustomTextField(
              label: 'Password',
              focusNode: _passwordFocusNode,
              obscureText: true,
              controller: _passwordController,
              validator: (value) => _passwordCheck(value),
            ),
            SizedBox(height: 40),
            // sign_up_button
            PrimaryCta(
              label: "Sign Up",
              onPressCb: _signUpWithEmailAndPwd,
            ),
            SizedBox(height: 48),
            // Provide option to login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthText(label: "Already have an account?"),
                AuthTextButton(
                  onPressedCb: _onPressLoginHere,
                  label: "Log in here",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
