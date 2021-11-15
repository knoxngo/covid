import 'package:covidproject/providers/auth.dart';
import 'package:covidproject/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  static const routename = '/register';
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                      'REGISTER!',
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
                    child: const Text('Please enter your registration info'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const FormRegister(),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class FormRegister extends StatefulWidget {
  const FormRegister({
    Key? key,
  }) : super(key: key);

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                labelStyle: TextStyle(color: const Color(0xff057163)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty || !regExp.hasMatch(value)) {
                  return 'Invalid Email!';
                }
              },
              onSaved: (value) {
                _authData['email'] = value!;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: const Color(0xff057163)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                prefixIcon: Icon(
                  Icons.password,
                  color: Colors.black,
                ),
                suffixIcon: GestureDetector(
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              obscureText: obscureText,
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
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                labelText: 'Confirm Password',
                labelStyle: TextStyle(color: const Color(0xff057163)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              obscureText: obscureText,
              validator: (value) {
                if (value != _passwordController.text) {
                  return 'Passwords do not match!';
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 300,
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff057163),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    await Provider.of<Auth>(context, listen: false)
                        .Register(_authData['email']!, _authData['password']!);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
