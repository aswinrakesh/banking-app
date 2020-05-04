import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'screen2.dart';
import 'main.dart';

void main()=>runApp(Login1());

class Login1 extends StatefulWidget {
  @override
  _LoginState1 createState() => _LoginState1();
}

class _LoginState1 extends State<Login1> {
  String username="",password="";
  var dataJson;
  TextEditingController user=TextEditingController();
  TextEditingController pass=TextEditingController();

  Future<String> getlogin(String user)async{
    final uri = "10.0.2.2:4000";
    final path = "/"+user;
    final url= Uri.http(uri,path);
    print(url);

    Response response = await http.get(url,headers: {"Accept":"application/json"});
    print(response.headers);
    setState(() {
      dataJson = json.decode(response.body);
      print(dataJson);
    });
    return " Successful";
  }

  void verifylogin(String username,String password,var data){
    //String name = data[0]['username'];
    //String bal = data[0] ['balance'];
    if(data[0]['password']==password){
      Navigator.push(context,MaterialPageRoute(
        builder: (BuildContext context) => MyApp1(text : data),
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
                setState(() {
                  verifylogin(user.text,pass.text,dataJson);
                });

              },
            )
          ],
        ),
      ),
    );
  }
}