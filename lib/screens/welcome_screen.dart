import 'dart:ui';

import 'package:covidproject/providers/auth.dart';
import 'package:covidproject/screens/forgot_password.dart';
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
                padding: EdgeInsets.only(top: 50),
                width: double.infinity,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/welcome.svg",
                      height: 70,
                      width: 70,
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
    const register = Text(
      'Register',
      style: TextStyle(
        color: Colors.red,
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        prefixIcon: const Icon(Icons.email_outlined)),
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
                      border: OutlineInputBorder(
                        // borderSide: BorderSide(
                        //   color: Theme.of(context).accentColor,
                        // ),
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
                      hintStyle: TextStyle(color: Colors.black),
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(ForgotPassword.routename);
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
            color: Colors.blueAccent,
            border: Border.all(color: Colors.blue),
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
        TextButton(
          onPressed: () {},
          child: Text(
            "Dont't have an account? Register",
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
