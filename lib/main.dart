import 'dart:convert';
import 'dart:async';
import 'register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'screen2.dart';
import 'login.dart';

void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banking App',
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('REGISTER'),
              onPressed: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => registerMembers(),
                  ));
                });
              },

            ),

            RaisedButton(
              child: Text('LOG IN'),
              onPressed: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => Login1(),
                  ));
                });

              },
            )
          ],
        ),
      ),
    );
  }
}