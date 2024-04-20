import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/home.dart';
import '../screen/login.dart';

Future<void> signup(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? userId;
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      // User created successfully, store user details in Firestore
      userId = userCredential.user!.uid;
      log('User Id : $userId');

      Get.off(() => const LoginPage());
      log('Account Created');
    } else {
      log('Account Not Created');
    }
  } on FirebaseException catch (e) {
    log(e.toString());
    Get.dialog(AlertDialog(
      content: Text(e.message.toString()),
    ));
  }
}

Future<void> login(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? userId;

  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null) {
      User? user = userCredential.user;
      userId = userCredential.user!.uid;
      log('Email : ${user?.email}');
      log(userId.toString());
      log('Loged In');
      Get.offAll(() => const MyHomePage());
    } else {
      log('Not Loged In');
    }
  } on FirebaseAuthException catch (e) {
    log(e.toString());
    Get.dialog(AlertDialog(
      content: Text(e.message.toString()),
    ));
  }
}

Future signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    log(e.toString());
  }
}

Future forgotpass(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    Get.dialog(
      AlertDialog(
        content: Text(e.message.toString()),
      ),
    );
  }
}

void showLoadingIndicator(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
