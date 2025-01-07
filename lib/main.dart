import 'package:approval_ai/screens/authentication/screens/forgot_pwd_screen.dart';
import 'package:approval_ai/screens/authentication/screens/reset_successful_screen.dart';
import 'package:approval_ai/screens/authentication/screens/sign_up_screen.dart';
import 'package:approval_ai/screens/authentication/screens/login_screen.dart';
import 'package:approval_ai/screens/authentication/screens/verify_email_screen.dart';
import 'package:approval_ai/screens/dashboard/screens/home_screen.dart';
import 'package:approval_ai/screens/data_collection/screens/lenders_details_screen.dart';
import 'package:approval_ai/screens/data_collection/screens/loan_details_screen.dart';
import 'package:approval_ai/screens/data_collection/screens/user_details_screen.dart';
import 'package:approval_ai/screens/data_collection/screens/verification_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // tells Flutter not to start running application until Flutter framework is completely booted
  WidgetsFlutterBinding.ensureInitialized();
  // sets a connection between flutter app & firebase project
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      initialRoute: '/overview',
      routes: {
        // '/': (context) => const AuthGate(), // need to figure out how to work with AuthGate
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgotpwd': (context) => const ForgotPwdScreen(),
        '/resetsuccessful': (context) => const ResetSuccessfulScreen(),
        '/home': (context) => HomeScreen(),
        '/verifyemail': (context) => VerifyEmailScreen(),
        '/overview': (context) => UserDetailsScreen(),
        '/loandetails': (context) => LoanDetailsScreen(),
        '/lenders': (context) => LendersDetailsScreen(),
        '/verification': (context) => VerificationDetailsScreen()
      },
    );
  }
}
