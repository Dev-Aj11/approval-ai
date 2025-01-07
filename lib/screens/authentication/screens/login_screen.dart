import 'package:approval_ai/screens/authentication/widgets/auth_text_button.dart';
import 'package:approval_ai/widgets/custom_text_field.dart';
import 'package:approval_ai/screens/authentication/widgets/header.dart';
import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Create Header
              Expanded(flex: 1, child: Header(label: 'Log in to\nApproval AI')),
              // Create Sign Up Form
              Expanded(flex: 2, child: LoginForm())
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode(); // FocusNode for email field
  final FocusNode _passwordFocusNode = FocusNode(); // FocusNode for passwor

  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<void> _loginWithEmailAndPwd() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (!userCredential.user!.emailVerified) {
        Navigator.pushReplacementNamed(context, '/verifyemail');
      } else {
        Navigator.pushReplacementNamed(context, '/overview');
      }
    } on FirebaseAuthException catch (e) {
      // handle login errors
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      } else {
        errorMessage = 'Something went wrong: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  void _onPressForgotPwd() {
    // Navigate to forgot password screen :)
    Navigator.pushNamed(context, '/forgotpwd');
  }

  void _onPressSignup() {
    Navigator.pushNamed(context, '/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // email text field
          CustomTextField(
            label: 'Email',
            controller: _emailController,
            focusNode: _emailFocusNode,
            validator: (value) => _emailCheck(value),
          ),
          SizedBox(height: 32),
          // password text field
          CustomTextField(
            label: 'Password',
            obscureText: true,
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            validator: (value) => _passwordCheck(value),
          ),
          SizedBox(height: 40),
          // sign_up_button
          PrimaryCta(label: "Log In", onPressCb: _loginWithEmailAndPwd),
          SizedBox(height: 48),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthTextButton(
                label: "Forgot your password?",
                onPressedCb: _onPressForgotPwd,
              ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthText(label: "Don't have an account?"),
                  AuthTextButton(
                      label: "Sign up here", onPressedCb: _onPressSignup)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
