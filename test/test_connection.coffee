fs = require("fs")
log = console.log
colors = require('colors')
logjson = (j,color="green")->
  j = JSON.parse(j) if(typeof j is "string")
  j = JSON.stringify(j,null,2)
  log j[color]
Elastix = require('../lib/index.js')
elx = new Elastix()
# test_config = JSON.parse(fs.readFileSync("./test_config.json","utf8")) 
# elx = new Elastix(test_config.url)

location = {
  _index:"nixProductionV10",
  _type:"test"
}


# indexes a document into the given location
elx.document(location)
.index({
  # Set your own ID
  # _id:"51c3c1ed97c3e6d8d3b49b5a",
  # params to pass to ES
  # params:{
  #   # check version before saving
  #   version:6
  # },
  # Set the document to be indexed
  _source:{
    something:1,
    new:2
  }
},(err,data)->
  log(err.message.red) if err
  logjson(data)
)

# Returns a document by its id
elx.document(location)
.get("51c3c1ed97c3e6d8d3b49b5a",(err,data)->
  return log(err,"red") if err
  logjson(data)
)