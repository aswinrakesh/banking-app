import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:convert';
import 'main.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'loan.dart';

void main()=>runApp(MyApp1());

class MyApp1 extends StatefulWidget {
   var text;
  MyApp1({Key key, @required this.text}) : super(key: key);
  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  var user, bal,data;
  @override
  void initState(){
      user = widget.text[0]['username'];
      bal =  widget.text[0]['balance'];
      data = widget.text;
      super.initState();
  }

  TextEditingController deposit=TextEditingController();
  int sum;
  Future addDeposit(String dep) async {

    String url = "http://10.0.2.2:4000/" ;
    print(url);
    sum = int.parse(bal) + int.parse(dep);
    bal=sum.toString();
    print(user);
    log("$bal");
    Map<String, String> body = {
      "username" : widget.text[0]['username'],
      "password" : widget.text[0]['password'],
      "balance" : bal,
    };
    var r = await http.post(url, body: body);

    if(r.statusCode == 200){
      setState(() {
      });
    }
    print(r.headers);
    return ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            Text(
              user + " logged in...",
              textAlign: TextAlign.center,
            ),
            Text(
              bal+" is ${user}'s current balance"
            ),
            TextField(
              controller: deposit,
              decoration: InputDecoration(
              hintText: 'Amount to deposit.',
              icon: Icon(Icons.add),
                ),
            ),
            RaisedButton(
              child: Text('Deposit'),
              onPressed: (){
                setState(() {
                  addDeposit(deposit.text);
                });

              },
            ),
            RaisedButton(
              child: Text('Return to log in'),
              onPressed: (){
                setState(() {
                  Navigator.of(context).pop();
                });
              },
            ),
            RaisedButton(
              child: Text('Loan'),
              onPressed: (){
                setState(() {
                  Navigator.push(context,MaterialPageRoute(
                    builder: (BuildContext context) => MyApp2(text:data),
                  )
                  );
                });
              },
            )
          ],
        )
      ),
    );
  }
}
