import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetfinal/pages/login_or_register_page.dart';
import 'package:projetfinal/pages/login_page.dart';
import 'package:projetfinal/pages/homePage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // user is connected
            if (snapshot.hasData) {
              return Homepage();
            } else {
              return LoginOrRegisterPage();
            }
          }),
    );
  }
}
