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
str = JSON.stringify
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
  details:-> @
  index: (name,settings=defaults.index_settings)->
    settings = str(settings) if settings?
    elx = @ # Maintains a reference to global class
    create:(cb)-> 
      elx.client.put("/#{name}",settings
                     ,(r)-> cb(null,r)
                     ,(r)->cb(r,null)
                    )
      @
    remove:(cb)-> 
      elx.client.del("/#{name}",""
                     ,(r)->cb(null,r)
                     ,(r)->cb(r,null)
                    )
      @
    settings:(cb)-> 
      elx.client.put("/#{name}/_settings",settings
                     ,(r)->cb(null,r)
                     ,(r)->cb(r,null)
                    )
      @
  mapping:()->
    create: ()->
    update: ()->
  find:()->
    # Find a document by its id
  insert:(o,cb)->
    # Insert a new document
    @client.post("/#{o._index}/#{o._type}/#{o._id}",str(o._source),(r)->cb(null,r),(r)->cb(r,null)); @
  update:()->
    # Update a document by its id
  delete:()->
    # Delete a document by its id
  search:()->
    # Delete a document by its id 
  bulk:()->
    # Accept a stream of JSON objects
    # They must each have an _id, index, and command
    # This will decide how elasticsearch will handle
    # The command

module.exports = Elastix