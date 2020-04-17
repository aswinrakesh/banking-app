import 'package:flutter/material.dart';
import 'main.dart';
void main()=>runApp(MyApp1());


class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text('${a.username} Loggged in'),
      )),
    );
  }
}
