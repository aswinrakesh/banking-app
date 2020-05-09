import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'dart:async';
import 'group_functions.dart';
void main()=>runApp(Migrate(text:null));
class Migrate extends StatefulWidget {
  var text;
  Migrate({Key key, @required this.text}) : super(key: key);
  @override
  _MigrateState createState() => _MigrateState();
}
var data;
class _MigrateState extends State<Migrate> {

  @override
  void initState() {
    data = widget.text;
    super.initState();
    getGroups();
  }

  Future mig_grp(String user)async{
    String uri="10.0.2.2:4000";
    String path = "/migrate/"+user;
    final url= Uri.http(uri,path);
    Map<String,String> body = {"username":user,"group_id":groupid};
    var r = await http.post(url,body: body);
    if(r.statusCode==200){
      setState(() {
      });
    }
    return;
  }

static List<String> s=[""];
var dataJson=[];
var datalogin;
String groupid = null;
List<String> _groupid =[] ;

Future<String> getGroups()async{
  print(dataJson.isEmpty);

  String url = "http://10.0.2.2:4000/";
  print(url);

  http.Response response = await http.get(url,headers: {"Accept":"application/json"});
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
    //getlogin(uname.text);
    //if(dataJson[0]['group_id']!=0)
   //if(iszero(uname.text)==false)
     mig_grp(uname.text);
    //else{
    //  throw 'Group not assigned';
  //}
   //else
     //print('Grps are not assigned');
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
TextEditingController uname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Form(
        key: _formKey,
          child: ListView(
              children: <Widget>[
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(value:groupid,
                    items: _groupid
                    .map((value)=>
                    DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  ),).toList(),
                      onChanged: (String value){
                        groupid=value;
                        setState(() {
                        }
                        );
                      },hint: Text('Select the group id or migration'),
                      ),
                ),
                RaisedButton(
                  child: Text('Migrate'),
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      getlogin(uname.text);
                      print(datalogin);
                      if(datalogin[0]['group_id']=='0'){
                        Navigator.push(context,MaterialPageRoute(
                        builder: (BuildContext context)=>
                        Group(text: null,),
                        ));
                        Fluttertoast.showToast(
                        msg: "${uname.text} hasn't been added to any group",
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIos: 1,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.grey,
                        );
                      }

                      else
                        _ackAlert(context);
                      }
                    else {
                      showInSnackBar(
                      'Please fix the errors in red before submitting.');
                      }
                  },
                )
        ],
      )),
    );
  }
}
