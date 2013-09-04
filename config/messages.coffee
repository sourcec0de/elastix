###
MESSAGES
###

module.exports =
	bad_connection_details:"""
	Connection(@details) must be an Object or properly
	formatted URL.
	"""
	missing_index_name:"""
	elastix.createIndex(@name,@settings)
	@name is a required string
	@settings is optional JSON object
	"""