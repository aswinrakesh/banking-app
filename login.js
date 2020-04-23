var express = require('express');
var mysql = require('mysql');
var app = express();

var bodyParser = require('body-parser');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
	extended:'true'
}));

var conn = mysql.createConnection(
	{
	host:'localhost',
	user: 'root',
	password:'',
	database: 'userdb'
	}
);

conn.connect(function (err){
  if(err){
    return console.error('error:', + err.message);
  }
  console.log('Connected to the MySQL server.');

})


app.get('/:username',function(req,resp){
	conn.query('SELECT * FROM User WHERE username = ?',[req.params.username],
		function(error,rows,fields){
			if(!!error)
				console.log('Error');
			else{
				resp.json(rows);
			}
	});
})

app.post('/register',function(req,res){
  var postData=req.body;
  conn.query('INSERT INTO User SET ?',postData,function(error,rows,fields){
    if(!!error){
      console.log(error);
    }
    else{
      res.send(JSON.stringify(rows));
    }
  });
})


app.post('/loan/:username',function(req,resp){
	//console.log(req.body);
	conn.query('UPDATE User SET loan_principle = ? , loan_payable = ? WHERE username = ?',[req.body.loan_principle,req.body.loan_payable,req.params.username],
		function(error,rows,fields){
			if(!!error)
				console.log('Error');
			else{
				resp.json(rows);
			}
	});
})

app.post('/pay/:username',function(req,resp){
	//console.log(req.body);
	conn.query('UPDATE User SET loan_payable = ?, loan_paid = ? WHERE username = ?',[req.body.loan_payable,req.body.loan_paid,req.params.username],
		function(error,rows,fields){
			if(!!error)
				console.log('Error');
			else{
				resp.json(rows);
			}
	});
})

app.post('/',function(req,resp){
	console.log(req.body);
	conn.query('UPDATE User SET balance = ? WHERE username = ?',[req.body.balance,req.body.username],
		function(error,rows,fields){
			if(!!error)
				console.log('Error');
			else{
				resp.json(rows);
			}
	});
})
app.listen(4000);
