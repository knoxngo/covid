import 'package:covidproject/providers/auth.dart';
import 'package:covidproject/screens/forgot_password.dart';
import 'package:provider/provider.dart';

import '../screens/welcome_screen.dart';

import '../products_overview_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: MaterialApp(
        title: 'My Shop House',
        theme: ThemeData(
            primaryColor: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity
            //  fontFamily: 'Lato',
            ),
        home: const WelcomeScreen(),
        routes: {
          ForgotPassword.routename: (ctx) => ForgotPassword(),
        },
      ),
    );
  }
}
