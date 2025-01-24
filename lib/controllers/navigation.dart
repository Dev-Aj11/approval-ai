import 'package:approval_ai/screens/authentication/screens/forgot_pwd_screen.dart';
import 'package:approval_ai/screens/authentication/screens/login_screen.dart';
import 'package:approval_ai/screens/authentication/screens/reset_successful_screen.dart';
import 'package:approval_ai/screens/authentication/screens/sign_up_screen.dart';
import 'package:approval_ai/screens/authentication/screens/verify_email_screen.dart';
import 'package:approval_ai/screens/data_collection/screens/data_collection_screen.dart';
import 'package:approval_ai/screens/home/screens/home_screen.dart';
import 'package:approval_ai/screens/home/screens/zero_state_home_screen.dart';
import 'package:approval_ai/screens/how_it_works/screens/how_it_works.dart';
import 'package:go_router/go_router.dart';

class NavigationController {
  static getRoutes(authProvider) {
    final publicRoutes = [
      '/login',
      '/signup',
      '/forgotpwd',
      '/resetsuccessful',
      '/verifyemail',
    ];

    // this runs on every hot restart
    return GoRouter(
      initialLocation: '/login',
      // redirect will run on every context.push() or context.go() to check if redirect path is valid
      // returning null will allow the widget tree to make the decision on where to route
      redirect: (context, state) {
        // Add loading state check
        if (authProvider.isLoading) {
          // Return null to stay on current page while loading
          return null;
        }

        final isAuthenticated = authProvider.isAuthenticated;
        final isEmailVerified = authProvider.isEmailVerified;
        final isOnboardingComplete = authProvider.isOnboardingComplete;
        final existingRoutes = [
          '/login',
          '/signup',
          '/forgotpwd',
          '/resetsuccessful',
          '/verifyemail',
          '/home',
          '/zerostatehome',
          '/datacollection',
          '/howitworks'
        ];
        final isDefinedRoute = existingRoutes.contains(state.matchedLocation);
        final isPublicRoute = publicRoutes.contains(state.matchedLocation);

        // rules for authenticated & email verified users
        if (isAuthenticated && isEmailVerified) {
          // stop user from trying to access a public route or an undefined route
          if (!isDefinedRoute || isPublicRoute) {
            return (isOnboardingComplete) ? '/home' : '/zerostatehome';
          }
          // stop user from accessing /home page if user has not completed onboarding
          if (!isOnboardingComplete && state.matchedLocation == '/home') {
            return '/zerostatehome';
          }
        } else {
          // stop user from trying to access a private route
          if (!isPublicRoute || !isDefinedRoute) {
            return '/login';
          }
        }
        return null;
      },
      routes: [
        GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
        GoRoute(path: '/signup', builder: (context, state) => SignUpScreen()),
        GoRoute(
            path: '/forgotpwd', builder: (context, state) => ForgotPwdScreen()),
        GoRoute(
            path: '/resetsuccessful',
            builder: (context, state) => ResetSuccessfulScreen()),
        GoRoute(
            path: '/verifyemail',
            builder: (context, state) => VerifyEmailScreen()),
        GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
        GoRoute(
            path: '/zerostatehome',
            builder: (context, state) => ZeroStateHomeScreen()),
        GoRoute(
            path: '/datacollection',
            builder: (context, state) => DataCollectionScreen()),
        GoRoute(
            path: '/howitworks',
            builder: (context, state) => HowItWorksScreen()),
      ],
    );
  }
}
