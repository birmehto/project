import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'home.dart';
import 'login.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, DatabaseFactory? databaseFactory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MyHomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
