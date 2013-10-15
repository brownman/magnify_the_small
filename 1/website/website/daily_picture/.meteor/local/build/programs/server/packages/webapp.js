(function () {

/* Imports */
var Meteor = Package.meteor.Meteor;
var Log = Package.logging.Log;
var _ = Package.underscore._;
var RoutePolicy = Package.routepolicy.RoutePolicy;

/* Package-scope variables */
var WebApp, main, WebAppInternals;

(function () {

/////////////////////////////////////////////////////////////////////////////////////////
//                                                                                     //
// packages/webapp/webapp_server.js                                                    //
//                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////
                                                                                       //
////////// Requires //////////                                                         // 1
                                                                                       // 2
var fs = Npm.require("fs");                                                            // 3
var http = Npm.require("http");                                                        // 4
var os = Npm.require("os");                                                            // 5
var path = Npm.require("path");                                                        // 6
var url = Npm.require("url");                                                          // 7
var crypto = Npm.require("crypto");                                                    // 8
                                                                                       // 9
var connect = Npm.require('connect');                                                  // 10
var optimist = Npm.require('optimist');                                                // 11
var useragent = Npm.require('useragent');                                              // 12
var send = Npm.require('send');                                                        // 13
                                                                                       // 14
WebApp = {};                                                                           // 15
WebAppInternals = {};                                                                  // 16
                                                                                       // 17
var findGalaxy = _.once(function () {                                                  // 18
  if (!('GALAXY' in process.env)) {                                                    // 19
    console.log(                                                                       // 20
      "To do Meteor Galaxy operations like binding to a Galaxy " +                     // 21
        "proxy, the GALAXY environment variable must be set.");                        // 22
    process.exit(1);                                                                   // 23
  }                                                                                    // 24
                                                                                       // 25
  return DDP.connect(process.env['GALAXY']);                                           // 26
});                                                                                    // 27
                                                                                       // 28
// Keepalives so that when the outer server dies unceremoniously and                   // 29
// doesn't kill us, we quit ourselves. A little gross, but better than                 // 30
// pidfiles.                                                                           // 31
// XXX This should really be part of the boot script, not the webapp package.          // 32
//     Or we should just get rid of it, and rely on containerization.                  // 33
                                                                                       // 34
var initKeepalive = function () {                                                      // 35
  var keepaliveCount = 0;                                                              // 36
                                                                                       // 37
  process.stdin.on('data', function (data) {                                           // 38
    keepaliveCount = 0;                                                                // 39
  });                                                                                  // 40
                                                                                       // 41
  process.stdin.resume();                                                              // 42
                                                                                       // 43
  setInterval(function () {                                                            // 44
    keepaliveCount ++;                                                                 // 45
    if (keepaliveCount >= 3) {                                                         // 46
      console.log("Failed to receive keepalive! Exiting.");                            // 47
      process.exit(1);                                                                 // 48
    }                                                                                  // 49
  }, 3000);                                                                            // 50
};                                                                                     // 51
                                                                                       // 52
                                                                                       // 53
var sha1 = function (contents) {                                                       // 54
  var hash = crypto.createHash('sha1');                                                // 55
  hash.update(contents);                                                               // 56
  return hash.digest('hex');                                                           // 57
};                                                                                     // 58
                                                                                       // 59
// #BrowserIdentification                                                              // 60
//                                                                                     // 61
// We have multiple places that want to identify the browser: the                      // 62
// unsupported browser page, the appcache package, and, eventually                     // 63
// delivering browser polyfills only as needed.                                        // 64
//                                                                                     // 65
// To avoid detecting the browser in multiple places ad-hoc, we create a               // 66
// Meteor "browser" object. It uses but does not expose the npm                        // 67
// useragent module (we could choose a different mechanism to identify                 // 68
// the browser in the future if we wanted to).  The browser object                     // 69
// contains                                                                            // 70
//                                                                                     // 71
// * `name`: the name of the browser in camel case                                     // 72
// * `major`, `minor`, `patch`: integers describing the browser version                // 73
//                                                                                     // 74
// Also here is an early version of a Meteor `request` object, intended                // 75
// to be a high-level description of the request without exposing                      // 76
// details of connect's low-level `req`.  Currently it contains:                       // 77
//                                                                                     // 78
// * `browser`: browser identification object described above                          // 79
// * `url`: parsed url, including parsed query params                                  // 80
//                                                                                     // 81
// As a temporary hack there is a `categorizeRequest` function on WebApp which         // 82
// converts a connect `req` to a Meteor `request`. This can go away once smart         // 83
// packages such as appcache are being passed a `request` object directly when         // 84
// they serve content.                                                                 // 85
//                                                                                     // 86
// This allows `request` to be used uniformly: it is passed to the html                // 87
// attributes hook, and the appcache package can use it when deciding                  // 88
// whether to generate a 404 for the manifest.                                         // 89
//                                                                                     // 90
// Real routing / server side rendering will probably refactor this                    // 91
// heavily.                                                                            // 92
                                                                                       // 93
                                                                                       // 94
// e.g. "Mobile Safari" => "mobileSafari"                                              // 95
var camelCase = function (name) {                                                      // 96
  var parts = name.split(' ');                                                         // 97
  parts[0] = parts[0].toLowerCase();                                                   // 98
  for (var i = 1;  i < parts.length;  ++i) {                                           // 99
    parts[i] = parts[i].charAt(0).toUpperCase() + parts[i].substr(1);                  // 100
  }                                                                                    // 101
  return parts.join('');                                                               // 102
};                                                                                     // 103
                                                                                       // 104
var identifyBrowser = function (req) {                                                 // 105
  var userAgent = useragent.lookup(req.headers['user-agent']);                         // 106
  return {                                                                             // 107
    name: camelCase(userAgent.family),                                                 // 108
    major: +userAgent.major,                                                           // 109
    minor: +userAgent.minor,                                                           // 110
    patch: +userAgent.patch                                                            // 111
  };                                                                                   // 112
};                                                                                     // 113
                                                                                       // 114
WebApp.categorizeRequest = function (req) {                                            // 115
  return {                                                                             // 116
    browser: identifyBrowser(req),                                                     // 117
    url: url.parse(req.url, true)                                                      // 118
  };                                                                                   // 119
};                                                                                     // 120
                                                                                       // 121
// HTML attribute hooks: functions to be called to determine any attributes to         // 122
// be added to the '<html>' tag. Each function is passed a 'request' object (see       // 123
// #BrowserIdentification) and should return a string,                                 // 124
var htmlAttributeHooks = [];                                                           // 125
var htmlAttributes = function (template, request) {                                    // 126
  var attributes = '';                                                                 // 127
  _.each(htmlAttributeHooks || [], function (hook) {                                   // 128
    var attribute = hook(request);                                                     // 129
    if (attribute !== null && attribute !== undefined && attribute !== '')             // 130
      attributes += ' ' + attribute;                                                   // 131
  });                                                                                  // 132
  return template.replace('##HTML_ATTRIBUTES##', attributes);                          // 133
};                                                                                     // 134
WebApp.addHtmlAttributeHook = function (hook) {                                        // 135
  htmlAttributeHooks.push(hook);                                                       // 136
};                                                                                     // 137
                                                                                       // 138
// Serve app HTML for this URL?                                                        // 139
var appUrl = function (url) {                                                          // 140
  if (url === '/favicon.ico' || url === '/robots.txt')                                 // 141
    return false;                                                                      // 142
                                                                                       // 143
  // NOTE: app.manifest is not a web standard like favicon.ico and                     // 144
  // robots.txt. It is a file name we have chosen to use for HTML5                     // 145
  // appcache URLs. It is included here to prevent using an appcache                   // 146
  // then removing it from poisoning an app permanently. Eventually,                   // 147
  // once we have server side routing, this won't be needed as                         // 148
  // unknown URLs with return a 404 automatically.                                     // 149
  if (url === '/app.manifest')                                                         // 150
    return false;                                                                      // 151
                                                                                       // 152
  // Avoid serving app HTML for declared routes such as /sockjs/.                      // 153
  if (RoutePolicy.classify(url))                                                       // 154
    return false;                                                                      // 155
                                                                                       // 156
  // we currently return app HTML on all URLs by default                               // 157
  return true;                                                                         // 158
};                                                                                     // 159
                                                                                       // 160
// This is used to move legacy environment variables into deployConfig, where          // 161
// other packages look for them. We probably don't want it here forever.               // 162
var copyEnvVarToDeployConfig = function (deployConfig, envVar,                         // 163
                                         packageName, configKey) {                     // 164
  if (process.env[envVar]) {                                                           // 165
    if (! deployConfig.packages[packageName])                                          // 166
      deployConfig.packages[packageName] = {};                                         // 167
    deployConfig.packages[packageName][configKey] = process.env[envVar];               // 168
  }                                                                                    // 169
};                                                                                     // 170
                                                                                       // 171
var runWebAppServer = function () {                                                    // 172
  // read the control for the client we'll be serving up                               // 173
  var clientJsonPath = path.join(__meteor_bootstrap__.serverDir,                       // 174
                                 __meteor_bootstrap__.configJson.client);              // 175
  var clientDir = path.dirname(clientJsonPath);                                        // 176
  var clientJson = JSON.parse(fs.readFileSync(clientJsonPath, 'utf8'));                // 177
                                                                                       // 178
  if (clientJson.format !== "browser-program-pre1")                                    // 179
    throw new Error("Unsupported format for client assets: " +                         // 180
                    JSON.stringify(clientJson.format));                                // 181
                                                                                       // 182
  // XXX change all this config to something more reasonable.                          // 183
  //     and move it out of webapp into a different package so you don't               // 184
  //     have weird things like mongo-livedata weak-dep'ing on webapp                  // 185
  var deployConfig =                                                                   // 186
        process.env.METEOR_DEPLOY_CONFIG                                               // 187
        ? JSON.parse(process.env.METEOR_DEPLOY_CONFIG) : {};                           // 188
  if (!deployConfig.packages)                                                          // 189
    deployConfig.packages = {};                                                        // 190
  if (!deployConfig.boot)                                                              // 191
    deployConfig.boot = {};                                                            // 192
  if (!deployConfig.boot.bind)                                                         // 193
    deployConfig.boot.bind = {};                                                       // 194
                                                                                       // 195
  // check environment for legacy env variables.                                       // 196
  if (process.env.PORT && !_.has(deployConfig.boot.bind, 'localPort')) {               // 197
    deployConfig.boot.bind.localPort = parseInt(process.env.PORT);                     // 198
  }                                                                                    // 199
  if (process.env.BIND_IP && !_.has(deployConfig.boot.bind, 'localIp')) {              // 200
    deployConfig.boot.bind.localIp = process.env.BIND_IP;                              // 201
  }                                                                                    // 202
  copyEnvVarToDeployConfig(deployConfig, "MONGO_URL", "mongo-livedata", "url");        // 203
                                                                                       // 204
  // webserver                                                                         // 205
  var app = connect();                                                                 // 206
                                                                                       // 207
  // Strip off the path prefix, if it exists.                                          // 208
  app.use(function (request, response, next) {                                         // 209
    var pathPrefix = __meteor_runtime_config__.ROOT_URL_PATH_PREFIX;                   // 210
    var url = Npm.require('url').parse(request.url);                                   // 211
    var pathname = url.pathname;                                                       // 212
    // check if the path in the url starts with the path prefix (and the part          // 213
    // after the path prefix must start with a / if it exists.)                        // 214
    if (pathPrefix && pathname.substring(0, pathPrefix.length) === pathPrefix &&       // 215
       (pathname.length == pathPrefix.length                                           // 216
        || pathname.substring(pathPrefix.length, pathPrefix.length + 1) === "/")) {    // 217
      request.url = request.url.substring(pathPrefix.length);                          // 218
      next();                                                                          // 219
    } else if (pathname === "/favicon.ico" || pathname === "/robots.txt") {            // 220
      next();                                                                          // 221
    } else if (pathPrefix) {                                                           // 222
      response.writeHead(404);                                                         // 223
      response.write("Unknown path");                                                  // 224
      response.end();                                                                  // 225
    } else {                                                                           // 226
      next();                                                                          // 227
    }                                                                                  // 228
  });                                                                                  // 229
  // Parse the query string into res.query. Used by oauth_server, but it's             // 230
  // generally pretty handy..                                                          // 231
  app.use(connect.query());                                                            // 232
                                                                                       // 233
  // Auto-compress any json, javascript, or text.                                      // 234
  app.use(connect.compress());                                                         // 235
                                                                                       // 236
  var getItemPathname = function (itemUrl) {                                           // 237
    return decodeURIComponent(url.parse(itemUrl).pathname);                            // 238
  };                                                                                   // 239
                                                                                       // 240
  var staticFiles = {};                                                                // 241
  _.each(clientJson.manifest, function (item) {                                        // 242
    if (item.url && item.where === "client") {                                         // 243
      staticFiles[getItemPathname(item.url)] = {                                       // 244
        path: item.path,                                                               // 245
        cacheable: item.cacheable,                                                     // 246
        // Link from source to its map                                                 // 247
        sourceMapUrl: item.sourceMapUrl                                                // 248
      };                                                                               // 249
                                                                                       // 250
      if (item.sourceMap) {                                                            // 251
        // Serve the source map too, under the specified URL. We assume all            // 252
        // source maps are cacheable.                                                  // 253
        staticFiles[getItemPathname(item.sourceMapUrl)] = {                            // 254
          path: item.sourceMap,                                                        // 255
          cacheable: true                                                              // 256
        };                                                                             // 257
      }                                                                                // 258
    }                                                                                  // 259
  });                                                                                  // 260
                                                                                       // 261
  // Serve static files from the manifest.                                             // 262
  // This is inspired by the 'static' middleware.                                      // 263
  app.use(function (req, res, next) {                                                  // 264
    if ('GET' != req.method && 'HEAD' != req.method) {                                 // 265
      next();                                                                          // 266
      return;                                                                          // 267
    }                                                                                  // 268
    var pathname = connect.utils.parseUrl(req).pathname;                               // 269
                                                                                       // 270
    try {                                                                              // 271
      pathname = decodeURIComponent(pathname);                                         // 272
    } catch (e) {                                                                      // 273
      next();                                                                          // 274
      return;                                                                          // 275
    }                                                                                  // 276
    if (!_.has(staticFiles, pathname)) {                                               // 277
      next();                                                                          // 278
      return;                                                                          // 279
    }                                                                                  // 280
                                                                                       // 281
    // We don't need to call pause because, unlike 'static', once we call into         // 282
    // 'send' and yield to the event loop, we never call another handler with          // 283
    // 'next'.                                                                         // 284
                                                                                       // 285
    var info = staticFiles[pathname];                                                  // 286
                                                                                       // 287
    // Cacheable files are files that should never change. Typically                   // 288
    // named by their hash (eg meteor bundled js and css files).                       // 289
    // We cache them ~forever (1yr).                                                   // 290
    //                                                                                 // 291
    // We cache non-cacheable files anyway. This isn't really correct, as users        // 292
    // can change the files and changes won't propagate immediately. However, if       // 293
    // we don't cache them, browsers will 'flicker' when rerendering                   // 294
    // images. Eventually we will probably want to rewrite URLs of static assets       // 295
    // to include a query parameter to bust caches. That way we can both get           // 296
    // good caching behavior and allow users to change assets without delay.           // 297
    // https://github.com/meteor/meteor/issues/773                                     // 298
    var maxAge = info.cacheable                                                        // 299
          ? 1000 * 60 * 60 * 24 * 365                                                  // 300
          : 1000 * 60 * 60 * 24;                                                       // 301
                                                                                       // 302
    // Set the X-SourceMap header, which current Chrome understands.                   // 303
    // (The files also contain '//#' comments which FF 24 understands and              // 304
    // Chrome doesn't understand yet.)                                                 // 305
    //                                                                                 // 306
    // Eventually we should set the SourceMap header but the current version of        // 307
    // Chrome and no version of FF supports it.                                        // 308
    //                                                                                 // 309
    // To figure out if your version of Chrome should support the SourceMap            // 310
    // header,                                                                         // 311
    //   - go to chrome://version. Let's say the Chrome version is                     // 312
    //      28.0.1500.71 and the Blink version is 537.36 (@153022)                     // 313
    //   - go to http://src.chromium.org/viewvc/blink/branches/chromium/1500/Source/core/inspector/InspectorPageAgent.cpp?view=log
    //     where the "1500" is the third part of your Chrome version                   // 315
    //   - find the first revision that is no greater than the "153022"                // 316
    //     number.  That's probably the first one and it probably has                  // 317
    //     a message of the form "Branch 1500 - blink@r149738"                         // 318
    //   - If *that* revision number (149738) is at least 151755,                      // 319
    //     then Chrome should support SourceMap (not just X-SourceMap)                 // 320
    // (The change is https://codereview.chromium.org/15832007)                        // 321
    //                                                                                 // 322
    // You also need to enable source maps in Chrome: open dev tools, click            // 323
    // the gear in the bottom right corner, and select "enable source maps".           // 324
    //                                                                                 // 325
    // Firefox 23+ supports source maps but doesn't support either header yet,         // 326
    // so we include the '//#' comment for it:                                         // 327
    //   https://bugzilla.mozilla.org/show_bug.cgi?id=765993                           // 328
    // In FF 23 you need to turn on `devtools.debugger.source-maps-enabled`            // 329
    // in `about:config` (it is on by default in FF 24).                               // 330
    if (info.sourceMapUrl)                                                             // 331
      res.setHeader('X-SourceMap', info.sourceMapUrl);                                 // 332
                                                                                       // 333
    send(req, path.join(clientDir, info.path))                                         // 334
      .maxage(maxAge)                                                                  // 335
      .hidden(true)  // if we specified a dotfile in the manifest, serve it            // 336
      .on('error', function (err) {                                                    // 337
        Log.error("Error serving static file " + err);                                 // 338
        res.writeHead(500);                                                            // 339
        res.end();                                                                     // 340
      })                                                                               // 341
      .on('directory', function () {                                                   // 342
        Log.error("Unexpected directory " + info.path);                                // 343
        res.writeHead(500);                                                            // 344
        res.end();                                                                     // 345
      })                                                                               // 346
      .pipe(res);                                                                      // 347
  });                                                                                  // 348
                                                                                       // 349
  // Packages and apps can add handlers to this via WebApp.connectHandlers.            // 350
  // They are inserted before our default handler.                                     // 351
  var packageAndAppHandlers = connect();                                               // 352
  app.use(packageAndAppHandlers);                                                      // 353
                                                                                       // 354
  var suppressConnectErrors = false;                                                   // 355
  // connect knows it is an error handler because it has 4 arguments instead of        // 356
  // 3. go figure.  (It is not smart enough to find such a thing if it's hidden        // 357
  // inside packageAndAppHandlers.)                                                    // 358
  app.use(function (err, req, res, next) {                                             // 359
    if (!err || !suppressConnectErrors || !req.headers['x-suppress-error']) {          // 360
      next(err);                                                                       // 361
      return;                                                                          // 362
    }                                                                                  // 363
    res.writeHead(err.status, { 'Content-Type': 'text/plain' });                       // 364
    res.end("An error message");                                                       // 365
  });                                                                                  // 366
                                                                                       // 367
  // Will be updated by main before we listen.                                         // 368
  var boilerplateHtml = null;                                                          // 369
  app.use(function (req, res, next) {                                                  // 370
    if (! appUrl(req.url))                                                             // 371
      return next();                                                                   // 372
                                                                                       // 373
    if (!boilerplateHtml)                                                              // 374
      throw new Error("boilerplateHtml should be set before listening!");              // 375
                                                                                       // 376
    var request = WebApp.categorizeRequest(req);                                       // 377
                                                                                       // 378
    res.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});                  // 379
                                                                                       // 380
    var requestSpecificHtml = htmlAttributes(boilerplateHtml, request);                // 381
    res.write(requestSpecificHtml);                                                    // 382
    res.end();                                                                         // 383
    return undefined;                                                                  // 384
  });                                                                                  // 385
                                                                                       // 386
  // Return 404 by default, if no other handlers serve this URL.                       // 387
  app.use(function (req, res) {                                                        // 388
    res.writeHead(404);                                                                // 389
    res.end();                                                                         // 390
  });                                                                                  // 391
                                                                                       // 392
                                                                                       // 393
  var httpServer = http.createServer(app);                                             // 394
  var onListeningCallbacks = [];                                                       // 395
                                                                                       // 396
  // start up app                                                                      // 397
  _.extend(WebApp, {                                                                   // 398
    connectHandlers: packageAndAppHandlers,                                            // 399
    httpServer: httpServer,                                                            // 400
    // metadata about the client program that we serve                                 // 401
    clientProgram: {                                                                   // 402
      manifest: clientJson.manifest                                                    // 403
      // XXX do we need a "root: clientDir" field here? it used to be here but         // 404
      // was unused.                                                                   // 405
    },                                                                                 // 406
    // For testing.                                                                    // 407
    suppressConnectErrors: function () {                                               // 408
      suppressConnectErrors = true;                                                    // 409
    },                                                                                 // 410
    onListening: function (f) {                                                        // 411
      if (onListeningCallbacks)                                                        // 412
        onListeningCallbacks.push(f);                                                  // 413
      else                                                                             // 414
        f();                                                                           // 415
    },                                                                                 // 416
    // Hack: allow http tests to call connect.basicAuth without making them            // 417
    // Npm.depends on another copy of connect. (That would be fine if we could         // 418
    // have test-only NPM dependencies but is overkill here.)                          // 419
    __basicAuth__: connect.basicAuth                                                   // 420
  });                                                                                  // 421
  // XXX move deployConfig out of __meteor_bootstrap__, after deciding where in        // 422
  // the world it goes. maybe a new deploy-config package?                             // 423
  _.extend(__meteor_bootstrap__, {                                                     // 424
    deployConfig: deployConfig                                                         // 425
  });                                                                                  // 426
                                                                                       // 427
  // Let the rest of the packages (and Meteor.startup hooks) insert connect            // 428
  // middlewares and update __meteor_runtime_config__, then keep going to set up       // 429
  // actually serving HTML.                                                            // 430
  main = function (argv) {                                                             // 431
    argv = optimist(argv).boolean('keepalive').argv;                                   // 432
                                                                                       // 433
    var boilerplateHtmlPath = path.join(clientDir, clientJson.page);                   // 434
    boilerplateHtml =                                                                  // 435
      fs.readFileSync(boilerplateHtmlPath, 'utf8')                                     // 436
      .replace(                                                                        // 437
        "// ##RUNTIME_CONFIG##",                                                       // 438
        "__meteor_runtime_config__ = " +                                               // 439
          JSON.stringify(__meteor_runtime_config__) + ";")                             // 440
      .replace(                                                                        // 441
          /##ROOT_URL_PATH_PREFIX##/g,                                                 // 442
        __meteor_runtime_config__.ROOT_URL_PATH_PREFIX || "");                         // 443
                                                                                       // 444
    // only start listening after all the startup code has run.                        // 445
    var bind = deployConfig.boot.bind;                                                 // 446
    var localPort = bind.localPort || 0;                                               // 447
    var localIp = bind.localIp || '0.0.0.0';                                           // 448
    httpServer.listen(localPort, localIp, Meteor.bindEnvironment(function() {          // 449
      if (argv.keepalive || true)                                                      // 450
        console.log("LISTENING"); // must match run.js                                 // 451
      var port = httpServer.address().port;                                            // 452
      if (bind.viaProxy && bind.viaProxy.proxyEndpoint) {                              // 453
        WebAppInternals.bindToProxy(bind.viaProxy);                                    // 454
      } else if (bind.viaProxy) {                                                      // 455
        // bind via the proxy, but we'll have to find it ourselves via                 // 456
        // ultraworld.                                                                 // 457
        var galaxy = findGalaxy();                                                     // 458
        var proxyServiceName = deployConfig.proxyServiceName || "proxy";               // 459
        galaxy.subscribe('servicesByName', proxyServiceName);                          // 460
        var Proxies = new Meteor.Collection('services', {                              // 461
          manager: galaxy                                                              // 462
        });                                                                            // 463
        var doBinding = function (proxyService) {                                      // 464
          if (proxyService.providers.proxy) {                                          // 465
            Log("Attempting to bind to proxy at " + proxyService.providers.proxy);     // 466
            WebAppInternals.bindToProxy(_.extend({                                     // 467
              proxyEndpoint: proxyService.providers.proxy                              // 468
            }, bind.viaProxy));                                                        // 469
         }                                                                             // 470
        };                                                                             // 471
        Proxies.find().observe({                                                       // 472
          added: doBinding,                                                            // 473
          changed: doBinding                                                           // 474
        });                                                                            // 475
      }                                                                                // 476
                                                                                       // 477
      var callbacks = onListeningCallbacks;                                            // 478
      onListeningCallbacks = null;                                                     // 479
      _.each(callbacks, function (x) { x(); });                                        // 480
    }, function (e) {                                                                  // 481
      console.error("Error listening:", e);                                            // 482
      console.error(e.stack);                                                          // 483
    }));                                                                               // 484
                                                                                       // 485
    if (argv.keepalive)                                                                // 486
      initKeepalive();                                                                 // 487
    return 'DAEMON';                                                                   // 488
  };                                                                                   // 489
};                                                                                     // 490
                                                                                       // 491
WebAppInternals.bindToProxy = function (proxyConfig) {                                 // 492
  var securePort = proxyConfig.securePort || 4433;                                     // 493
  var insecurePort = proxyConfig.insecurePort || 8080;                                 // 494
  var bindPathPrefix = proxyConfig.bindPathPrefix || "";                               // 495
  // XXX also support galaxy-based lookup                                              // 496
  if (!proxyConfig.proxyEndpoint)                                                      // 497
    throw new Error("missing proxyEndpoint");                                          // 498
  if (!proxyConfig.bindHost)                                                           // 499
    throw new Error("missing bindHost");                                               // 500
  // XXX move these into deployConfig?                                                 // 501
  if (!process.env.GALAXY_JOB)                                                         // 502
    throw new Error("missing $GALAXY_JOB");                                            // 503
  if (!process.env.GALAXY_APP)                                                         // 504
    throw new Error("missing $GALAXY_APP");                                            // 505
  if (!process.env.LAST_START)                                                         // 506
    throw new Error("missing $LAST_START");                                            // 507
                                                                                       // 508
  // XXX rename pid argument to bindTo.                                                // 509
  var pid = {                                                                          // 510
    job: process.env.GALAXY_JOB,                                                       // 511
    lastStarted: process.env.LAST_START,                                               // 512
    app: process.env.GALAXY_APP                                                        // 513
  };                                                                                   // 514
  var myHost = os.hostname();                                                          // 515
                                                                                       // 516
  var ddpBindTo = {                                                                    // 517
    ddpUrl: 'ddp://' + proxyConfig.bindHost + ':' + securePort + bindPathPrefix + '/', // 518
    insecurePort: insecurePort                                                         // 519
  };                                                                                   // 520
                                                                                       // 521
  // This is run after packages are loaded (in main) so we can use                     // 522
  // DDP.connect.                                                                      // 523
  var proxy = DDP.connect(proxyConfig.proxyEndpoint);                                  // 524
  var route = process.env.ROUTE;                                                       // 525
  var host = route.split(":")[0];                                                      // 526
  var port = +route.split(":")[1];                                                     // 527
  proxy.call('bindDdp', {                                                              // 528
    pid: pid,                                                                          // 529
    bindTo: ddpBindTo,                                                                 // 530
    proxyTo: {                                                                         // 531
      host: host,                                                                      // 532
      port: port,                                                                      // 533
      pathPrefix: bindPathPrefix + '/websocket'                                        // 534
    }                                                                                  // 535
  });                                                                                  // 536
  proxy.call('bindHttp', {                                                             // 537
    pid: pid,                                                                          // 538
    bindTo: {                                                                          // 539
      host: proxyConfig.bindHost,                                                      // 540
      port: insecurePort,                                                              // 541
      pathPrefix: bindPathPrefix                                                       // 542
    },                                                                                 // 543
    proxyTo: {                                                                         // 544
      host: host,                                                                      // 545
      port: port,                                                                      // 546
      pathPrefix: bindPathPrefix                                                       // 547
    }                                                                                  // 548
  });                                                                                  // 549
  if (proxyConfig.securePort !== null) {                                               // 550
    proxy.call('bindHttp', {                                                           // 551
      pid: pid,                                                                        // 552
      bindTo: {                                                                        // 553
        host: proxyConfig.bindHost,                                                    // 554
        port: securePort,                                                              // 555
        pathPrefix: bindPathPrefix,                                                    // 556
        ssl: true                                                                      // 557
      },                                                                               // 558
      proxyTo: {                                                                       // 559
        host: host,                                                                    // 560
        port: port,                                                                    // 561
        pathPrefix: bindPathPrefix                                                     // 562
      }                                                                                // 563
    });                                                                                // 564
  }                                                                                    // 565
  Log("Bound to proxy");                                                               // 566
};                                                                                     // 567
                                                                                       // 568
runWebAppServer();                                                                     // 569
                                                                                       // 570
/////////////////////////////////////////////////////////////////////////////////////////

}).call(this);


/* Exports */
if (typeof Package === 'undefined') Package = {};
Package.webapp = {
  WebApp: WebApp,
  main: main,
  WebAppInternals: WebAppInternals
};

})();
