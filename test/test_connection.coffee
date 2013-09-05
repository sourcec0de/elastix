Elastix = require('../lib/')
# elastix = new Elastix("http://boxwood-9174332.us-east-1.bonsai.io:80")
elastix = new Elastix()
log = console.log
colors = require('colors')
logjson = (j)->
	j = JSON.parse(j) if(typeof j is "string")
	j = JSON.stringify(j,null,2)
	log j


# log elastix.client
# elastix.client.put("/test", "{}"
# , (d)->
# 	logjson(d)
# , (e)->
# 	log(e)
# )


settings = {
  "settings": {
    "index": {
      # "number_of_shards": 3,
      "number_of_replicas": 0,
      "refresh_interval": 1
    }
  }
};

# elastix.createIndex("test"
#   ,settings
#   ,(esRes)->
#     throw new Error(esRes.error) if esRes.error
#     console.log(esRes)
#   ,(esErr)->
#     console.error(esErr)
# )

# elastix.index("cookies")
esRes = (d)->
  throw new Error(d.error.red) if d.error
  console.log(d)

esErr = (e)->
  throw new Error(e)

index = elastix.index("cookies",settings)
               .remove(esRes,esErr)
               # .create(esRes,esErr)
               .create(esRes,esErr)
               .settings(esRes,esErr)

# log elastix.details()