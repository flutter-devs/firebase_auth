import 'package:firebaseauth/emailPassword.dart';
import 'package:firebaseauth/googleSignIn.dart';
import 'package:flutter/material.dart';
import 'asyncronousAuth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Authenticaiton"),
        ),
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: ListTile(
                title: Text(list[index].title),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return list[index].authWidget;
                  }));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

List<Tile> list = [
  Tile(title: "Asyncronous Auth", authWidget: AsyncronousAuth()),
  Tile(title: "Email and password", authWidget: EmailPasswordAuth()),
  Tile(title: "Google Auth", authWidget: GoogleAuth()),
];

class Tile {
  String title;
  Widget authWidget;

  Tile({
    @required this.title,
    @required this.authWidget,
  });
}
