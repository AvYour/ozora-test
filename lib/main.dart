import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ozora/module/landing/view/landing_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'module/home/view/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        title: 'To-Do App',
        home: FutureBuilder(
            future:
                _checkIfNameExists(), // Mengecek apakah nama ada di SharedPreferences
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final nameExists = snapshot.data ?? false;

                return nameExists ? HomeView() : LandingView();
              } else {
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
            }));
  }

  Future<bool> _checkIfNameExists() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    return name != null;
  }
}
