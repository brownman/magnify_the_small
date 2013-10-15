(function () {

/* Imports */
var Meteor = Package.meteor.Meteor;
var WebApp = Package.webapp.WebApp;
var main = Package.webapp.main;
var WebAppInternals = Package.webapp.WebAppInternals;
var _ = Package.underscore._;

/* Package-scope variables */
var Spiderable;

(function () {

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                 //
// packages/spiderable/spiderable.js                                                                               //
//                                                                                                                 //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                   //
var fs = Npm.require('fs');                                                                                        // 1
var child_process = Npm.require('child_process');                                                                  // 2
var querystring = Npm.require('querystring');                                                                      // 3
var urlParser = Npm.require('url');                                                                                // 4
                                                                                                                   // 5
Spiderable = {};                                                                                                   // 6
                                                                                                                   // 7
// list of bot user agents that we want to serve statically, but do                                                // 8
// not obey the _escaped_fragment_ protocol. The page is served                                                    // 9
// statically to any client whos user agent matches any of these                                                   // 10
// regexps. Users may modify this array.                                                                           // 11
//                                                                                                                 // 12
// An original goal with the spiderable package was to avoid doing                                                 // 13
// user-agent based tests. But the reality is not enough bots support                                              // 14
// the _escaped_fragment_ protocol, so we need to hardcode a list                                                  // 15
// here. I shed a silent tear.                                                                                     // 16
Spiderable.userAgentRegExps = [                                                                                    // 17
    /^facebookexternalhit/i, /^linkedinbot/i, /^twitterbot/i];                                                     // 18
                                                                                                                   // 19
// how long to let phantomjs run before we kill it                                                                 // 20
var REQUEST_TIMEOUT = 15*1000;                                                                                     // 21
                                                                                                                   // 22
WebApp.connectHandlers.use(function (req, res, next) {                                                             // 23
  if (/\?.*_escaped_fragment_=/.test(req.url) ||                                                                   // 24
      _.any(Spiderable.userAgentRegExps, function (re) {                                                           // 25
        return re.test(req.headers['user-agent']); })) {                                                           // 26
                                                                                                                   // 27
    // reassembling url without escaped fragment if exists                                                         // 28
    var parsedUrl = urlParser.parse(req.url);                                                                      // 29
    var parsedQuery = querystring.parse(parsedUrl.query);                                                          // 30
    delete parsedQuery['_escaped_fragment_'];                                                                      // 31
    var newQuery = querystring.stringify(parsedQuery);                                                             // 32
    var newPath = parsedUrl.pathname + (newQuery ? ('?' + newQuery) : '');                                         // 33
    var url = "http://" + req.headers.host + newPath;                                                              // 34
                                                                                                                   // 35
    // This string is going to be put into a bash script, so it's important                                        // 36
    // that 'url' (which comes from the network) can neither exploit phantomjs                                     // 37
    // or the bash script. JSON stringification should prevent it from                                             // 38
    // exploiting phantomjs, and since the output of JSON.stringify shouldn't                                      // 39
    // be able to contain newlines, it should be unable to exploit bash as                                         // 40
    // well.                                                                                                       // 41
    var phantomScript = "var url = " + JSON.stringify(url) + ";" +                                                 // 42
          "var page = require('webpage').create();" +                                                              // 43
          "page.open(url);" +                                                                                      // 44
          "setInterval(function() {" +                                                                             // 45
          "  var ready = page.evaluate(function () {" +                                                            // 46
          "    if (typeof Meteor !== 'undefined' " +                                                               // 47
          "        && typeof(Meteor.status) !== 'undefined' " +                                                    // 48
          "        && Meteor.status().connected) {" +                                                              // 49
          "      Deps.flush();" +                                                                                  // 50
          "      return DDP._allSubscriptionsReady();" +                                                           // 51
          "    }" +                                                                                                // 52
          "    return false;" +                                                                                    // 53
          "  });" +                                                                                                // 54
          "  if (ready) {" +                                                                                       // 55
          "    var out = page.content;" +                                                                          // 56
          "    out = out.replace(/<script[^>]+>(.|\\n|\\r)*?<\\/script\\s*>/ig, '');" +                            // 57
          "    out = out.replace('<meta name=\"fragment\" content=\"!\">', '');" +                                 // 58
          "    console.log(out);" +                                                                                // 59
          "    phantom.exit();" +                                                                                  // 60
          "  }" +                                                                                                  // 61
          "}, 100);\n";                                                                                            // 62
                                                                                                                   // 63
    // Run phantomjs.                                                                                              // 64
    //                                                                                                             // 65
    // Use '/dev/stdin' to avoid writing to a temporary file. We can't                                             // 66
    // just omit the file, as PhantomJS takes that to mean 'use a                                                  // 67
    // REPL' and exits as soon as stdin closes.                                                                    // 68
    //                                                                                                             // 69
    // However, Node 0.8 broke the ability to open /dev/stdin in the                                               // 70
    // subprocess, so we can't just write our string to the process's stdin                                        // 71
    // directly; see https://gist.github.com/3751746 for the gory details. We                                      // 72
    // work around this with a bash heredoc. (We previous used a "cat |"                                           // 73
    // instead, but that meant we couldn't use exec and had to manage several                                      // 74
    // processes.)                                                                                                 // 75
    child_process.execFile(                                                                                        // 76
      '/bin/bash',                                                                                                 // 77
      ['-c',                                                                                                       // 78
       ("exec phantomjs --load-images=no /dev/stdin <<'END'\n" +                                                   // 79
        phantomScript + "END\n")],                                                                                 // 80
      {timeout: REQUEST_TIMEOUT},                                                                                  // 81
      function (error, stdout, stderr) {                                                                           // 82
        if (!error && /<html/i.test(stdout)) {                                                                     // 83
          res.writeHead(200, {'Content-Type': 'text/html; charset=UTF-8'});                                        // 84
          res.end(stdout);                                                                                         // 85
        } else {                                                                                                   // 86
          // phantomjs failed. Don't send the error, instead send the                                              // 87
          // normal page.                                                                                          // 88
          if (error && error.code === 127)                                                                         // 89
            Meteor._debug("spiderable: phantomjs not installed. Download and install from http://phantomjs.org/"); // 90
          else                                                                                                     // 91
            Meteor._debug("spiderable: phantomjs failed:", error, "\nstderr:", stderr);                            // 92
                                                                                                                   // 93
          next();                                                                                                  // 94
        }                                                                                                          // 95
      });                                                                                                          // 96
  } else {                                                                                                         // 97
    next();                                                                                                        // 98
  }                                                                                                                // 99
});                                                                                                                // 100
                                                                                                                   // 101
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);


/* Exports */
if (typeof Package === 'undefined') Package = {};
Package.spiderable = {
  Spiderable: Spiderable
};

})();
