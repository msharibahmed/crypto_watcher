import 'package:flutter/material.dart';
//
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
//
import 'package:flutter_application_2/firebase_auth.dart';
import 'package:flutter_application_2/providers/home_provider.dart';
import 'package:flutter_application_2/providers/watcher_provider.dart';
import 'package:flutter_application_2/utils/routing.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
          ChangeNotifierProvider<WatcherProvider>(create: (_) => WatcherProvider()),
        ],
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: routingMap,
              home: Authentication.firstScreen(),
            ));
  }
}
