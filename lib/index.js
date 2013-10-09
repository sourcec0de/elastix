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
,   request = require("request")
,   qsfy = require("querystring").stringify
;
// ======================================
var Elastix = function(url){
  var elx = {
    indicies:function(name,settings){
      return {
        create:function(){},
        destroy:function(){},
        settings:function(){},
        mapping: function() {
          return {
            create: function() {},
            update: function() {}
          };
        },
      }
    },
    document:function(io){
      var uri = "/"+io._index+"/"+io._type;
      return {
        index:function(d,cb){
          var indexURL = uri;
          if(d._id) indexURL = indexURL + "/" + d._id;
          elx.req({
            url:elx.url + indexURL,
            method:"POST",
            qs:d.params,
            json:d._source
          },cb)
        },
        get:function(id,cb){
          var getURL = uri+"/"+id;
          elx.req({
            url:elx.url + getURL,
            method:"GET"
          },cb)
        },
        update:function(id,cb){

        },
        delete:function(id,cb){

        },
        multiGet:function(o,cb){},
        bulk:function(){}
      };
    },
    search:function(o,cb){},
    req:function(o,cb){
      request(o,function(e,r,b){
        if(e){
          // an error occured
          cb(e,null);

        }else if(r && r.statusCode >= 400){
          // if statusCode isnt 200
          var error_message = new Error("Not 200 Response");
          if(b.error) error_message = new Error(str(b.error));
          if(typeof b !== "object") error_message = new Error(str(b));
          b.status = r.statusCode;
          cb(error_message,b)

        }else if(!b){
          // Missing Response Body
          cb(new Error("Missing Response Body"),null)

        }else if(b){
          // Parse 
          if(typeof b !== "object"){
            try{
              b = JSON.parse(b)
            }catch(e){
              // console.warn("Response body wasnt json")
            }
          }
          cb(null,b)
        }
      });
    }
  };
  elx.url = url;
  if(!url) elx.url = defaults.es_url;
  check(elx.url).isUrl();
  elx._parsedUrl = url_util.parse(elx.url);
  elx.ejs = ejs;
  elx.ejs.client = nc.NodeClient(
    elx._parsedUrl.hostname,
    elx._parsedUrl.port,
    elx._parsedUrl.protocol
  );
  return elx;
};

module.exports = Elastix;