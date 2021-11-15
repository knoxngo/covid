import '../providers/auth.dart';
import '../screens/home.dart';
import '../screens/forgot_password.dart';
import '../screens/link_details_screen.dart';
import '../screens/register.dart';
import '../screens/link_details_screen.dart';

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
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
                title: 'My Shop House',
                theme: ThemeData(
                  primaryColor: Colors.redAccent,
                  fontFamily: 'Lato',
                  scaffoldBackgroundColor: Colors.white,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                // home: const HomeScreen(),
                home: auth.isAuth ? const HomeScreen() : const WelcomeScreen(),
                routes: {
                  ForgotPassword.routename: (ctx) => const ForgotPassword(),
                  Register.routename: (ctx) => const Register(),
                  LinkDetailsScreen.routename: (ctx) =>
                      const LinkDetailsScreen()
                },
              )),
    );
  }
}
