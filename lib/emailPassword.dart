import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class EmailPasswordAuth extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EmailPasswordAuthState();
}

class EmailPasswordAuthState extends State<EmailPasswordAuth> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: const Text('Test sign in with email and password'),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Plea se enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Text("SignUp"),
                      onPressed: () {
                        _signUpWithEmailAndPassword();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: 100,
                ),
                RaisedButton(
                  onPressed: () async {
                    _signInWithEmailAndPassword();
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _success == null
                    ? ''
                    : (_success
                        ? 'Successfully signed in ' + _userEmail
                        : 'Sign in failed'),
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code of how to sign in with email and password.
  void _signInWithEmailAndPassword() async {
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )) as FirebaseUser;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      _success = false;
    }
  }

  void _signUpWithEmailAndPassword() async {
    try {
      FirebaseUser user = _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text) as FirebaseUser;
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(signUpError.code),
              );
            });
      }
    }
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
