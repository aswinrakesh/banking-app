import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'migrate.dart';
import 'screen2.dart';
import 'grp_reg.dart';
import 'addtogroup.dart';

void main()=>runApp(Group(text:null));

class Group extends StatefulWidget {
  var text;
  Group({Key key, @required this.text}) : super(key: key);
  @override
  _Group createState() => _Group();
}
var data;
class _Group extends State<Group> {
  @override
  void initState() {
    data = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 50, left: 50),
          child: Column(
            children: <Widget>[
              Text(
                "You are a group admin: " ,
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                child: Text('Group Register(Admin)'),
                onPressed: (){

                  setState(() {
                    Navigator.push(context,MaterialPageRoute(
                      builder: (BuildContext context)=>
                          GrpReg(),
                    ));
                  });



                },
              ),
              RaisedButton(child: Text('Add user to Group'),
                onPressed: (){
                  setState(() {

                    Navigator.push(context,MaterialPageRoute(
                      builder: (BuildContext context)=>
                          ATG(text: null,),
                    ));



                  });
                },),
              RaisedButton(
                child: Text('Migrate'),
                onPressed: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                      Migrate(text:data)
                    ));
                  });
                },
              )
            ],
          )
      ),
    );
  }
}