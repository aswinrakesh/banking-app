import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'loan.dart';
import 'payloan.dart';
import 'dart:convert';
import 'grp_reg.dart';


void main()=>runApp(MyApp1(text: null,));

class MyApp1 extends StatefulWidget {
  var text;
  MyApp1({Key key, @required this.text}) : super(key: key);
  String url_="http://10.0.2.2:4000/upload";
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

  /*Future getImage(var user)async{
    String url = "http://10.0.2.2:4000/image/"+user;
    var image = http.get(url,headers:{"Accept":"application/json"});
    String base64image;
    List<int> imagebytes = image.readAsBytesSync();
    base64image = base64Encode(imagebytes);

  }

  Future <String> uploadImg(filename, url) async{
    var request = http.MultipartRequest('POST',Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }*/
  String state = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Text(
                user + " logged in...url",
                textAlign: TextAlign.center,
              ),
              Text(bal + "is ${user}'s current balance"),
              TextField(
                controller: deposit,
                decoration: InputDecoration(
                  hintText: 'Amount to deposit.',
                  icon: Icon(Icons.add),
                ),
              ),
             /* CircleAvatar(
                backgroundImage: getImage(user),
              ),*/
              RaisedButton(
                child: Text('Deposit'),
                onPressed: (){
                  setState(() {
                    addDeposit(deposit.text);
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
              ),
              RaisedButton(
                child: Text('Group Register(Admin)'),
                onPressed: (){
                  if(user=='adithya'){
                    setState(() {
                      Navigator.push(context,MaterialPageRoute(
                          builder: (BuildContext context)=>
                          GrpReg(text:data)
                      ));
                    });
                  }
                  else{
                    print(user);
                  }

                },
              ),
              RaisedButton(
                child: Text('Pay Due'),
                onPressed: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyApp3(text:data),
                    )
                    );
                  });
                },
              ),
             /* RaisedButton(child: Text('Upload image'),
              onPressed: ()async{
                var file = await ImagePicker.pickImage(source: ImageSource.gallery);
                var res = await uploadImg(file.path,widget.url_);
                setState(() {
                  state=res;
                });
              },
              ),*/
              RaisedButton(
                child: Text('Log out'),
                onPressed: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>MyApp()));
                  });
                },
              ),
            ],
          )
      ),
    );
  }
}