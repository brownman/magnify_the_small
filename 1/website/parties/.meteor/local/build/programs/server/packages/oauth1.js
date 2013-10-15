(function () {

/* Imports */
var Meteor = Package.meteor.Meteor;
var Random = Package.random.Random;
var ServiceConfiguration = Package['service-configuration'].ServiceConfiguration;
var Oauth = Package.oauth.Oauth;
var _ = Package.underscore._;
var HTTP = Package.http.HTTP;

/* Package-scope variables */
var OAuth1Binding, OAuth1Test;

(function () {

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                     //
// packages/oauth1/oauth1_binding.js                                                                   //
//                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                       //
var crypto = Npm.require("crypto");                                                                    // 1
var querystring = Npm.require("querystring");                                                          // 2
                                                                                                       // 3
// An OAuth1 wrapper around http calls which helps get tokens and                                      // 4
// takes care of HTTP headers                                                                          // 5
//                                                                                                     // 6
// @param consumerKey {String} As supplied by the OAuth1 provider                                      // 7
// @param consumerSecret {String} As supplied by the OAuth1 provider                                   // 8
// @param urls {Object}                                                                                // 9
//   - requestToken (String): url                                                                      // 10
//   - authorize (String): url                                                                         // 11
//   - accessToken (String): url                                                                       // 12
//   - authenticate (String): url                                                                      // 13
OAuth1Binding = function(consumerKey, consumerSecret, urls) {                                          // 14
  this._consumerKey = consumerKey;                                                                     // 15
  this._secret = consumerSecret;                                                                       // 16
  this._urls = urls;                                                                                   // 17
};                                                                                                     // 18
                                                                                                       // 19
OAuth1Binding.prototype.prepareRequestToken = function(callbackUrl) {                                  // 20
  var self = this;                                                                                     // 21
                                                                                                       // 22
  var headers = self._buildHeader({                                                                    // 23
    oauth_callback: callbackUrl                                                                        // 24
  });                                                                                                  // 25
                                                                                                       // 26
  var response = self._call('POST', self._urls.requestToken, headers);                                 // 27
  var tokens = querystring.parse(response.content);                                                    // 28
                                                                                                       // 29
  // XXX should we also store oauth_token_secret here?                                                 // 30
  if (!tokens.oauth_callback_confirmed)                                                                // 31
    throw new Error("oauth_callback_confirmed false when requesting oauth1 token", tokens);            // 32
  self.requestToken = tokens.oauth_token;                                                              // 33
};                                                                                                     // 34
                                                                                                       // 35
OAuth1Binding.prototype.prepareAccessToken = function(query) {                                         // 36
  var self = this;                                                                                     // 37
                                                                                                       // 38
  var headers = self._buildHeader({                                                                    // 39
    oauth_token: query.oauth_token                                                                     // 40
  });                                                                                                  // 41
                                                                                                       // 42
  var params = {                                                                                       // 43
    oauth_verifier: query.oauth_verifier                                                               // 44
  };                                                                                                   // 45
                                                                                                       // 46
  var response = self._call('POST', self._urls.accessToken, headers, params);                          // 47
  var tokens = querystring.parse(response.content);                                                    // 48
                                                                                                       // 49
  self.accessToken = tokens.oauth_token;                                                               // 50
  self.accessTokenSecret = tokens.oauth_token_secret;                                                  // 51
};                                                                                                     // 52
                                                                                                       // 53
OAuth1Binding.prototype.call = function(method, url, params, callback) {                               // 54
  var self = this;                                                                                     // 55
                                                                                                       // 56
  var headers = self._buildHeader({                                                                    // 57
    oauth_token: self.accessToken                                                                      // 58
  });                                                                                                  // 59
                                                                                                       // 60
  if(!params) {                                                                                        // 61
    params = {};                                                                                       // 62
  }                                                                                                    // 63
                                                                                                       // 64
  return self._call(method, url, headers, params, callback);                                           // 65
};                                                                                                     // 66
                                                                                                       // 67
OAuth1Binding.prototype.get = function(url, params, callback) {                                        // 68
  return this.call('GET', url, params, callback);                                                      // 69
};                                                                                                     // 70
                                                                                                       // 71
OAuth1Binding.prototype.post = function(url, params, callback) {                                       // 72
  return this.call('POST', url, params, callback);                                                     // 73
};                                                                                                     // 74
                                                                                                       // 75
OAuth1Binding.prototype._buildHeader = function(headers) {                                             // 76
  var self = this;                                                                                     // 77
  return _.extend({                                                                                    // 78
    oauth_consumer_key: self._consumerKey,                                                             // 79
    oauth_nonce: Random.id().replace(/\W/g, ''),                                                       // 80
    oauth_signature_method: 'HMAC-SHA1',                                                               // 81
    oauth_timestamp: (new Date().valueOf()/1000).toFixed().toString(),                                 // 82
    oauth_version: '1.0'                                                                               // 83
  }, headers);                                                                                         // 84
};                                                                                                     // 85
                                                                                                       // 86
OAuth1Binding.prototype._getSignature = function(method, url, rawHeaders, accessTokenSecret, params) { // 87
  var self = this;                                                                                     // 88
  var headers = self._encodeHeader(_.extend(rawHeaders, params));                                      // 89
                                                                                                       // 90
  var parameters = _.map(headers, function(val, key) {                                                 // 91
    return key + '=' + val;                                                                            // 92
  }).sort().join('&');                                                                                 // 93
                                                                                                       // 94
  var signatureBase = [                                                                                // 95
    method,                                                                                            // 96
    self._encodeString(url),                                                                           // 97
    self._encodeString(parameters)                                                                     // 98
  ].join('&');                                                                                         // 99
                                                                                                       // 100
  var signingKey = self._encodeString(self._secret) + '&';                                             // 101
  if (accessTokenSecret)                                                                               // 102
    signingKey += self._encodeString(accessTokenSecret);                                               // 103
                                                                                                       // 104
  return crypto.createHmac('SHA1', signingKey).update(signatureBase).digest('base64');                 // 105
};                                                                                                     // 106
                                                                                                       // 107
OAuth1Binding.prototype._call = function(method, url, headers, params, callback) {                     // 108
  var self = this;                                                                                     // 109
                                                                                                       // 110
  // Get the signature                                                                                 // 111
  headers.oauth_signature = self._getSignature(method, url, headers, self.accessTokenSecret, params);  // 112
                                                                                                       // 113
  // Make a authorization string according to oauth1 spec                                              // 114
  var authString = self._getAuthHeaderString(headers);                                                 // 115
                                                                                                       // 116
  // Make signed request                                                                               // 117
  try {                                                                                                // 118
    return HTTP.call(method, url, {                                                                    // 119
      params: params,                                                                                  // 120
      headers: {                                                                                       // 121
        Authorization: authString                                                                      // 122
      }                                                                                                // 123
    }, callback);                                                                                      // 124
  } catch (err) {                                                                                      // 125
    throw _.extend(new Error("Failed to send OAuth1 request to " + url + ". " + err.message),          // 126
                   {response: err.response});                                                          // 127
  }                                                                                                    // 128
};                                                                                                     // 129
                                                                                                       // 130
OAuth1Binding.prototype._encodeHeader = function(header) {                                             // 131
  var self = this;                                                                                     // 132
  return _.reduce(header, function(memo, val, key) {                                                   // 133
    memo[self._encodeString(key)] = self._encodeString(val);                                           // 134
    return memo;                                                                                       // 135
  }, {});                                                                                              // 136
};                                                                                                     // 137
                                                                                                       // 138
OAuth1Binding.prototype._encodeString = function(str) {                                                // 139
  return encodeURIComponent(str).replace(/[!'()]/g, escape).replace(/\*/g, "%2A");                     // 140
};                                                                                                     // 141
                                                                                                       // 142
OAuth1Binding.prototype._getAuthHeaderString = function(headers) {                                     // 143
  var self = this;                                                                                     // 144
  return 'OAuth ' +  _.map(headers, function(val, key) {                                               // 145
    return self._encodeString(key) + '="' + self._encodeString(val) + '"';                             // 146
  }).sort().join(', ');                                                                                // 147
};                                                                                                     // 148
                                                                                                       // 149
/////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                     //
// packages/oauth1/oauth1_server.js                                                                    //
//                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                       //
// A place to store request tokens pending verification                                                // 1
var requestTokens = {};                                                                                // 2
                                                                                                       // 3
OAuth1Test = {requestTokens: requestTokens};                                                           // 4
                                                                                                       // 5
// connect middleware                                                                                  // 6
Oauth._requestHandlers['1'] = function (service, query, res) {                                         // 7
                                                                                                       // 8
  var config = ServiceConfiguration.configurations.findOne({service: service.serviceName});            // 9
  if (!config) {                                                                                       // 10
    throw new ServiceConfiguration.ConfigError("Service " + service.serviceName + " not configured");  // 11
  }                                                                                                    // 12
                                                                                                       // 13
  var urls = service.urls;                                                                             // 14
  var oauthBinding = new OAuth1Binding(                                                                // 15
    config.consumerKey, config.secret, urls);                                                          // 16
                                                                                                       // 17
  if (query.requestTokenAndRedirect) {                                                                 // 18
    // step 1 - get and store a request token                                                          // 19
                                                                                                       // 20
    // Get a request token to start auth process                                                       // 21
    oauthBinding.prepareRequestToken(query.requestTokenAndRedirect);                                   // 22
                                                                                                       // 23
    // Keep track of request token so we can verify it on the next step                                // 24
    requestTokens[query.state] = oauthBinding.requestToken;                                            // 25
                                                                                                       // 26
    // redirect to provider login, which will redirect back to "step 2" below                          // 27
    var redirectUrl = urls.authenticate + '?oauth_token=' + oauthBinding.requestToken;                 // 28
    res.writeHead(302, {'Location': redirectUrl});                                                     // 29
    res.end();                                                                                         // 30
  } else {                                                                                             // 31
    // step 2, redirected from provider login - complete the login                                     // 32
    // process: if the user authorized permissions, get an access                                      // 33
    // token and access token secret and log in as user                                                // 34
                                                                                                       // 35
    // Get the user's request token so we can verify it and clear it                                   // 36
    var requestToken = requestTokens[query.state];                                                     // 37
    delete requestTokens[query.state];                                                                 // 38
                                                                                                       // 39
    // Verify user authorized access and the oauth_token matches                                       // 40
    // the requestToken from previous step                                                             // 41
    if (query.oauth_token && query.oauth_token === requestToken) {                                     // 42
                                                                                                       // 43
      // Prepare the login results before returning.  This way the                                     // 44
      // subsequent call to the `login` method will be immediate.                                      // 45
                                                                                                       // 46
      // Get the access token for signing requests                                                     // 47
      oauthBinding.prepareAccessToken(query);                                                          // 48
                                                                                                       // 49
      // Run service-specific handler.                                                                 // 50
      var oauthResult = service.handleOauthRequest(oauthBinding);                                      // 51
                                                                                                       // 52
      // Add the login result to the result map                                                        // 53
      Oauth._loginResultForCredentialToken[query.state] = {                                            // 54
          serviceName: service.serviceName,                                                            // 55
          serviceData: oauthResult.serviceData,                                                        // 56
          options: oauthResult.options                                                                 // 57
        };                                                                                             // 58
    }                                                                                                  // 59
                                                                                                       // 60
    // Either close the window, redirect, or render nothing                                            // 61
    // if all else fails                                                                               // 62
    Oauth._renderOauthResults(res, query);                                                             // 63
  }                                                                                                    // 64
};                                                                                                     // 65
                                                                                                       // 66
/////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);


/* Exports */
if (typeof Package === 'undefined') Package = {};
Package.oauth1 = {
  OAuth1Binding: OAuth1Binding,
  OAuth1Test: OAuth1Test
};

})();
