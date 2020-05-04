import 'dart:convert';
import 'package:flutter/material.dart';
import 'screen2.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
void main()=>runApp(MyApp2(text: null,));


class MyApp2 extends StatefulWidget {
  var text;
  MyApp2({Key key, @required this.text}) : super(key: key);  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  var user,bal,pass;
  double payable,interest,week_pay;
  String u_name,p_word,balance;
  @override
  void initState(){
    user = widget.text[0]['username'];
    bal =  widget.text[0]['balance'];
    pass = widget.text[0]['password'];

    super.initState();
  }
  TextEditingController principle=TextEditingController();
  TextEditingController months=TextEditingController();

  Future addLoan(String princ) async{
    String url="http://10.0.2.2:4000/loan/"+user;
    print(url);
    //String url1="https://10.2.2.2:4000/"+user;
    interest = double.parse(princ) *.04* double.parse(months.text)/12;
    payable = interest+double.parse(princ);

    week_pay=(payable/(double.parse(months.text)*4));
    String _payable=payable.toString();
    String _week_pay = week_pay.toString();

//    http.Response response = await http.get(url1,headers: {"Accept":"application/json"});
//    var user_json=json.decode(response.body);
//    u_name=user_json[0]['username'];
//    p_word=user_json[0]['password'];
//    balance=user_json[0]['balance'];

    print(_payable);
    Map<String, String> body = {
      "username" : user,
      "password" : pass,
      "balance" : bal,
      "loan_principle":princ,
      "loan_payable":_payable,
    };
    String _body=json.encode(body);
    final http.Response response = await http.post(url,headers:{"Content-Type": "application/json"},body:_body,);
    //var r = await http.post(url, body: body);
    if(response.statusCode == 200){
      setState(() {
      });
    }
    print(response.headers);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(

          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                      hintText: 'Enter the time period needed(in months)',
                      icon: Icon(Icons.access_time)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Total Payment is ₹ ${payable}',style: TextStyle(fontSize: 20),),
                ),
                Text('Weekly Payment is: ₹ ${week_pay}',style: TextStyle(fontSize: 15),
                ),
                RaisedButton(
                  child: Text('BACK'),
                  onPressed: (){
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                ),
                RaisedButton(
                  child: Text('Take Loan'),
                  onPressed: (){
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Text('Total Payment is ₹ ${payable}',style: TextStyle(fontSize: 20),),
//                    );
//                    Text('Weekly Payment is: ₹ ${week_pay}',style: TextStyle(fontSize: 15),
//                    );
                    setState(() {
                      addLoan(principle.text);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



