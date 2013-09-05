###
	@ELASTIX
	An elasticsearch tool for all your needs
###

# Init
url_util = require("url")
check = require("validator").check
msgs = require("../config/messages")
defaults = require("../config/defaults")
ejs = require("elastic.js")
nc = require('elastic.js/elastic-node-client')
log = console.log
# ======================================
class Elastix
	constructor: (@url=defaults.es_url)->
		check(@url).isUrl()
		@info = url_util.parse(@url)
		@ejs = ejs
		@ejs.client = nc.NodeClient(
			@info.hostname,
			@info.port,
			@info.protocol
		)
		@client = @ejs.client
	
	# Get all methods and attrs attached to this class
	details:   -> @
	
	index: (name,settings=defaults.index_settings)->
		settings = JSON.stringify(settings) if settings?
		elx = @ # Maintains a reference to global class
		create:(esRes,esErr)-> elx.client.put("/#{name}",settings,esRes,esErr); @
		remove:(esRes,esErr)-> elx.client.del("/#{name}","",esRes,esErr); @
		settings:(esRes,esErr)-> elx.client.put("/#{name}/_settings",settings,esRes,esErr); @
	
	removeIndex: =>@
	createMapping: ()->
	removeMapping: ()->
	find: ()->
		# Find a document by its id
	insert: ()->
		# Insert a document
	update: ()->
		# Insert a document
	delete: ()->
		# Insert a document
	bulk: ()->
		# Accept a stream of JSON objects
		# They must each have an _id, index, and command
		# This will decide how elasticsearch will handle
		# The command


	# request: ejs.Request
	# request:   -> ejs


module.exports = Elastix