"use strict";

const  FS           = require("fs")
      ,PATH         = require("path")
      ,URL          = require("url")
      ,HTTPS        = require("https")
      ,REGEX_URL    = /\/pub[^\"]+en-GB.win64.zip/igm
      ,TEMPLATE_URL = "https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-central-l10n/"
      ,HEADERS      = {"DNT":             "1"
                      ,"Accept":          "*/*"
                      ,"Referer":         TEMPLATE_URL
                      ,"Connection":      "Close"
                      ,"User-Agent":      "Mozilla/5.0 Chrome"
                      ,"Accept-Language": "en-US,en;q=0.9"
                      ,"Cache-Control":   "no-cache"
                      ,"Pragma":          "no-cache"
                      ,"X-Hello":         "Goodbye"
                      }
      ;

function get(url, onresponse, onheaders){ //supports both headers and request body handling.
  url = URL.parse(url);
  
  const CONF = {protocol: url.protocol               // "http:"
               ,auth:     url.auth                   // "username:password"
               ,hostname: url.hostname               // "www.example.com"
               ,port:     url.port                   // 80
               ,path:     url.path                   // "/"
               ,family:   4                          // IPv4
               ,method:   "GET"
               ,headers:  HEADERS
               ,agent:    undefined                  //use http.globalAgent for this host and port.
               ,timeout:  10 * 1000                  //10 seconds
               }
       ,REQUEST = HTTPS.request(CONF)
       ,CONTENT = []
       ;
  REQUEST.setSocketKeepAlive(false);                                      //make sure to return right away (single connection mode).
  REQUEST.on("response", function(response){
    if("function" === typeof onheaders) onheaders(REQUEST,response,URL,CONTENT.join("")); //response headers.
    if("function" === typeof onresponse){
      response.setEncoding("utf8");
      response.on("data", function(chunk){ CONTENT.push(chunk);                                  } );  
      response.on("end",  function(){      onresponse(CONTENT.join(""), URL, REQUEST, response); } );  //response body.
    }
  });

  REQUEST.end();
}

console.error("getting page...")

get("https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-central-l10n/", function(content){
  const match = (content.match(/\/pub[^\"]+en-GB.win64.zip/im) || []).shift(1); //normalize result to either undefined or the URL.

  console.error("extracting URL...")

  if("string" === typeof match){
    process.exitCode=0;
    console.error("success.");
    console.log("https://ftp.mozilla.org" + match);
  }
  else{
    process.exitCode=1;
    console.error("error.");
  }

  process.exit();
});

