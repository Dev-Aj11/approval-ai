import 'package:approval_ai/screens/authentication/screens/forgot_pwd_screen.dart';
import 'package:approval_ai/screens/authentication/screens/reset_successful_screen.dart';
import 'package:approval_ai/screens/authentication/screens/sign_up_screen.dart';
import 'package:approval_ai/screens/authentication/screens/login_screen.dart';
import 'package:approval_ai/screens/authentication/screens/verify_email_screen.dart';
import 'package:approval_ai/screens/data_collection/screens/data_collection_screen.dart';
import 'package:approval_ai/screens/home/screens/home_screen.dart';
import 'package:approval_ai/screens/home/screens/zero_state_home_screen.dart';
import 'package:approval_ai/screens/how_it_works/screens/how_it_works.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'firebase_functions.dart';

void main() async {
  // Ensure all bindings are initialized in the same zone as runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app in the same zone
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Approval AI ',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.inter().fontFamily, // set default font
      ),
      initialRoute: '/login',
      routes: {
        // '/': (context) => const AuthGate(), // need to figure out how to work with AuthGate
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgotpwd': (context) => const ForgotPwdScreen(),
        '/resetsuccessful': (context) => const ResetSuccessfulScreen(),
        '/home': (context) => HomeScreen(),
        '/verifyemail': (context) => VerifyEmailScreen(),
        '/zerostatehome': (context) => ZeroStateHomeScreen(),
        '/datacollection': (context) => DataCollectionScreen(),
        '/howitworks': (context) => HowItWorksScreen(),
        // '/agentinteractions': (context) => AgentInteractionScreen(),
      },
    );
  }
}
