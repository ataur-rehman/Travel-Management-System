import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tourapp2/Screens/forget_screen.dart';
import 'package:tourapp2/Screens/splash_screen.dart';
import 'Screens/home_page.dart';
import 'Screens/introductry.dart';
import 'Screens/login_screen.dart';
import 'Screens/signup_screen.dart';
import 'api_service.dart';
import 'generated/l10n.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      title: 'Your App Title',
      localizationsDelegates: [
        S.delegate, // Ensure your delegate is added
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'), // Add other locales if necessary
      ],
      home: SplashPage(),
      routes: {
       // '/intro':(context)=>HomeScreen(apiService: ApiService()),//remove
        '/intro':(context)=>IntroductionPage(),//correct
        //'/login': (context) => HomeScreen(apiService: ApiService(),), // Define//remove
        '/login': (context) => LoginPage(),//correct
        '/forget': (context) => ForgotPasswordPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomeScreen(apiService: ApiService(),), // Define the /home route
    },
    );
  }
}

