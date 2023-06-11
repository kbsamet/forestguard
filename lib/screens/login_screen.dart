import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:forestguard/components/text_field.dart';
import 'package:forestguard/screens/home_screen.dart';
import 'package:forestguard/util/api.dart';
import 'package:forestguard/util/consts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    var res = await sendAuthorizationRequest(
        nameController.text, passwordController.text);
    print(res.statusCode);
    if (res.statusCode == 200) {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      await storage.write(key: "auth", value: res.body);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: darkGreen,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "ForestGuard",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            DefaultTextField(
                controller: nameController,
                text: "Kullanıcı Adı",
                icon: Icons.person),
            const SizedBox(height: 20),
            DefaultTextField(
                controller: passwordController,
                text: "Şifre",
                icon: Icons.lock,
                isSecret: true),
            const SizedBox(height: 20),
            InkWell(
              onTap: login,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: lightGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 56,
                child: const Center(child: Text("Giriş Yap")),
              ),
            )
          ]),
    ));
  }
}
