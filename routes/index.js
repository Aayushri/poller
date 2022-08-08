var express = require('express');
var request = require('request');
var bodyParser = require('body-parser');
var router = express.Router();
var db = require('../database');
var session = require('express-session');
var moment = require('moment');
var bcrypt = require('bcryptjs');
// router.use(express.static("public")); 
// router.use(express.static(__dirname + '/public'));
router.use('/public', express.static('public'));




router.use(bodyParser.urlencoded({ extended: false }));
router.use(bodyParser.json());

router.use(session({
  secret: 'XASDASDA',
  resave: true,
  saveUninitialized: true
}));

var ssn;
/* GET home page. */
router.get('/', function(req, res, next) {

  ssn = req.session; 
  if(ssn.email && ssn.adminID ) {
    res.redirect('/dashboard');
  } else {
    
    if(ssn.companyID){
      res.redirect('/company/dashboard');
    }else{
        res.render('login', { title: 'Express' });
    }
    
  }

  
});

router.get('/logout',function(req,res){
  req.session.destroy(function(err) {
    if(err) {
      console.log(err);
    } else {
      res.redirect('/');
    }
  });
});

router.post('/login',  function(req, res, next) {

    //console.log(req.body);

    let email = req.body.email;
	  let password = req.body.password;
    // console.log(email);

    let query = `SELECT * from admin where email='${email}'  limit 1`;
     db.query(query,async function (err, response) {
      console.log(response);
			if (err) {
        res.send('error');
			} else {
				if (response.length > 0) {
          
          const validPass =  await bcrypt.compare(password, response[0].password);
          ssn = req.session;
          ssn.email=req.body.email;
          ssn.adminID = response[0].id;
          
          if(validPass){
            res.send('success');
          }else{
            res.send('invalid');
          }
          
				} else {
          res.send('invalid');
				}
			}
      
		})
});
router.get('/dashboard', function(req, res, next) {
  ssn = req.session; 
  if(ssn.email && ssn.adminID ) {
    res.render('admin/dashboard', { title: 'Express' });
  }else{
    if(ssn.companyID){
      res.redirect('/company/dashboard');
    }else{
        res.render('login', { title: 'Express' });
    }
  }
});
router.get('/company', function(req, res, next) {
  ssn = req.session; 
  if(ssn.email && ssn.adminID ){
    var query = "SELECT * FROM company where is_delete= 0 ORDER BY `company`.`id` DESC";

    db.query(query, function (err, response) {
     // console.log(response);
      if (err) {
        return res.redirect('/dashboard');
      } else {
        // console.log(response);
      res.render('admin/company', { title: 'Express',records:response, moment:moment });
        
      }
      
    })
  }else{
    if(ssn.companyID){
      res.redirect('/company/dashboard');
    }else{
        res.render('login', { title: 'Express' });
    }
  }
  

  
});
router.get('/addcompany', function(req, res, next) {
  ssn = req.session; 
  if(ssn.email && ssn.adminID ){
    res.render('admin/addcompany', { title: 'Add Company' });
  }else{
    if(ssn.companyID){
      res.redirect('/company/dashboard');
    }else{
        res.render('login', { title: 'Express' });
    }
  }
});

router.post('/deleteCompany', function(req, res, next) {
  var id = req.body.id;
  var query = "UPDATE `company` SET `is_delete`='1' WHERE `id` ='"+id+ "'" ;
  db.query(query, function (err, results) {
    if(err)
    {
      res.send("error");
      //throw err;
    }
    else
    {
      res.send("success");
    }
  });
  //res.render('admin/addcompany', { title: 'Express' });
});


router.post('/checkCompany',function(req,resp){
  company_name = req.body.company_name;
  console.log(company_name);

  var sql = "SELECT id FROM company where is_delete= 0 and name='"+company_name+"'";
  console.log(sql);
  db.query(sql, function (err, results) {
    if(err)
    {
      // throw err;
      resp.send('false');
    }
    else if(results.length > 0)
    {
      // console.log(results);
      resp.send('false');
    }
    else
    {
      resp.send('true');
    }
  });

});

router.post('/checkpassword',function(req,resp){

  ssn = req.session;
  var adminID =   ssn.adminID;
  var old_password = req.body.old_password;
  var sql = "SELECT password FROM admin where  id='"+adminID+"'";
  console.log(sql);
  db.query(sql,async function (err, results) {
    if(err)
    {
      resp.send('false');
    }
    else if(results.length > 0)
    {
      
      const validPass =  await bcrypt.compare(old_password, results[0].password);
      if(validPass){
        resp.send('true');
      }else{
        resp.send('false');
      }   
      
    }
    else
    {
      resp.send('false');
    }
  });

});

router.post('/checkCompanyName',function(req,resp){
  company_name = req.body.company_name;
  company_id = req.body.company_id;
  console.log(company_name);

  var sql = "SELECT id FROM company where is_delete= 0 and name ='"+company_name+"' and id !='"+company_id+"'";
  console.log(sql);
  db.query(sql, function (err, results) {
    if(err)
    {
      // throw err;
      resp.send('false');
    }
    else if(results.length > 0)
    {
      // console.log(results);
      resp.send('false');
    }
    else
    {
      resp.send('true');
    }
  });

});


router.get("/editCompany/:id",function(req,resp){

  var id =   req.params.id;
  var sql = "SELECT * FROM company where is_delete= 0 and id='"+id+"' limit 1 "  ;
  db.query(sql, function (err, results) {
  if(err)
  {
    throw err;
  }
  else
  {
    // console.log(results);
    resp.render('admin/editcompany', { title: 'Edit Company', row : results[0] });
  }

});  

  
});


// router.post("updateCompany",function(req,resp){
//   var id = req.body.company_id;
//   var name = req.body.company_name;
//   var email = req.body.email;
//   var contact = req.body.number;
//   var address = req.body.address;
//   var date = new Date().toISOString().slice(0, 19).replace('T', ' ');

//   var query = "UPDATE `company` SET `name`='"+name+ "',`email`='"+email+ "',`contact`='"+contact+ "',`address`='"+address+ "',`update_date`='"+date+ "', WHERE `id` ='"+id+ "'" ;
//   db.query(query, function (err, results) {
//     if(err)
//     {
//       throw err;
//     }
//     else
//     {
//       resp.send('success');
//     }
//   });
// });



// router.post('/checkCompanyEmail',function(req,resp){
//   email = req.body.email;

//   var sql = "SELECT id FROM company where is_delete= 0 and email='"+email+"'";

//   db.query(sql, function (err, results) {
//     if(err)
//     {
//       throw err;
//       //resp.send('false');
//     }
//     else if(results.length > 0)
//     {
//       // console.log(results);
//       resp.send('false');
//     }
//     else
//     {
//       resp.send('true');
//     }
//   });

// })

router.post("/updateCompany",function(req,resp){
  
    var id = req.body.company_id;
    var name = req.body.company_name;
    var email = req.body.email;
    var contact = req.body.number;
    var address = req.body.address;
    var date = new Date().toISOString().slice(0, 19).replace('T', ' ');
    
    var query = "UPDATE `company` SET `name`='"+name+ "',`email`='"+email+ "',`contact`='"+contact+ "',`address`='"+address+ "',`update_date`='"+date+ "' WHERE `id` ='"+id+ "'" ;
    //console.log(query);
   db.query(query, function (err, results) {
      if(err)
      {
        throw err;
      }
      else
      {
        resp.send('success');
      }
    });
});


router.post("/addCompany",async function(req,resp){
  const salt = await bcrypt.genSalt(10);
  passwordhash = await bcrypt.hash(req.body.password, salt);
  
  var name = req.body.company_name;
  var email = req.body.email;
  var contact = req.body.number;
  var password = passwordhash;
  var address = req.body.address;
  var date = new Date().toISOString().slice(0, 19).replace('T', ' ');
  
  var sql = "Insert into company (name,email,password,contact,address,create_date) values ('"+name+ "','"+email+ "','"+password+ "','"+contact+ "','"+address+ "','"+date+ "')" ;
  db.query(sql, function (err, results) {
    if(err)
    {
        console.log(err);
    }
    else 
    {
      let threeChar =  name.substring(0,3).toUpperCase();
      let text2 = new Date().getFullYear();

      let mainId = text2+threeChar+results.insertId ;
      //.concat("", results.insertId);
      
        // console.log(results.insertId);
        var query = "UPDATE `company` SET `company_id`='"+mainId+ "' WHERE `id` ='"+results.insertId+ "'" ;
        console.log(query);
        db.query(query, function (errs, resul) {
          if(err)
          {
            resp.send('error');
          }
          else 
          {
            resp.send('success');
          }
        }); 
    }
  });

});


router.get("/changePassword",function(req,resp){
  ssn = req.session;
  var adminID =   ssn.adminID;
  if(adminID){
    resp.render('admin/changePassword', { title: 'Edit Company' });
  }
});
router.post("/Passwordchange",async function(req,resp, next){
  const obj = JSON.parse(JSON.stringify(req.body));

  const salt = await bcrypt.genSalt(10);
  var password = await bcrypt.hash(obj.new_password, salt);
  ssn = req.session;
  var adminID =   ssn.adminID;
  var query = "UPDATE `admin` SET `password`='"+password+ "' WHERE `id` ='"+adminID+ "'" ;
  db.query(query, function (err, results) {
    if(err)
    {
      throw err;
    }
    else
    {
      resp.send('success');
    }
  });
});

module.exports = router;
