var express = require('express');
var mysql = require('mysql');
var app = express();
//var multer=require('multer');
//var fs = require('fs');
// var storage = multer.diskStorage({
// 	destination:function(req,file,cb){
// 		cb(null,'./uploads/');
// 	},
// 	filename:function(req,file,cb){
// 		cb(null,Date.now() + file.originalname);
// 	}
// });
//var upload = multer({storage:storage});
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

// app.get('/image/:username',function(req,resp){
// 	conn.query('SELECT img from User WHERE username =?',[req.params.username],
// 		function(error,rows,fields){
// 			if(!!error){
// 				console.log('Error');
// 			}
// 			else{
// 				resp.json(rows);
// 			}
// 	}),

// })


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

app.post('/grpreg',function(req,res){
  var postData=req.body;
  conn.query('INSERT INTO group_reg SET ?',postData,function(error,rows,fields){
    if(!!error){
      console.log(error);
    }
    else{
      res.send(JSON.stringify(rows));
    }
  });
})

// var image = {
// 	img: fs.readFileSync("/opt/lampp/htdocs/events/uploads/liverpool.jpg",{encoding:'utf8', flag:'r'},
// 	file_name ='Livpool'	
// )};


// app.post('/upload',upload.single('picture'),function(req,res){
// 	if(!req.file){
// 		console.log('No FIle Received');
// 	}
// 	else{
// 		console.log(req.file);
// 		console.log('File Received');
// 		conn.query('INSERT INTO User SET ?',req,function(err,res){
// 	 	console.log(res);
// 	 });
// 	}
// });

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