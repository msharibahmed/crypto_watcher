import 'package:flutter/material.dart';
//
import 'package:flutter_application_2/widgets/google_signin_btn.dart';
//
import '../firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  final isSubmitting = true;

  @override
  Widget build(BuildContext context) {
    final _mq = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(
            left: _mq.width * 0.070,
            right: _mq.width * 0.10,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 240),
                const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w100),
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                    future: Authentication.initializeFirebase(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Error initializing Firebase');
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return const GoogleSignInButton();
                      }
                      return const CircularProgressIndicator(
                        color: Colors.orange,
                      );
                    })
              ])),
    ));
  }
}
