(function () {

/* Imports */
var Meteor = Package.meteor.Meteor;
var _ = Package.underscore._;
var check = Package.check.check;
var Match = Package.check.Match;
var Random = Package.random.Random;
var ServiceConfiguration = Package['service-configuration'].ServiceConfiguration;
var DDP = Package.livedata.DDP;
var DDPServer = Package.livedata.DDPServer;
var MongoInternals = Package['mongo-livedata'].MongoInternals;

/* Package-scope variables */
var Accounts, loginHandlers, removeLoginToken;

(function () {

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                               //
// packages/accounts-base/accounts_common.js                                                                     //
//                                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                 //
Accounts = {};                                                                                                   // 1
                                                                                                                 // 2
// Currently this is read directly by packages like accounts-password                                            // 3
// and accounts-ui-unstyled.                                                                                     // 4
Accounts._options = {};                                                                                          // 5
                                                                                                                 // 6
// Set up config for the accounts system. Call this on both the client                                           // 7
// and the server.                                                                                               // 8
//                                                                                                               // 9
// XXX we should add some enforcement that this is called on both the                                            // 10
// client and the server. Otherwise, a user can                                                                  // 11
// 'forbidClientAccountCreation' only on the client and while it looks                                           // 12
// like their app is secure, the server will still accept createUser                                             // 13
// calls. https://github.com/meteor/meteor/issues/828                                                            // 14
//                                                                                                               // 15
// @param options {Object} an object with fields:                                                                // 16
// - sendVerificationEmail {Boolean}                                                                             // 17
//     Send email address verification emails to new users created from                                          // 18
//     client signups.                                                                                           // 19
// - forbidClientAccountCreation {Boolean}                                                                       // 20
//     Do not allow clients to create accounts directly.                                                         // 21
//                                                                                                               // 22
Accounts.config = function(options) {                                                                            // 23
  // validate option keys                                                                                        // 24
  var VALID_KEYS = ["sendVerificationEmail", "forbidClientAccountCreation"];                                     // 25
  _.each(_.keys(options), function (key) {                                                                       // 26
    if (!_.contains(VALID_KEYS, key)) {                                                                          // 27
      throw new Error("Accounts.config: Invalid key: " + key);                                                   // 28
    }                                                                                                            // 29
  });                                                                                                            // 30
                                                                                                                 // 31
  // set values in Accounts._options                                                                             // 32
  _.each(VALID_KEYS, function (key) {                                                                            // 33
    if (key in options) {                                                                                        // 34
      if (key in Accounts._options) {                                                                            // 35
        throw new Error("Can't set `" + key + "` more than once");                                               // 36
      } else {                                                                                                   // 37
        Accounts._options[key] = options[key];                                                                   // 38
      }                                                                                                          // 39
    }                                                                                                            // 40
  });                                                                                                            // 41
};                                                                                                               // 42
                                                                                                                 // 43
// Users table. Don't use the normal autopublish, since we want to hide                                          // 44
// some fields. Code to autopublish this is in accounts_server.js.                                               // 45
// XXX Allow users to configure this collection name.                                                            // 46
//                                                                                                               // 47
Meteor.users = new Meteor.Collection("users", {_preventAutopublish: true});                                      // 48
// There is an allow call in accounts_server that restricts this                                                 // 49
// collection.                                                                                                   // 50
                                                                                                                 // 51
// loginServiceConfiguration and ConfigError are maintained for backwards compatibility                          // 52
Accounts.loginServiceConfiguration = ServiceConfiguration.configurations;                                        // 53
Accounts.ConfigError = ServiceConfiguration.ConfigError;                                                         // 54
                                                                                                                 // 55
// Thrown when the user cancels the login process (eg, closes an oauth                                           // 56
// popup, declines retina scan, etc)                                                                             // 57
Accounts.LoginCancelledError = function(description) {                                                           // 58
  this.message = description;                                                                                    // 59
};                                                                                                               // 60
                                                                                                                 // 61
// This is used to transmit specific subclass errors over the wire. We should                                    // 62
// come up with a more generic way to do this (eg, with some sort of symbolic                                    // 63
// error code rather than a number).                                                                             // 64
Accounts.LoginCancelledError.numericError = 0x8acdc2f;                                                           // 65
Accounts.LoginCancelledError.prototype = new Error();                                                            // 66
Accounts.LoginCancelledError.prototype.name = 'Accounts.LoginCancelledError';                                    // 67
                                                                                                                 // 68
                                                                                                                 // 69
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                               //
// packages/accounts-base/accounts_server.js                                                                     //
//                                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                 //
///                                                                                                              // 1
/// CURRENT USER                                                                                                 // 2
///                                                                                                              // 3
                                                                                                                 // 4
Meteor.userId = function () {                                                                                    // 5
  // This function only works if called inside a method. In theory, it                                           // 6
  // could also be called from publish statements, since they also                                               // 7
  // have a userId associated with them. However, given that publish                                             // 8
  // functions aren't reactive, using any of the infomation from                                                 // 9
  // Meteor.user() in a publish function will always use the value                                               // 10
  // from when the function first runs. This is likely not what the                                              // 11
  // user expects. The way to make this work in a publish is to do                                               // 12
  // Meteor.find(this.userId()).observe and recompute when the user                                              // 13
  // record changes.                                                                                             // 14
  var currentInvocation = DDP._CurrentInvocation.get();                                                          // 15
  if (!currentInvocation)                                                                                        // 16
    throw new Error("Meteor.userId can only be invoked in method calls. Use this.userId in publish functions."); // 17
  return currentInvocation.userId;                                                                               // 18
};                                                                                                               // 19
                                                                                                                 // 20
Meteor.user = function () {                                                                                      // 21
  var userId = Meteor.userId();                                                                                  // 22
  if (!userId)                                                                                                   // 23
    return null;                                                                                                 // 24
  return Meteor.users.findOne(userId);                                                                           // 25
};                                                                                                               // 26
                                                                                                                 // 27
///                                                                                                              // 28
/// LOGIN HANDLERS                                                                                               // 29
///                                                                                                              // 30
                                                                                                                 // 31
// The main entry point for auth packages to hook in to login.                                                   // 32
//                                                                                                               // 33
// @param handler {Function} A function that receives an options object                                          // 34
// (as passed as an argument to the `login` method) and returns one of:                                          // 35
// - `undefined`, meaning don't handle;                                                                          // 36
// - {id: userId, token: *}, if the user logged in successfully.                                                 // 37
// - throw an error, if the user failed to log in.                                                               // 38
//                                                                                                               // 39
Accounts.registerLoginHandler = function(handler) {                                                              // 40
  loginHandlers.push(handler);                                                                                   // 41
};                                                                                                               // 42
                                                                                                                 // 43
// list of all registered handlers.                                                                              // 44
loginHandlers = [];                                                                                              // 45
                                                                                                                 // 46
                                                                                                                 // 47
// Try all of the registered login handlers until one of them doesn'                                             // 48
// return `undefined`, meaning it handled this call to `login`. Return                                           // 49
// that return value, which ought to be a {id/token} pair.                                                       // 50
var tryAllLoginHandlers = function (options) {                                                                   // 51
  for (var i = 0; i < loginHandlers.length; ++i) {                                                               // 52
    var handler = loginHandlers[i];                                                                              // 53
    var result = handler(options);                                                                               // 54
    if (result !== undefined)                                                                                    // 55
      return result;                                                                                             // 56
  }                                                                                                              // 57
                                                                                                                 // 58
  throw new Meteor.Error(400, "Unrecognized options for login request");                                         // 59
};                                                                                                               // 60
                                                                                                                 // 61
                                                                                                                 // 62
// Actual methods for login and logout. This is the entry point for                                              // 63
// clients to actually log in.                                                                                   // 64
Meteor.methods({                                                                                                 // 65
  // @returns {Object|null}                                                                                      // 66
  //   If successful, returns {token: reconnectToken, id: userId}                                                // 67
  //   If unsuccessful (for example, if the user closed the oauth login popup),                                  // 68
  //     returns null                                                                                            // 69
  login: function(options) {                                                                                     // 70
    // Login handlers should really also check whatever field they look at in                                    // 71
    // options, but we don't enforce it.                                                                         // 72
    check(options, Object);                                                                                      // 73
    var result = tryAllLoginHandlers(options);                                                                   // 74
    if (result !== null) {                                                                                       // 75
      this.setUserId(result.id);                                                                                 // 76
      this._sessionData.loginToken = result.token;                                                               // 77
    }                                                                                                            // 78
    return result;                                                                                               // 79
  },                                                                                                             // 80
                                                                                                                 // 81
  logout: function() {                                                                                           // 82
    if (this._sessionData.loginToken && this.userId)                                                             // 83
      removeLoginToken(this.userId, this._sessionData.loginToken);                                               // 84
    this.setUserId(null);                                                                                        // 85
  }                                                                                                              // 86
});                                                                                                              // 87
                                                                                                                 // 88
///                                                                                                              // 89
/// RECONNECT TOKENS                                                                                             // 90
///                                                                                                              // 91
/// support reconnecting using a meteor login token                                                              // 92
                                                                                                                 // 93
// Login handler for resume tokens.                                                                              // 94
Accounts.registerLoginHandler(function(options) {                                                                // 95
  if (!options.resume)                                                                                           // 96
    return undefined;                                                                                            // 97
                                                                                                                 // 98
  check(options.resume, String);                                                                                 // 99
  var user = Meteor.users.findOne({                                                                              // 100
    "services.resume.loginTokens.token": ""+options.resume                                                       // 101
  });                                                                                                            // 102
  if (!user)                                                                                                     // 103
    throw new Meteor.Error(403, "Couldn't find login token");                                                    // 104
                                                                                                                 // 105
  return {                                                                                                       // 106
    token: options.resume,                                                                                       // 107
    id: user._id                                                                                                 // 108
  };                                                                                                             // 109
});                                                                                                              // 110
                                                                                                                 // 111
// Semi-public. Used by other login methods to generate tokens.                                                  // 112
//                                                                                                               // 113
Accounts._generateStampedLoginToken = function () {                                                              // 114
  return {token: Random.id(), when: +(new Date)};                                                                // 115
};                                                                                                               // 116
                                                                                                                 // 117
removeLoginToken = function (userId, loginToken) {                                                               // 118
  Meteor.users.update(userId, {                                                                                  // 119
    $pull: {                                                                                                     // 120
      "services.resume.loginTokens": { "token": loginToken }                                                     // 121
    }                                                                                                            // 122
  });                                                                                                            // 123
};                                                                                                               // 124
                                                                                                                 // 125
                                                                                                                 // 126
///                                                                                                              // 127
/// CREATE USER HOOKS                                                                                            // 128
///                                                                                                              // 129
                                                                                                                 // 130
var onCreateUserHook = null;                                                                                     // 131
Accounts.onCreateUser = function (func) {                                                                        // 132
  if (onCreateUserHook)                                                                                          // 133
    throw new Error("Can only call onCreateUser once");                                                          // 134
  else                                                                                                           // 135
    onCreateUserHook = func;                                                                                     // 136
};                                                                                                               // 137
                                                                                                                 // 138
// XXX see comment on Accounts.createUser in passwords_server about adding a                                     // 139
// second "server options" argument.                                                                             // 140
var defaultCreateUserHook = function (options, user) {                                                           // 141
  if (options.profile)                                                                                           // 142
    user.profile = options.profile;                                                                              // 143
  return user;                                                                                                   // 144
};                                                                                                               // 145
                                                                                                                 // 146
// Called by accounts-password                                                                                   // 147
Accounts.insertUserDoc = function (options, user) {                                                              // 148
  // - clone user document, to protect from modification                                                         // 149
  // - add createdAt timestamp                                                                                   // 150
  // - prepare an _id, so that you can modify other collections (eg                                              // 151
  // create a first task for every new user)                                                                     // 152
  //                                                                                                             // 153
  // XXX If the onCreateUser or validateNewUser hooks fail, we might                                             // 154
  // end up having modified some other collection                                                                // 155
  // inappropriately. The solution is probably to have onCreateUser                                              // 156
  // accept two callbacks - one that gets called before inserting                                                // 157
  // the user document (in which you can modify its contents), and                                               // 158
  // one that gets called after (in which you should change other                                                // 159
  // collections)                                                                                                // 160
  user = _.extend({createdAt: +(new Date), _id: Random.id()}, user);                                             // 161
                                                                                                                 // 162
  var result = {};                                                                                               // 163
  if (options.generateLoginToken) {                                                                              // 164
    var stampedToken = Accounts._generateStampedLoginToken();                                                    // 165
    result.token = stampedToken.token;                                                                           // 166
    Meteor._ensure(user, 'services', 'resume');                                                                  // 167
    if (_.has(user.services.resume, 'loginTokens'))                                                              // 168
      user.services.resume.loginTokens.push(stampedToken);                                                       // 169
    else                                                                                                         // 170
      user.services.resume.loginTokens = [stampedToken];                                                         // 171
  }                                                                                                              // 172
                                                                                                                 // 173
  var fullUser;                                                                                                  // 174
  if (onCreateUserHook) {                                                                                        // 175
    fullUser = onCreateUserHook(options, user);                                                                  // 176
                                                                                                                 // 177
    // This is *not* part of the API. We need this because we can't isolate                                      // 178
    // the global server environment between tests, meaning we can't test                                        // 179
    // both having a create user hook set and not having one set.                                                // 180
    if (fullUser === 'TEST DEFAULT HOOK')                                                                        // 181
      fullUser = defaultCreateUserHook(options, user);                                                           // 182
  } else {                                                                                                       // 183
    fullUser = defaultCreateUserHook(options, user);                                                             // 184
  }                                                                                                              // 185
                                                                                                                 // 186
  _.each(validateNewUserHooks, function (hook) {                                                                 // 187
    if (!hook(fullUser))                                                                                         // 188
      throw new Meteor.Error(403, "User validation failed");                                                     // 189
  });                                                                                                            // 190
                                                                                                                 // 191
  try {                                                                                                          // 192
    result.id = Meteor.users.insert(fullUser);                                                                   // 193
  } catch (e) {                                                                                                  // 194
    // XXX string parsing sucks, maybe                                                                           // 195
    // https://jira.mongodb.org/browse/SERVER-3069 will get fixed one day                                        // 196
    if (e.name !== 'MongoError') throw e;                                                                        // 197
    var match = e.err.match(/^E11000 duplicate key error index: ([^ ]+)/);                                       // 198
    if (!match) throw e;                                                                                         // 199
    if (match[1].indexOf('$emails.address') !== -1)                                                              // 200
      throw new Meteor.Error(403, "Email already exists.");                                                      // 201
    if (match[1].indexOf('username') !== -1)                                                                     // 202
      throw new Meteor.Error(403, "Username already exists.");                                                   // 203
    // XXX better error reporting for services.facebook.id duplicate, etc                                        // 204
    throw e;                                                                                                     // 205
  }                                                                                                              // 206
                                                                                                                 // 207
  return result;                                                                                                 // 208
};                                                                                                               // 209
                                                                                                                 // 210
var validateNewUserHooks = [];                                                                                   // 211
Accounts.validateNewUser = function (func) {                                                                     // 212
  validateNewUserHooks.push(func);                                                                               // 213
};                                                                                                               // 214
                                                                                                                 // 215
                                                                                                                 // 216
///                                                                                                              // 217
/// MANAGING USER OBJECTS                                                                                        // 218
///                                                                                                              // 219
                                                                                                                 // 220
// Updates or creates a user after we authenticate with a 3rd party.                                             // 221
//                                                                                                               // 222
// @param serviceName {String} Service name (eg, twitter).                                                       // 223
// @param serviceData {Object} Data to store in the user's record                                                // 224
//        under services[serviceName]. Must include an "id" field                                                // 225
//        which is a unique identifier for the user in the service.                                              // 226
// @param options {Object, optional} Other options to pass to insertUserDoc                                      // 227
//        (eg, profile)                                                                                          // 228
// @returns {Object} Object with token and id keys, like the result                                              // 229
//        of the "login" method.                                                                                 // 230
//                                                                                                               // 231
Accounts.updateOrCreateUserFromExternalService = function(                                                       // 232
  serviceName, serviceData, options) {                                                                           // 233
  options = _.clone(options || {});                                                                              // 234
                                                                                                                 // 235
  if (serviceName === "password" || serviceName === "resume")                                                    // 236
    throw new Error(                                                                                             // 237
      "Can't use updateOrCreateUserFromExternalService with internal service "                                   // 238
        + serviceName);                                                                                          // 239
  if (!_.has(serviceData, 'id'))                                                                                 // 240
    throw new Error(                                                                                             // 241
      "Service data for service " + serviceName + " must include id");                                           // 242
                                                                                                                 // 243
  // Look for a user with the appropriate service user id.                                                       // 244
  var selector = {};                                                                                             // 245
  var serviceIdKey = "services." + serviceName + ".id";                                                          // 246
                                                                                                                 // 247
  // XXX Temporary special case for Twitter. (Issue #629)                                                        // 248
  //   The serviceData.id will be a string representation of an integer.                                         // 249
  //   We want it to match either a stored string or int representation.                                         // 250
  //   This is to cater to earlier versions of Meteor storing twitter                                            // 251
  //   user IDs in number form, and recent versions storing them as strings.                                     // 252
  //   This can be removed once migration technology is in place, and twitter                                    // 253
  //   users stored with integer IDs have been migrated to string IDs.                                           // 254
  if (serviceName === "twitter" && !isNaN(serviceData.id)) {                                                     // 255
    selector["$or"] = [{},{}];                                                                                   // 256
    selector["$or"][0][serviceIdKey] = serviceData.id;                                                           // 257
    selector["$or"][1][serviceIdKey] = parseInt(serviceData.id, 10);                                             // 258
  } else {                                                                                                       // 259
    selector[serviceIdKey] = serviceData.id;                                                                     // 260
  }                                                                                                              // 261
                                                                                                                 // 262
  var user = Meteor.users.findOne(selector);                                                                     // 263
                                                                                                                 // 264
  if (user) {                                                                                                    // 265
    // We *don't* process options (eg, profile) for update, but we do replace                                    // 266
    // the serviceData (eg, so that we keep an unexpired access token and                                        // 267
    // don't cache old email addresses in serviceData.email).                                                    // 268
    // XXX provide an onUpdateUser hook which would let apps update                                              // 269
    //     the profile too                                                                                       // 270
    var stampedToken = Accounts._generateStampedLoginToken();                                                    // 271
    var setAttrs = {};                                                                                           // 272
    _.each(serviceData, function(value, key) {                                                                   // 273
      setAttrs["services." + serviceName + "." + key] = value;                                                   // 274
    });                                                                                                          // 275
                                                                                                                 // 276
    // XXX Maybe we should re-use the selector above and notice if the update                                    // 277
    //     touches nothing?                                                                                      // 278
    Meteor.users.update(                                                                                         // 279
      user._id,                                                                                                  // 280
      {$set: setAttrs,                                                                                           // 281
       $push: {'services.resume.loginTokens': stampedToken}});                                                   // 282
    return {token: stampedToken.token, id: user._id};                                                            // 283
  } else {                                                                                                       // 284
    // Create a new user with the service data. Pass other options through to                                    // 285
    // insertUserDoc.                                                                                            // 286
    user = {services: {}};                                                                                       // 287
    user.services[serviceName] = serviceData;                                                                    // 288
    options.generateLoginToken = true;                                                                           // 289
    return Accounts.insertUserDoc(options, user);                                                                // 290
  }                                                                                                              // 291
};                                                                                                               // 292
                                                                                                                 // 293
                                                                                                                 // 294
///                                                                                                              // 295
/// PUBLISHING DATA                                                                                              // 296
///                                                                                                              // 297
                                                                                                                 // 298
// Publish the current user's record to the client.                                                              // 299
Meteor.publish(null, function() {                                                                                // 300
  if (this.userId) {                                                                                             // 301
    return Meteor.users.find(                                                                                    // 302
      {_id: this.userId},                                                                                        // 303
      {fields: {profile: 1, username: 1, emails: 1}});                                                           // 304
  } else {                                                                                                       // 305
    return null;                                                                                                 // 306
  }                                                                                                              // 307
}, /*suppress autopublish warning*/{is_auto: true});                                                             // 308
                                                                                                                 // 309
// If autopublish is on, publish these user fields. Login service                                                // 310
// packages (eg accounts-google) add to these by calling                                                         // 311
// Accounts.addAutopublishFields Notably, this isn't implemented with                                            // 312
// multiple publishes since DDP only merges only across top-level                                                // 313
// fields, not subfields (such as 'services.facebook.accessToken')                                               // 314
var autopublishFields = {                                                                                        // 315
  loggedInUser: ['profile', 'username', 'emails'],                                                               // 316
  otherUsers: ['profile', 'username']                                                                            // 317
};                                                                                                               // 318
                                                                                                                 // 319
// Add to the list of fields or subfields to be automatically                                                    // 320
// published if autopublish is on. Must be called from top-level                                                 // 321
// code (ie, before Meteor.startup hooks run).                                                                   // 322
//                                                                                                               // 323
// @param opts {Object} with:                                                                                    // 324
//   - forLoggedInUser {Array} Array of fields published to the logged-in user                                   // 325
//   - forOtherUsers {Array} Array of fields published to users that aren't logged in                            // 326
Accounts.addAutopublishFields = function(opts) {                                                                 // 327
  autopublishFields.loggedInUser.push.apply(                                                                     // 328
    autopublishFields.loggedInUser, opts.forLoggedInUser);                                                       // 329
  autopublishFields.otherUsers.push.apply(                                                                       // 330
    autopublishFields.otherUsers, opts.forOtherUsers);                                                           // 331
};                                                                                                               // 332
                                                                                                                 // 333
if (Package.autopublish) {                                                                                       // 334
  // Use Meteor.startup to give other packages a chance to call                                                  // 335
  // addAutopublishFields.                                                                                       // 336
  Meteor.startup(function () {                                                                                   // 337
    // ['profile', 'username'] -> {profile: 1, username: 1}                                                      // 338
    var toFieldSelector = function(fields) {                                                                     // 339
      return _.object(_.map(fields, function(field) {                                                            // 340
        return [field, 1];                                                                                       // 341
      }));                                                                                                       // 342
    };                                                                                                           // 343
                                                                                                                 // 344
    Meteor.server.publish(null, function () {                                                                    // 345
      if (this.userId) {                                                                                         // 346
        return Meteor.users.find(                                                                                // 347
          {_id: this.userId},                                                                                    // 348
          {fields: toFieldSelector(autopublishFields.loggedInUser)});                                            // 349
      } else {                                                                                                   // 350
        return null;                                                                                             // 351
      }                                                                                                          // 352
    }, /*suppress autopublish warning*/{is_auto: true});                                                         // 353
                                                                                                                 // 354
    // XXX this publish is neither dedup-able nor is it optimized by our special                                 // 355
    // treatment of queries on a specific _id. Therefore this will have O(n^2)                                   // 356
    // run-time performance every time a user document is changed (eg someone                                    // 357
    // logging in). If this is a problem, we can instead write a manual publish                                  // 358
    // function which filters out fields based on 'this.userId'.                                                 // 359
    Meteor.server.publish(null, function () {                                                                    // 360
      var selector;                                                                                              // 361
      if (this.userId)                                                                                           // 362
        selector = {_id: {$ne: this.userId}};                                                                    // 363
      else                                                                                                       // 364
        selector = {};                                                                                           // 365
                                                                                                                 // 366
      return Meteor.users.find(                                                                                  // 367
        selector,                                                                                                // 368
        {fields: toFieldSelector(autopublishFields.otherUsers)});                                                // 369
    }, /*suppress autopublish warning*/{is_auto: true});                                                         // 370
  });                                                                                                            // 371
}                                                                                                                // 372
                                                                                                                 // 373
// Publish all login service configuration fields other than secret.                                             // 374
Meteor.publish("meteor.loginServiceConfiguration", function () {                                                 // 375
  return ServiceConfiguration.configurations.find({}, {fields: {secret: 0}});                                    // 376
}, {is_auto: true}); // not techincally autopublish, but stops the warning.                                      // 377
                                                                                                                 // 378
// Allow a one-time configuration for a login service. Modifications                                             // 379
// to this collection are also allowed in insecure mode.                                                         // 380
Meteor.methods({                                                                                                 // 381
  "configureLoginService": function (options) {                                                                  // 382
    check(options, Match.ObjectIncluding({service: String}));                                                    // 383
    // Don't let random users configure a service we haven't added yet (so                                       // 384
    // that when we do later add it, it's set up with their configuration                                        // 385
    // instead of ours).                                                                                         // 386
    // XXX if service configuration is oauth-specific then this code should                                      // 387
    //     be in accounts-oauth; if it's not then the registry should be                                         // 388
    //     in this package                                                                                       // 389
    if (!(Accounts.oauth                                                                                         // 390
          && _.contains(Accounts.oauth.serviceNames(), options.service))) {                                      // 391
      throw new Meteor.Error(403, "Service unknown");                                                            // 392
    }                                                                                                            // 393
    if (ServiceConfiguration.configurations.findOne({service: options.service}))                                 // 394
      throw new Meteor.Error(403, "Service " + options.service + " already configured");                         // 395
    ServiceConfiguration.configurations.insert(options);                                                         // 396
  }                                                                                                              // 397
});                                                                                                              // 398
                                                                                                                 // 399
                                                                                                                 // 400
///                                                                                                              // 401
/// RESTRICTING WRITES TO USER OBJECTS                                                                           // 402
///                                                                                                              // 403
                                                                                                                 // 404
Meteor.users.allow({                                                                                             // 405
  // clients can modify the profile field of their own document, and                                             // 406
  // nothing else.                                                                                               // 407
  update: function (userId, user, fields, modifier) {                                                            // 408
    // make sure it is our record                                                                                // 409
    if (user._id !== userId)                                                                                     // 410
      return false;                                                                                              // 411
                                                                                                                 // 412
    // user can only modify the 'profile' field. sets to multiple                                                // 413
    // sub-keys (eg profile.foo and profile.bar) are merged into entry                                           // 414
    // in the fields list.                                                                                       // 415
    if (fields.length !== 1 || fields[0] !== 'profile')                                                          // 416
      return false;                                                                                              // 417
                                                                                                                 // 418
    return true;                                                                                                 // 419
  },                                                                                                             // 420
  fetch: ['_id'] // we only look at _id.                                                                         // 421
});                                                                                                              // 422
                                                                                                                 // 423
/// DEFAULT INDEXES ON USERS                                                                                     // 424
Meteor.users._ensureIndex('username', {unique: 1, sparse: 1});                                                   // 425
Meteor.users._ensureIndex('emails.address', {unique: 1, sparse: 1});                                             // 426
Meteor.users._ensureIndex('services.resume.loginTokens.token',                                                   // 427
                          {unique: 1, sparse: 1});                                                               // 428
                                                                                                                 // 429
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                               //
// packages/accounts-base/url_server.js                                                                          //
//                                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                 //
// XXX These should probably not actually be public?                                                             // 1
                                                                                                                 // 2
Accounts.urls = {};                                                                                              // 3
                                                                                                                 // 4
Accounts.urls.resetPassword = function (token) {                                                                 // 5
  return Meteor.absoluteUrl('#/reset-password/' + token);                                                        // 6
};                                                                                                               // 7
                                                                                                                 // 8
Accounts.urls.verifyEmail = function (token) {                                                                   // 9
  return Meteor.absoluteUrl('#/verify-email/' + token);                                                          // 10
};                                                                                                               // 11
                                                                                                                 // 12
Accounts.urls.enrollAccount = function (token) {                                                                 // 13
  return Meteor.absoluteUrl('#/enroll-account/' + token);                                                        // 14
};                                                                                                               // 15
                                                                                                                 // 16
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);


/* Exports */
if (typeof Package === 'undefined') Package = {};
Package['accounts-base'] = {
  Accounts: Accounts
};

})();
