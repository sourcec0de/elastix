fs = require("fs")
Elastix = require('../lib/index.js')
# test_config = JSON.parse(fs.readFileSync("./test_config.json","utf8")) 
# elastix = new Elastix(test_config.url)
elastix = new Elastix()
log = console.log
colors = require('colors')
logjson = (j)->
  j = JSON.parse(j) if(typeof j is "string")
  j = JSON.stringify(j,null,2)
  log j

# elastix.insert({
#   "_id":1,
#   "_index":"w00t",
#   "_type":"chocolate_chip",
#   "_source":{
#     "new":1,
#     "something":2
#   }
# },(err,data)->
#   # return console.error(err) if err
#   logjson(data)
# )

elastix.find({
  "_id":2,
  "_index":"w00t",
  "_type":"chocolate_chip"
},(err,data)->
  return console.error(err.toString().red) if err
  logjson(data)
)