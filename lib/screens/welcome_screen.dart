import 'dart:ui';

import '../providers/auth.dart';
import '../screens/forgot_password.dart';
import '../screens/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 70),
                width: double.infinity,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/welcome.svg",
                      height: 70,
                      width: 70,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: const Text(
                        'Hello!',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Anton',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: const Text('Please log on to information'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    WelcomeCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeCard extends StatefulWidget {
  const WelcomeCard({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomeCard> createState() => _WelcomeCardState();
}

class _WelcomeCardState extends State<WelcomeCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  bool obscureText = true;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    // Log user in
    await Provider.of<Auth>(context, listen: false).login(
      _authData['email']!,
      _authData['password']!,
    );
  }

  @override
  Widget build(BuildContext context) {
    var text = RichText(
      text: const TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: "Dont't have an account?"),
          TextSpan(
            text: 'Register',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: const Color(0xff057163)),
          ),
        ],
      ),
    );
    return Column(
      children: [
        Container(
          width: 300,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'E-Mail',
                        labelStyle: TextStyle(color: const Color(0xff057163)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        )),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Color(0xff057163)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      prefixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black,
                        ),
                      ),
                      hintStyle: const TextStyle(color: Colors.black),
                    ),
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                              color: Color(0xff057163),
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ForgotPassword.routename);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: Color(0xff057163),
            border: Border.all(color: Color(0xff057163)),
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          ),
          child: TextButton(
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _submit,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Register.routename);
          },
          child: text,
        ),
      ],
    );
  }
}
