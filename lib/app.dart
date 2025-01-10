import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/authenticate_screen.dart';
import 'screens/chat_bot.dart';
import 'screens/emolyzer_screen.dart';
import 'screens/patient_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/remote_auth.dart';
import 'widget/bottom_navbar.dart';
import './screens/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MaterialApp(
      theme: ThemeData.light(),
      home: _user != null ? BottomNavBar() : const LandingScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/landing': (context) =>
            _user != null ? BottomNavBar() : const LandingScreen(),
        '/home': (context) => BottomNavBar(),
        '/signin': (context) =>
            _user != null ? BottomNavBar() : const Authenticate(),
        '/panel2': (context) => const PatientEmotionScreen(),
        '/panel6': (context) => ProfileScreen(_user),
        '/patient': (context) => const PatientDetailsScreen(),
        '/remote': (context) => const RemoteAuth(),
      },
    );
  }
}
