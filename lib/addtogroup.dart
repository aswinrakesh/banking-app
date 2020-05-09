import 'group_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import 'screen2.dart';
import 'grp_reg.dart';

void main()=>runApp(ATG(text:null));

class ATG extends StatefulWidget {
  var text;
  ATG({Key key, @required this.text}) : super(key: key);
  @override
  _ATG createState() => _ATG();
}
var data;
class _ATG extends State<ATG> {

  @override
  void initState() {
    data = widget.text;
    super.initState();
    getGroups();

  }
  static List<String> s=[""];
  var dataJson=[];
  var datalogin;
  String groupid = null;
  List<String> _groupid ;
  Future<String> getGroups()async{
    print(dataJson.isEmpty);

    String url = "http://10.0.2.2:4000/";
    print(url);

    Response response = await http.get(url,headers: {"Accept":"application/json"});
    print(response.headers);
    setState(() {
      dataJson = json.decode(response.body);
      print(dataJson);
      //print(dataJson.length);
      if(dataJson!=null){
        s=[dataJson[0]['group_id']];
        for(int i=1;i<dataJson.length;i++){
          if(dataJson[i]['group_id']!='0'){
            s.add(dataJson[i]['group_id']);
          }
        }s.cast<String>();
        print(s);
        _groupid=s;
        print(_groupid);
      }
    });
    return " Successful";
  }


  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  TextEditingController uname = TextEditingController();



  Future add(String user) async {
    final uri = "10.0.2.2:4000";
    final path = "/atg/"+user;
    final url= Uri.http(uri,path);

    print(url);
    Map<String, String> body = {
      "username":uname.text,
      "group_id":groupid,
    };
    var r = await http.post(url, body: body);

    if(r.statusCode == 200){
      setState(() {
      });
    }
    print(body);
    print(r.headers);
    return ;

  }

  Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
  context: context,
  builder: (BuildContext context) {
  return AlertDialog(
  content: const Text(
  'Successfully Added',
  style: TextStyle(fontWeight: FontWeight.bold),
  ),
  actions: <Widget>[
  FlatButton(
  child: Text('Ok'),
  onPressed: () {
  add(uname.text);
  Navigator.push(context,MaterialPageRoute(
  builder: (BuildContext context)=>
  Group(text: null,),
  ));
  },
  ),
  ],
  );
  },
  );
  }

  Future<String> getlogin(String user)async{
  final uri = "10.0.2.2:4000";
  final path = "/"+user;
  final url= Uri.http(uri,path);
  print(url);

  http.Response response = await http.get(url,headers: {"Accept":"application/json"});
  print(response.headers);
  setState(() {
  datalogin = json.decode(response.body);
  print(datalogin);
  });
  return " Successful";
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
  controller: uname,
  decoration: InputDecoration(
  labelText: 'Username',
  hintText: 'Enter the username to add',
  ),
  validator: (uname) {
  uname.isEmpty ? 'Please enter the username!' : null;
  },
  ),
  Container(
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(10.0)
  ),
  child: DropdownButton(value: groupid, items:_groupid
      .map((value) =>
  DropdownMenuItem(
  child: Text(value),
  value: value,
  ),).toList(),
  onChanged: (String value) {
    groupid = value;
    setState(() {
    });
  },
  hint: Text('Select the group'),
  ),
  ),

  RaisedButton(child: Text('Add'),
  onPressed: (){
  setState(() {
  if(_formKey.currentState.validate())
  {getlogin(uname.text);
  if(datalogin[0]['group_id']=='0')
    _ackAlert(context);
  else
  Navigator.push(context,MaterialPageRoute(
  builder: (BuildContext context)=>
  Group(text: null,)));
  Fluttertoast.showToast(
  msg: "${uname.text} has already been added to a group",
  textColor: Colors.white,
  toastLength: Toast.LENGTH_SHORT,
  timeInSecForIos: 1,
  gravity: ToastGravity.BOTTOM,
  backgroundColor: Colors.grey,
  );
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