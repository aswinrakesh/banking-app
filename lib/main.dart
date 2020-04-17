import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screen2.dart';

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
  String username="",password="";
  var dataJson;
  TextEditingController user=TextEditingController();
  TextEditingController pass=TextEditingController();

  Future<String> getlogin(String user)async{
    var url="http://10.0.2.2:4000/"+user;
    http.Response response = await http.get(Uri.encodeFull(url),headers: {"Accept":"application/json"});
    setState(() {
      dataJson = json.decode(response.body);
      print(dataJson);
    });
  }

  verifylogin(String username,String password,var data){
    if(data[0]['password']==password){
      Navigator.push(context,MaterialPageRoute(
        builder: (BuildContext context) => MyApp1(),
      )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              controller: user,
              decoration: InputDecoration(
                hintText: 'Username',
                icon: Icon(Icons.person),
              ),
            ),
            TextField(
              controller: pass,
              decoration: InputDecoration(
                hintText: 'Password',
                icon: Icon(Icons.lock)
              ),
              autofocus: false,
              obscureText: true,
            ),
            RaisedButton(
              child: Text('SIGN IN'),
              onPressed: (){
                getlogin(user.text);
                verifylogin(user.text,pass.text,dataJson);
              },
            )
          ],
        ),
      ),
    );
  }
}

