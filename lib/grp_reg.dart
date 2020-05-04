import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'screen2.dart';
void main()=>runApp(GrpReg(text:null));
class GrpReg extends StatefulWidget {
  var text;
  GrpReg({Key key,this.text}):super(key:key);
  @override
  _GrpRegState createState() => new _GrpRegState();
}

class _GrpRegState extends State<GrpReg> {

  @override
  void initState(){
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  String district=null;
  TextEditingController gname =TextEditingController();
  TextEditingController regno =TextEditingController();
  TextEditingController  panchayath=TextEditingController();
  TextEditingController  taluk=TextEditingController();
  TextEditingController  block=TextEditingController();
  TextEditingController  ward=TextEditingController();
  TextEditingController  gid=TextEditingController();


  final List<String> _district = [
    'Alappuzha',
    'Ernakulam',
    'Idukki',
    'Kannur',
    'Kasargod',
    'Kollam',
    'Kottayam',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Pathanamthitta',
    'Thiruvananthapuram',
    'Thrissur',
    'Wayanad'
  ];

  Future register() async{
    String url = "http://10.0.2.2:4000/grpreg";
    Map<String,String> body = {
      "group_id":gid.text,
      "group_name":gname.text,
      "group_regno":regno.text,
      "district":district,
      "taluk":taluk.text,
      "panchayath":panchayath.text,
      "block":block.text,
      "ward":ward.text
    };
    var r = await http.post(url, body: body);

    if(r.statusCode == 200){
      setState(() {
      });
    }
    print(r.headers);
    return ;

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
  register();
//  Navigator.push(context, MaterialPageRoute(
//  builder: (BuildContext context) => MyApp1(text:null),
//  ));
  },
  ),
  ],
  );
  },
  );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
      child: ListView(
        children: <Widget>[
          //GroupId
          TextFormField(
            autovalidate: true,
            controller: gid,
            decoration: InputDecoration(
              labelText: 'Group ID',
              hintText: 'Enter the Group ID',
            ),
            validator: (gid){
              gid.isEmpty?'Please enter the  Group ID!':null;
            },
          ),

          //GroupName
          TextFormField(
            autovalidate: true,
            controller: gname,
            decoration: InputDecoration(
              labelText: 'Group Name',
              hintText: 'Enter the Group Name',
            ),
            validator: (gname){
              gname.isEmpty?'Please enter the  Group Name!':null;
            },
          ),
          //RegNumber
          TextFormField(
            autovalidate: true,
            controller: regno,
            decoration: InputDecoration(
              labelText: 'Registration Number',
              hintText: 'Enter the registration number',
            ),
            validator: (regno){
              regno.isEmpty?'Please enter the registration number!':null;
            },
          ),
          //Panchayath
          TextFormField(
            autovalidate: true,
            controller: panchayath,
            decoration: InputDecoration(
              labelText: 'Panchayath/Muncipality',
              hintText: 'Enter the panchayath/muncipality',),
            validator: (panchayath){
              panchayath.isEmpty?'Please enter panchayath/muncipality! ':null;
            },
          ),
          //District
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: DropdownButton(value:district,items: _district
                .map((value)=>DropdownMenuItem(
                  child:Text(value),
                    value: value,
            ),).toList(),
                onChanged: (String value){
                  district=value;
                  setState(() {});
            },
              hint: Text('Select the district'),
                ),
          ),
          //taluk
          TextFormField(
            autovalidate: true,
            controller: taluk,
            decoration: InputDecoration(
              labelText: 'Taluk',
              hintText: 'Enter the taluk',
            ),
            validator: (taluk){
              taluk.isEmpty?'Please enter the taluk!':null;
            },
          ),
          //block
          TextFormField(
            autovalidate: true,
            controller: block,
            decoration: InputDecoration(
              labelText: 'Block',
              hintText: 'Enter the block',
            ),
            validator: (block){
              block.isEmpty?'Please enter the block!':null;
            },
          ),
          //ward
          TextFormField(
            autovalidate: true,
            controller: ward,
            decoration: InputDecoration(
              labelText: 'Ward',
              hintText: 'Enter the ward',
            ),
            validator: (ward){
              ward.isEmpty?'Please enter the ward!':null;
            },
          ),
          RaisedButton(child: Text('Register'),
          onPressed: (){
            setState(() {
              if(_formKey.currentState.validate())
                {
                  _ackAlert(context);
                }
              else {
                showInSnackBar(
                    'Please fix the errors in red before submitting.');
              }
            });
          },)
        ],
      )),
    );
  }
}
