import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:http/http.dart';
import 'main.dart';

void main()=>runApp(registerMembers());

class registerMembers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _registerMembersState();
  }
}

class _registerMembersState extends State<registerMembers> {
  final _formKey = GlobalKey<FormState>();

  //Snackbar
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }


  String Uname;
  String pass;



  final double _minimumPadding = 4.0;

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subhead.copyWith(fontSize: 18.0);

    return Scaffold(
      key: _scaffoldKey,
//			resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Members registration'),
        titleSpacing: 0,
      ),

      body: Form(
        key: _formKey,
//        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[
//            getImageAsset(),
            //Username
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding + 4,
                    bottom: _minimumPadding,
                    left: _minimumPadding,
                    right: _minimumPadding),
                child: TextFormField(
                  autovalidate: true,
                  style: textStyle,
                  controller: nameController,
                  validator: (Uname) =>
                  Uname.isEmpty ? 'Please enter a valid name!!' : null,
                  decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter the Username',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                )),
            //Password
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding + 4,
                  bottom: _minimumPadding,
                  left: _minimumPadding,
                  right: _minimumPadding),
              child: TextFormField(
                autovalidate: true,
                style: textStyle,
                controller: passController,
                validator: (pass) =>
                pass.isEmpty ? 'Please enter a valid password!' : null,
                decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter the password',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))

                ),
                autofocus: false,
                obscureText: true,
              ),

            ),



//            //STATE
//            Padding(
//                padding: EdgeInsets.only(
//                    top: _minimumPadding,
//                    bottom: _minimumPadding,
//                    left: _minimumPadding,
//                    right: _minimumPadding),
//                child: TextFormField(
////                  keyboardType: TextInputType.number,
//                  style: textStyle,
//                  controller: stateController,
//                  decoration: InputDecoration(
//                      labelText: 'State',
//                      hintText: 'Enter your State',
//                      labelStyle: textStyle,
//                      border: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(5.0))),
//                )),

//            //Pincode
//            Padding(
//                padding: EdgeInsets.only(
//                    top: _minimumPadding,
//                    bottom: _minimumPadding,
//                    left: _minimumPadding,
//                    right: _minimumPadding),
//                child: TextFormField(
//                  keyboardType: TextInputType.number,
//                  style: textStyle,
//                  controller: pinController,
//                  decoration: InputDecoration(
//                      labelText: 'Pin Code',
//                      hintText: 'Enter Your Pin Code',
//                      labelStyle: textStyle,
//                      border: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(5.0))),
//                )),

            //Register
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding + 4, top: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                            height: 50.0,
                            child: RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(30.0)),
                              color: Theme.of(context).accentColor,
//                              textColor: Theme.of(context).primaryColorDark,
                              textColor: Colors.white,
                              child: Text(
                                'Register',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    _ackAlert(context);
                                  } else {
                                    showInSnackBar(
                                        'Please fix the errors in red before submitting.');
                                  }
                                });
                              },
                            ),
                          ),
                        ),


                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future addData() async {
    Uname = nameController.text;
    pass = passController.text;

    var url = "http://10.0.2.2:4000/register";

    Map<String,String> body = {
      "username": Uname,
      "password": pass,
    };
    Response r = await post(url, body: body);
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
//        title: Text('Confirm Register',
//            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          content: const Text(
            'Successfully Registered',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                addData();
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => MyApp(),
                ));
              },
            ),
          ],
        );
      },
    );
  }
}