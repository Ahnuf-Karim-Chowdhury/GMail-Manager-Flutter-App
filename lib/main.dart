import 'package:flutter/material.dart';
import 'package:gmail_manager/pages/auth.dart';
import 'package:gmail_manager/pages/home.dart'; // Import HomePage
import 'package:gmail_manager/pages/login.dart'; // Import LoginPage
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(onTap: (){}),
      },
    );
  }
}
