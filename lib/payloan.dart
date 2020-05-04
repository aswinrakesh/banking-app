import 'dart:convert';
import 'package:flutter/material.dart';
import 'screen2.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'loan.dart';
void main()=>runApp(MyApp3(text: null,));

class MyApp3 extends StatefulWidget {
  var text;

  MyApp3({Key key, @required this.text}) : super(key: key);

  @override
  _MyApp3State createState() => _MyApp3State();
}

class _MyApp3State extends State<MyApp3> {
  double paid=0.0,week_pay=0.0, ipayable=0.0;
  var user,bal,pass;
  static var interest=0.0;
  String balance;

  @override
  void initState(){
    user = widget.text[0]['username'];
    bal =  widget.text[0]['balance'];
    pass = widget.text[0]['password'];

    super.initState();
  }
  Future payDue() async{
    var data = widget.text[0];
    String url="http://10.0.2.2:4000/"+user;
    double mon=0,payable=0,princ=0;
    print('$mon');
    print('$interest');
    var dataJson;
    var r = await http.get(url,headers: {"Accept":"application/json"});
    print(r.headers);
    setState(() {
      dataJson = json.decode(r.body);
      print(dataJson);
      if(double.parse(dataJson[0]['loan_principle'])!=0 && double.parse(dataJson[0]['loan_payable'])!=0){

        payable = double.parse(dataJson[0]['loan_payable']);
        if(ipayable==0) ipayable=payable;
        princ= double.parse(dataJson[0]['loan_principle']);
        paid = double.parse(dataJson[0]['loan_paid']);
        print('$paid');
        print('$ipayable');
        if(paid<ipayable){
          if(interest==0) interest = payable - princ;
          if(mon==0)mon = 12 * interest/(princ * 0.04);
          mon = mon.roundToDouble();
          if(week_pay==0) week_pay = payable / (4 * mon);
          paid = paid + week_pay;
          payable = payable - week_pay;
        }
        else{
          setState(() {
            Navigator.of(context).pop();

          });
        }

      }


      print('$paid');
      print('$ipayable');
      String _payable = ipayable.toString();
      String _paid = paid.toString();
      String _princ = princ.toString();
      pay(_princ,_payable,_paid);

      /*String princ= (payable - interest).toString();
    print(url);
    String _payable=payable.toString();
    String _paid = paid.toString();
    */
    });
  }

  Future pay(String p, String p1, String p2) async{

    String url="http://10.0.2.2:4000/pay/"+user;
    Map<String, String> body = {
      "username" : user,
      "password" : pass,
      "balance" : bal,
      "loan_principle": p,
      "loan_payable":p1,
      "loan_paid":p2,
    };
    String _body=json.encode(body);
    final http.Response response = await http.post(url,headers:{"Content-Type": "application/json"},body:_body,);
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Interest amounts to Rs $interest',style: TextStyle(fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Total Payment is ₹ $ipayable',style: TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Total Amount Paid is ₹ $paid',style: TextStyle(fontSize: 20),),
                ),
                Text('Weekly Payment is: ₹ $week_pay',style: TextStyle(fontSize: 15),
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
                  child: Text('Pay Weekly due.'),
                  onPressed: (){
                    setState(() {
                      payDue();
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