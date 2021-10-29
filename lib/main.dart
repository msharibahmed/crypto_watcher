import 'package:flutter/material.dart';
//
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
//
import 'package:flutter_application_2/firebase_auth.dart';
import 'package:flutter_application_2/utils/routing.dart';

void main() async {
  //for transparent status bar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.indigo,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent));

  //firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routingMap,
      home: Authentication.firstScreen(),
    );
  }
}
