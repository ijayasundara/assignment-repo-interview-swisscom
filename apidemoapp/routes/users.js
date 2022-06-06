var express = require('express');
var router = express.Router();

/* GET users listing from Mysql */
router.get('/', function(req, res, next) {
	res.locals.connection.query('SELECT * from users', function (error, results, fields) {
	  	if(error){ console.log(error);
	  		throw error;
	  		/* If there is error, Send the error in the console */
	  	} else {
  			res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  			/* If there is no error, all is good and response is 200 OK */
	  	}
  	});
});

module.exports = router;
