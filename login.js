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

app.get('/:username',function(req,resp){
	conn.query("SELECT * FROM User WHERE username = ?",[req.params.username],
		function(error,rows,fields){	
			if(!!error)
				console.log('Error');
			else{
				resp.send(rows);
			}		
	});		
})

app.listen(4000);