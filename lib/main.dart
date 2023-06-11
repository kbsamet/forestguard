import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:forestguard/screens/home_screen.dart';
import 'package:forestguard/screens/login_screen.dart';
import 'package:forestguard/util/api.dart';
import 'package:http/http.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  checkAuth() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    String? auth = await storage.read(key: "auth");
    if (auth != null) {
      Response resp = await sendGetRequest("sensor/findLatestSensorData", null);
      if (resp.statusCode == 200) {
        setState(() {
          isLoggedIn = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ForestGuard',
        theme: ThemeData(
          fontFamily: "Poppins",
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
        ),
        home: isLoggedIn ? const HomeScreen() : const LoginScreen());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
