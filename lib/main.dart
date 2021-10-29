import 'package:flutter/material.dart';
//
import 'screens/home_screen.dart';
//
import 'package:flutter_application_2/firebase_auth.dart';


void main() async{
  runApp(const MyApp());

    //firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Authentication.initializeFirebase();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
