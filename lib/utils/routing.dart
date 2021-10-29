import 'package:flutter/material.dart';
//
import 'package:flutter_application_2/screens/splash_screen.dart';
import 'package:flutter_application_2/screens/home_screen.dart';
import 'package:flutter_application_2/screens/login_screen.dart';
import 'package:flutter_application_2/screens/watcher_screen.dart';

Map<String, Widget Function(BuildContext)> routingMap = {
  SplashScreen.routeName: (_) => const SplashScreen(),
  LoginScreen.routeName: (_) => const LoginScreen(),
  HomeScreen.routeName: (_) => const HomeScreen(),
  WatcherScreen.routeName: (_) => const WatcherScreen()
};
