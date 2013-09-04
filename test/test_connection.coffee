Elastix = require('../lib/')
# elastix = new Elastix("http://boxwood-9174332.us-east-1.bonsai.io:80")
elastix = new Elastix()
log = console.log
logjson = (j)->
	j = JSON.parse(j) if(typeof j is "string")
	j = JSON.stringify(j,null,2)
	log j



# elastix.client.get("/", null
# , (d)->
# 	logjson(d)
# , (e)->
# 	log(e)
# )

elastix.createIndex("test",{
	"settings": {
	  "index": {
	    "number_of_shards": 2,
	    "number_of_replicas": 0,
	    "refresh_interval": 1
	  }
	}
})