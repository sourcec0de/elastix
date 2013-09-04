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
		# elx = @ # Maintains a reference to global class
	details:   -> @
	createIndex: (name,settings)->
		check(name,msgs.missing_index_name).notNull()
		throw new Error(msgs.not_json_object) if(settings and !(settings instanceof Object))
	removeIndex: ()->
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