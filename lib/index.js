/**
  *
  * @ELASTIX
  * An elasticsearch tool for all your needs
  *
  **/

// Init
var url_util = require("url")
,   check = require("validator").check
,   msgs = require("../config/messages")
,   defaults = require("../config/defaults")
,   ejs = require("elastic.js")
,   nc = require('elastic.js/elastic-node-client')
,   log = console.log
,   str = JSON.stringify
;
// ======================================
var Elastix = function(url){
  var self = {
    mapping:function(){
      return {
        create:function(){},
        update:function(){}
      };
    },
    index:function(name,settings){
      return {
        create:function(){

        },
        remove:function(){

        },
        settings:function(){

        }
      }
    },
    find:function(o,cb){
      var url = self.esUrl([o._index,o._type,o._id]);
      self.client.get(
        url,
        function(r){cb(null,r)},
        function(e){cb(e,null)}
      )
    },
    insert:function(o,cb){
      var url = self.esUrl([o._index,o._type,o._id]);
      self.client.post(
        url,str(o._source),
        function(r){cb(null,r)},
        function(e){cb(e,null)}
      )
    },
    update:function(){},
    delete:function(){},
    search:function(){},
    bulk:function(){},
    details:function(){return self;},
    esUrl:function(a){return "/"+a.join("/")}
  };
  self.url = url;
  if(!url) self.url = defaults.es_url;
  check(self.url).isUrl();
  self.info = url_util.parse(self.url);
  self.ejs = ejs;
  self.ejs.client = nc.NodeClient(
    self.info.hostname,
    self.info.port,
    self.info.protocol
  );
  self.client = self.ejs.client;
  return self;
};

module.exports = Elastix;