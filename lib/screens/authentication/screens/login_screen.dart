import 'package:approval_ai/screens/authentication/widgets/auth_text_button.dart';
import 'package:approval_ai/widgets/custom_text_field.dart';
import 'package:approval_ai/screens/authentication/widgets/header.dart';
import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:approval_ai/controllers/auth_provider.dart';

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
    print("from login screen:login with email and pwd running");
    try {
      final firebase_auth.UserCredential userCredential = await context
          .read<AuthProvider>()
          .login(_emailController.text.trim(), _passwordController.text.trim());
      print("from login screen: login with email and pwd finished");
      if (!mounted) return;

      if (!userCredential.user!.emailVerified) {
        context.push('/verifyemail');
        return;
      }

      final bool isOnboardingComplete =
          await context.read<AuthProvider>().fetchOnboardingStatus();
      print("from login screen: fetching onboarding status finished");
      if (!mounted) return;
      print("from login screen: isOnboardingComplete: $isOnboardingComplete");
      if (isOnboardingComplete) {
        context.go('/home');
      } else {
        print("from login screen: i'm trying to push zero state home\n");
        context.go('/zerostatehome');
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
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
    context.go('/forgotpwd');
  }

  void _onPressSignup() {
    context.go('/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: SizedBox(
        width: 500,
        child: Form(
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
        ),
      ),
    );
  }
}
