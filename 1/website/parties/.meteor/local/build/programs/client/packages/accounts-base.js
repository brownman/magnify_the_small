//////////////////////////////////////////////////////////////////////////
//                                                                      //
// This is a generated file. You can view the original                  //
// source in your browser if your browser supports source maps.         //
//                                                                      //
// If you are using Chrome, open the Developer Tools and click the gear //
// icon in its lower right corner. In the General Settings panel, turn  //
// on 'Enable source maps'.                                             //
//                                                                      //
// If you are using Firefox 23, go to `about:config` and set the        //
// `devtools.debugger.source-maps-enabled` preference to true.          //
// (The preference should be on by default in Firefox 24; versions      //
// older than 23 do not support source maps.)                           //
//                                                                      //
//////////////////////////////////////////////////////////////////////////


(function () {

/* Imports */
var Meteor = Package.meteor.Meteor;
var _ = Package.underscore._;
var Deps = Package.deps.Deps;
var Random = Package.random.Random;
var ServiceConfiguration = Package['service-configuration'].ServiceConfiguration;
var DDP = Package.livedata.DDP;

/* Package-scope variables */
var Accounts, autoLoginEnabled, makeClientLoggedOut, makeClientLoggedIn, storeLoginToken, unstoreLoginToken;

(function () {

//////////////////////////////////////////////////////////////////////////////////////////
//                                                                                      //
// packages/accounts-base/accounts_common.js                                            //
//                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////
                                                                                        //
Accounts = {};                                                                          // 1
                                                                                        // 2
// Currently this is read directly by packages like accounts-password                   // 3
// and accounts-ui-unstyled.                                                            // 4
Accounts._options = {};                                                                 // 5
                                                                                        // 6
// Set up config for the accounts system. Call this on both the client                  // 7
// and the server.                                                                      // 8
//                                                                                      // 9
// XXX we should add some enforcement that this is called on both the                   // 10
// client and the server. Otherwise, a user can                                         // 11
// 'forbidClientAccountCreation' only on the client and while it looks                  // 12
// like their app is secure, the server will still accept createUser                    // 13
// calls. https://github.com/meteor/meteor/issues/828                                   // 14
//                                                                                      // 15
// @param options {Object} an object with fields:                                       // 16
// - sendVerificationEmail {Boolean}                                                    // 17
//     Send email address verification emails to new users created from                 // 18
//     client signups.                                                                  // 19
// - forbidClientAccountCreation {Boolean}                                              // 20
//     Do not allow clients to create accounts directly.                                // 21
//                                                                                      // 22
Accounts.config = function(options) {                                                   // 23
  // validate option keys                                                               // 24
  var VALID_KEYS = ["sendVerificationEmail", "forbidClientAccountCreation"];            // 25
  _.each(_.keys(options), function (key) {                                              // 26
    if (!_.contains(VALID_KEYS, key)) {                                                 // 27
      throw new Error("Accounts.config: Invalid key: " + key);                          // 28
    }                                                                                   // 29
  });                                                                                   // 30
                                                                                        // 31
  // set values in Accounts._options                                                    // 32
  _.each(VALID_KEYS, function (key) {                                                   // 33
    if (key in options) {                                                               // 34
      if (key in Accounts._options) {                                                   // 35
        throw new Error("Can't set `" + key + "` more than once");                      // 36
      } else {                                                                          // 37
        Accounts._options[key] = options[key];                                          // 38
      }                                                                                 // 39
    }                                                                                   // 40
  });                                                                                   // 41
};                                                                                      // 42
                                                                                        // 43
// Users table. Don't use the normal autopublish, since we want to hide                 // 44
// some fields. Code to autopublish this is in accounts_server.js.                      // 45
// XXX Allow users to configure this collection name.                                   // 46
//                                                                                      // 47
Meteor.users = new Meteor.Collection("users", {_preventAutopublish: true});             // 48
// There is an allow call in accounts_server that restricts this                        // 49
// collection.                                                                          // 50
                                                                                        // 51
// loginServiceConfiguration and ConfigError are maintained for backwards compatibility // 52
Accounts.loginServiceConfiguration = ServiceConfiguration.configurations;               // 53
Accounts.ConfigError = ServiceConfiguration.ConfigError;                                // 54
                                                                                        // 55
// Thrown when the user cancels the login process (eg, closes an oauth                  // 56
// popup, declines retina scan, etc)                                                    // 57
Accounts.LoginCancelledError = function(description) {                                  // 58
  this.message = description;                                                           // 59
};                                                                                      // 60
                                                                                        // 61
// This is used to transmit specific subclass errors over the wire. We should           // 62
// come up with a more generic way to do this (eg, with some sort of symbolic           // 63
// error code rather than a number).                                                    // 64
Accounts.LoginCancelledError.numericError = 0x8acdc2f;                                  // 65
Accounts.LoginCancelledError.prototype = new Error();                                   // 66
Accounts.LoginCancelledError.prototype.name = 'Accounts.LoginCancelledError';           // 67
                                                                                        // 68
                                                                                        // 69
//////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

//////////////////////////////////////////////////////////////////////////////////////////
//                                                                                      //
// packages/accounts-base/url_client.js                                                 //
//                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////
                                                                                        //
autoLoginEnabled = true;                                                                // 1
                                                                                        // 2
// reads a reset password token from the url's hash fragment, if it's                   // 3
// there. if so prevent automatically logging in since it could be                      // 4
// confusing to be logged in as user A while resetting password for                     // 5
// user B                                                                               // 6
//                                                                                      // 7
// reset password urls use hash fragments instead of url paths/query                    // 8
// strings so that the reset password token is not sent over the wire                   // 9
// on the http request                                                                  // 10
var match;                                                                              // 11
match = window.location.hash.match(/^\#\/reset-password\/(.*)$/);                       // 12
if (match) {                                                                            // 13
  autoLoginEnabled = false;                                                             // 14
  Accounts._resetPasswordToken = match[1];                                              // 15
  window.location.hash = '';                                                            // 16
}                                                                                       // 17
                                                                                        // 18
// reads a verify email token from the url's hash fragment, if                          // 19
// it's there.  also don't automatically log the user is, as for                        // 20
// reset password links.                                                                // 21
//                                                                                      // 22
// XXX we don't need to use hash fragments in this case, and having                     // 23
// the token appear in the url's path would allow us to use a custom                    // 24
// middleware instead of verifying the email on pageload, which                         // 25
// would be faster but less DDP-ish (and more specifically, any                         // 26
// non-web DDP app, such as an iOS client, would do something more                      // 27
// in line with the hash fragment approach)                                             // 28
match = window.location.hash.match(/^\#\/verify-email\/(.*)$/);                         // 29
if (match) {                                                                            // 30
  autoLoginEnabled = false;                                                             // 31
  Accounts._verifyEmailToken = match[1];                                                // 32
  window.location.hash = '';                                                            // 33
}                                                                                       // 34
                                                                                        // 35
// reads an account enrollment token from the url's hash fragment, if                   // 36
// it's there.  also don't automatically log the user is, as for                        // 37
// reset password links.                                                                // 38
match = window.location.hash.match(/^\#\/enroll-account\/(.*)$/);                       // 39
if (match) {                                                                            // 40
  autoLoginEnabled = false;                                                             // 41
  Accounts._enrollAccountToken = match[1];                                              // 42
  window.location.hash = '';                                                            // 43
}                                                                                       // 44
                                                                                        // 45
//////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

//////////////////////////////////////////////////////////////////////////////////////////
//                                                                                      //
// packages/accounts-base/accounts_client.js                                            //
//                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////
                                                                                        //
///                                                                                     // 1
/// CURRENT USER                                                                        // 2
///                                                                                     // 3
                                                                                        // 4
// This is reactive.                                                                    // 5
Meteor.userId = function () {                                                           // 6
  return Meteor.connection.userId();                                                    // 7
};                                                                                      // 8
                                                                                        // 9
var loggingIn = false;                                                                  // 10
var loggingInDeps = new Deps.Dependency;                                                // 11
// This is mostly just called within this file, but Meteor.loginWithPassword            // 12
// also uses it to make loggingIn() be true during the beginPasswordExchange            // 13
// method call too.                                                                     // 14
Accounts._setLoggingIn = function (x) {                                                 // 15
  if (loggingIn !== x) {                                                                // 16
    loggingIn = x;                                                                      // 17
    loggingInDeps.changed();                                                            // 18
  }                                                                                     // 19
};                                                                                      // 20
Meteor.loggingIn = function () {                                                        // 21
  loggingInDeps.depend();                                                               // 22
  return loggingIn;                                                                     // 23
};                                                                                      // 24
                                                                                        // 25
// This calls userId, which is reactive.                                                // 26
Meteor.user = function () {                                                             // 27
  var userId = Meteor.userId();                                                         // 28
  if (!userId)                                                                          // 29
    return null;                                                                        // 30
  return Meteor.users.findOne(userId);                                                  // 31
};                                                                                      // 32
                                                                                        // 33
///                                                                                     // 34
/// LOGIN METHODS                                                                       // 35
///                                                                                     // 36
                                                                                        // 37
// Call a login method on the server.                                                   // 38
//                                                                                      // 39
// A login method is a method which on success calls `this.setUserId(id)` on            // 40
// the server and returns an object with fields 'id' (containing the user id)           // 41
// and 'token' (containing a resume token).                                             // 42
//                                                                                      // 43
// This function takes care of:                                                         // 44
//   - Updating the Meteor.loggingIn() reactive data source                             // 45
//   - Calling the method in 'wait' mode                                                // 46
//   - On success, saving the resume token to localStorage                              // 47
//   - On success, calling Meteor.connection.setUserId()                                // 48
//   - Setting up an onReconnect handler which logs in with                             // 49
//     the resume token                                                                 // 50
//                                                                                      // 51
// Options:                                                                             // 52
// - methodName: The method to call (default 'login')                                   // 53
// - methodArguments: The arguments for the method                                      // 54
// - validateResult: If provided, will be called with the result of the                 // 55
//                 method. If it throws, the client will not be logged in (and          // 56
//                 its error will be passed to the callback).                           // 57
// - userCallback: Will be called with no arguments once the user is fully              // 58
//                 logged in, or with the error on error.                               // 59
//                                                                                      // 60
Accounts.callLoginMethod = function (options) {                                         // 61
  options = _.extend({                                                                  // 62
    methodName: 'login',                                                                // 63
    methodArguments: [],                                                                // 64
    _suppressLoggingIn: false                                                           // 65
  }, options);                                                                          // 66
  // Set defaults for callback arguments to no-op functions; make sure we               // 67
  // override falsey values too.                                                        // 68
  _.each(['validateResult', 'userCallback'], function (f) {                             // 69
    if (!options[f])                                                                    // 70
      options[f] = function () {};                                                      // 71
  });                                                                                   // 72
                                                                                        // 73
  var reconnected = false;                                                              // 74
                                                                                        // 75
  // We want to set up onReconnect as soon as we get a result token back from           // 76
  // the server, without having to wait for subscriptions to rerun. This is             // 77
  // because if we disconnect and reconnect between getting the result and              // 78
  // getting the results of subscription rerun, we WILL NOT re-send this                // 79
  // method (because we never re-send methods whose results we've received)             // 80
  // but we WILL call loggedInAndDataReadyCallback at "reconnect quiesce"               // 81
  // time. This will lead to makeClientLoggedIn(result.id) even though we               // 82
  // haven't actually sent a login method!                                              // 83
  //                                                                                    // 84
  // But by making sure that we send this "resume" login in that case (and              // 85
  // calling makeClientLoggedOut if it fails), we'll end up with an accurate            // 86
  // client-side userId. (It's important that livedata_connection guarantees            // 87
  // that the "reconnect quiesce"-time call to loggedInAndDataReadyCallback             // 88
  // will occur before the callback from the resume login call.)                        // 89
  var onResultReceived = function (err, result) {                                       // 90
    if (err || !result || !result.token) {                                              // 91
      Meteor.connection.onReconnect = null;                                             // 92
    } else {                                                                            // 93
      Meteor.connection.onReconnect = function() {                                      // 94
        reconnected = true;                                                             // 95
        Accounts.callLoginMethod({                                                      // 96
          methodArguments: [{resume: result.token}],                                    // 97
          // Reconnect quiescence ensures that the user doesn't see an                  // 98
          // intermediate state before the login method finishes. So we don't           // 99
          // need to show a logging-in animation.                                       // 100
          _suppressLoggingIn: true,                                                     // 101
          userCallback: function (error) {                                              // 102
            if (error) {                                                                // 103
              makeClientLoggedOut();                                                    // 104
            }                                                                           // 105
            options.userCallback(error);                                                // 106
          }});                                                                          // 107
      };                                                                                // 108
    }                                                                                   // 109
  };                                                                                    // 110
                                                                                        // 111
  // This callback is called once the local cache of the current-user                   // 112
  // subscription (and all subscriptions, in fact) are guaranteed to be up to           // 113
  // date.                                                                              // 114
  var loggedInAndDataReadyCallback = function (error, result) {                         // 115
    // If the login method returns its result but the connection is lost                // 116
    // before the data is in the local cache, it'll set an onReconnect (see             // 117
    // above). The onReconnect will try to log in using the token, and *it*             // 118
    // will call userCallback via its own version of this                               // 119
    // loggedInAndDataReadyCallback. So we don't have to do anything here.              // 120
    if (reconnected)                                                                    // 121
      return;                                                                           // 122
                                                                                        // 123
    // Note that we need to call this even if _suppressLoggingIn is true,               // 124
    // because it could be matching a _setLoggingIn(true) from a                        // 125
    // half-completed pre-reconnect login method.                                       // 126
    Accounts._setLoggingIn(false);                                                      // 127
    if (error || !result) {                                                             // 128
      error = error || new Error(                                                       // 129
        "No result from call to " + options.methodName);                                // 130
      options.userCallback(error);                                                      // 131
      return;                                                                           // 132
    }                                                                                   // 133
    try {                                                                               // 134
      options.validateResult(result);                                                   // 135
    } catch (e) {                                                                       // 136
      options.userCallback(e);                                                          // 137
      return;                                                                           // 138
    }                                                                                   // 139
                                                                                        // 140
    // Make the client logged in. (The user data should already be loaded!)             // 141
    makeClientLoggedIn(result.id, result.token);                                        // 142
    options.userCallback();                                                             // 143
  };                                                                                    // 144
                                                                                        // 145
  if (!options._suppressLoggingIn)                                                      // 146
    Accounts._setLoggingIn(true);                                                       // 147
  Meteor.apply(                                                                         // 148
    options.methodName,                                                                 // 149
    options.methodArguments,                                                            // 150
    {wait: true, onResultReceived: onResultReceived},                                   // 151
    loggedInAndDataReadyCallback);                                                      // 152
};                                                                                      // 153
                                                                                        // 154
makeClientLoggedOut = function() {                                                      // 155
  unstoreLoginToken();                                                                  // 156
  Meteor.connection.setUserId(null);                                                    // 157
  Meteor.connection.onReconnect = null;                                                 // 158
};                                                                                      // 159
                                                                                        // 160
makeClientLoggedIn = function(userId, token) {                                          // 161
  storeLoginToken(userId, token);                                                       // 162
  Meteor.connection.setUserId(userId);                                                  // 163
};                                                                                      // 164
                                                                                        // 165
Meteor.logout = function (callback) {                                                   // 166
  Meteor.apply('logout', [], {wait: true}, function(error, result) {                    // 167
    if (error) {                                                                        // 168
      callback && callback(error);                                                      // 169
    } else {                                                                            // 170
      makeClientLoggedOut();                                                            // 171
      callback && callback();                                                           // 172
    }                                                                                   // 173
  });                                                                                   // 174
};                                                                                      // 175
                                                                                        // 176
///                                                                                     // 177
/// LOGIN SERVICES                                                                      // 178
///                                                                                     // 179
                                                                                        // 180
var loginServicesHandle = Meteor.subscribe("meteor.loginServiceConfiguration");         // 181
                                                                                        // 182
// A reactive function returning whether the loginServiceConfiguration                  // 183
// subscription is ready. Used by accounts-ui to hide the login button                  // 184
// until we have all the configuration loaded                                           // 185
//                                                                                      // 186
Accounts.loginServicesConfigured = function () {                                        // 187
  return loginServicesHandle.ready();                                                   // 188
};                                                                                      // 189
                                                                                        // 190
///                                                                                     // 191
/// HANDLEBARS HELPERS                                                                  // 192
///                                                                                     // 193
                                                                                        // 194
// If we're using Handlebars, register the {{currentUser}} and                          // 195
// {{loggingIn}} global helpers.                                                        // 196
if (Package.handlebars) {                                                               // 197
  Package.handlebars.Handlebars.registerHelper('currentUser', function () {             // 198
    return Meteor.user();                                                               // 199
  });                                                                                   // 200
  Package.handlebars.Handlebars.registerHelper('loggingIn', function () {               // 201
    return Meteor.loggingIn();                                                          // 202
  });                                                                                   // 203
}                                                                                       // 204
                                                                                        // 205
//////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

//////////////////////////////////////////////////////////////////////////////////////////
//                                                                                      //
// packages/accounts-base/localstorage_token.js                                         //
//                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////
                                                                                        //
// This file deals with storing a login token and user id in the                        // 1
// browser's localStorage facility. It polls local storage every few                    // 2
// seconds to synchronize login state between multiple tabs in the same                 // 3
// browser.                                                                             // 4
                                                                                        // 5
var lastLoginTokenWhenPolled;                                                           // 6
                                                                                        // 7
// Login with a Meteor access token. This is the only public function                   // 8
// here.                                                                                // 9
Meteor.loginWithToken = function (token, callback) {                                    // 10
  Accounts.callLoginMethod({                                                            // 11
    methodArguments: [{resume: token}],                                                 // 12
    userCallback: callback});                                                           // 13
};                                                                                      // 14
                                                                                        // 15
// Semi-internal API. Call this function to re-enable auto login after                  // 16
// if it was disabled at startup.                                                       // 17
Accounts._enableAutoLogin = function () {                                               // 18
  autoLoginEnabled = true;                                                              // 19
  pollStoredLoginToken();                                                               // 20
};                                                                                      // 21
                                                                                        // 22
                                                                                        // 23
///                                                                                     // 24
/// STORING                                                                             // 25
///                                                                                     // 26
                                                                                        // 27
// Key names to use in localStorage                                                     // 28
var loginTokenKey = "Meteor.loginToken";                                                // 29
var userIdKey = "Meteor.userId";                                                        // 30
                                                                                        // 31
// Call this from the top level of the test file for any test that does                 // 32
// logging in and out, to protect multiple tabs running the same tests                  // 33
// simultaneously from interfering with each others' localStorage.                      // 34
Accounts._isolateLoginTokenForTest = function () {                                      // 35
  loginTokenKey = loginTokenKey + Random.id();                                          // 36
  userIdKey = userIdKey + Random.id();                                                  // 37
};                                                                                      // 38
                                                                                        // 39
storeLoginToken = function(userId, token) {                                             // 40
  Meteor._localStorage.setItem(userIdKey, userId);                                      // 41
  Meteor._localStorage.setItem(loginTokenKey, token);                                   // 42
                                                                                        // 43
  // to ensure that the localstorage poller doesn't end up trying to                    // 44
  // connect a second time                                                              // 45
  lastLoginTokenWhenPolled = token;                                                     // 46
};                                                                                      // 47
                                                                                        // 48
unstoreLoginToken = function() {                                                        // 49
  Meteor._localStorage.removeItem(userIdKey);                                           // 50
  Meteor._localStorage.removeItem(loginTokenKey);                                       // 51
                                                                                        // 52
  // to ensure that the localstorage poller doesn't end up trying to                    // 53
  // connect a second time                                                              // 54
  lastLoginTokenWhenPolled = null;                                                      // 55
};                                                                                      // 56
                                                                                        // 57
// This is private, but it is exported for now because it is used by a                  // 58
// test in accounts-password.                                                           // 59
//                                                                                      // 60
var storedLoginToken = Accounts._storedLoginToken = function() {                        // 61
  return Meteor._localStorage.getItem(loginTokenKey);                                   // 62
};                                                                                      // 63
                                                                                        // 64
var storedUserId = function() {                                                         // 65
  return Meteor._localStorage.getItem(userIdKey);                                       // 66
};                                                                                      // 67
                                                                                        // 68
                                                                                        // 69
///                                                                                     // 70
/// AUTO-LOGIN                                                                          // 71
///                                                                                     // 72
                                                                                        // 73
if (autoLoginEnabled) {                                                                 // 74
  // Immediately try to log in via local storage, so that any DDP                       // 75
  // messages are sent after we have established our user account                       // 76
  var token = storedLoginToken();                                                       // 77
  if (token) {                                                                          // 78
    // On startup, optimistically present us as logged in while the                     // 79
    // request is in flight. This reduces page flicker on startup.                      // 80
    var userId = storedUserId();                                                        // 81
    userId && Meteor.connection.setUserId(userId);                                      // 82
    Meteor.loginWithToken(token, function (err) {                                       // 83
      if (err) {                                                                        // 84
        Meteor._debug("Error logging in with token: " + err);                           // 85
        makeClientLoggedOut();                                                          // 86
      }                                                                                 // 87
    });                                                                                 // 88
  }                                                                                     // 89
}                                                                                       // 90
                                                                                        // 91
// Poll local storage every 3 seconds to login if someone logged in in                  // 92
// another tab                                                                          // 93
lastLoginTokenWhenPolled = token;                                                       // 94
var pollStoredLoginToken = function() {                                                 // 95
  if (! autoLoginEnabled)                                                               // 96
    return;                                                                             // 97
                                                                                        // 98
  var currentLoginToken = storedLoginToken();                                           // 99
                                                                                        // 100
  // != instead of !== just to make sure undefined and null are treated the same        // 101
  if (lastLoginTokenWhenPolled != currentLoginToken) {                                  // 102
    if (currentLoginToken)                                                              // 103
      Meteor.loginWithToken(currentLoginToken); // XXX should we pass a callback here?  // 104
    else                                                                                // 105
      Meteor.logout();                                                                  // 106
  }                                                                                     // 107
  lastLoginTokenWhenPolled = currentLoginToken;                                         // 108
};                                                                                      // 109
                                                                                        // 110
setInterval(pollStoredLoginToken, 3000);                                                // 111
                                                                                        // 112
//////////////////////////////////////////////////////////////////////////////////////////

}).call(this);


/* Exports */
if (typeof Package === 'undefined') Package = {};
Package['accounts-base'] = {
  Accounts: Accounts
};

})();

//# sourceMappingURL=e991c6fc17941a584b1daa1eef54fc838068754e.map
