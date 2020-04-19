import 'dart:convert';
import 'package:flutter/material.dart';
import 'screen2.dart';
import 'package:http/http.dart' as http;
void main()=>runApp(MyApp2());


class MyApp2 extends StatefulWidget {
  var text;
  MyApp2({Key key, @required this.text}) : super(key: key);  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  String user;
  double payable,interest;
  String u_name,p_word,balance;
  @override
  void initState(){
    user=widget.text;
    super.initState();
  }

  TextEditingController principle=TextEditingController();
  TextEditingController months=TextEditingController();

  Future addLoan(String princ) async{
    String url="https://10.2.2.2:4000/loan/"+user;
    String url1="https://10.2.2.2:4000/"+user;
    interest = double.parse(princ) *.04* double.parse(months.text);
    payable = interest+double.parse(princ);
    String _payable=payable.toString();
    http.Response response = await http.get(url1,headers: {"Accept":"application/json"});
    var user_json=json.decode(response.body);
    u_name=user_json[0]['username'];
    p_word=user_json[0]['password'];
    balance=user_json[0]['balance'];

    print(user_json);
    Map<String, String> body = {
      "username" : u_name,
      "password" : p_word,
      "balance" : balance,
      "loan_principle":princ,
      "loan_payable":_payable,
    };
    var r = http.post(url, body: body).then(null);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(

          child: Column(
            children: <Widget>[
              Text('Interest Rate: 4% p.a',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              //Principle
              TextField(
                controller:principle ,
                decoration: InputDecoration(
                    hintText: 'Enter the principle amount',
                    icon: Icon(Icons.attach_money)
                ),
              ),
              TextField(
                controller:months ,
                decoration: InputDecoration(
                    hintText: 'Enter the time period needed',
                    icon: Icon(Icons.access_time)
                ),
              ),
              RaisedButton(
                child: Text('Take Loan'),
                onPressed: (){
                  setState(() {
                    addLoan(principle.text);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}



