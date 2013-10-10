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
  bad_id_param:"""
  _id was missing or null
  """
  bad_source_param:"""
  _source was missing or null
  """