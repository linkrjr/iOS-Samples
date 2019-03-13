var express = require('express');
var router = express.Router();

var users = [{name: "Ronaldo", email: "ron@me.com", age: 39}, {name: "Larissa", email: "larissa@me.com", age: 31}]

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send(users);
});

router.post('/', function(req, res, next) {  
  const result = users.findIndex(user => user.email === req.params.email)
  if (result < 0) {
    users.push({
      name: req.body.name,
      email: req.body.email,
      age: Number(req.body.age)
    })
    res.send(req.body)
  } else {
    next(createError(422))
  }  
});

router.delete('/:email', function(req, res, next) {  
  const result = users.findIndex(user => user.email === req.params.email)
  var person = {}
  if (result > -1) {
    person = users[result]    
    users.splice(result, 1)  
  }  
  res.send(person)
});

module.exports = router;
