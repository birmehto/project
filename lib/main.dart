import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import 'screen/main_page.dart';

class MyApp extends StatelessWidget {
  final DatabaseFactory? databaseFactory;

  const MyApp({super.key, this.databaseFactory});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(databaseFactory: databaseFactory),
    );
  }
}
