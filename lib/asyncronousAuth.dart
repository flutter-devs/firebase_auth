import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AsyncronousAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return SignInPage();
          }
          return HomePage(
            userid: user.uid,
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    Future<void> _signInAnonymously() async {
      try {
        setState(() {
          isLoading = true;
        });
        await FirebaseAuth.instance.signInAnonymously();
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : RaisedButton(
          child: Text('Sign in anonymously'),
          onPressed: _signInAnonymously,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String userid;

  HomePage({
    @required this.userid,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    Future<void> _signOut() async {
      try {
        setState(() {
          isLoading = false;
        });
        await FirebaseAuth.instance.signOut();
        setState(() {
          isLoading = true;
        });
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userid),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : RaisedButton(
          color: Colors.red,
          child: Text(
            "Log Out",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: _signOut,
        ),
      ),
    );
  }
}
