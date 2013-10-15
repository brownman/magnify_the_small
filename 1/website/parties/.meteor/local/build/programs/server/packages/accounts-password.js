(function () {

/* Imports */
var Meteor = Package.meteor.Meteor;
var Accounts = Package['accounts-base'].Accounts;
var SRP = Package.srp.SRP;
var Email = Package.email.Email;
var Random = Package.random.Random;
var check = Package.check.check;
var Match = Package.check.Match;
var _ = Package.underscore._;
var DDP = Package.livedata.DDP;
var DDPServer = Package.livedata.DDPServer;

(function () {

/////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                         //
// packages/accounts-password/email_templates.js                                           //
//                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////
                                                                                           //
Accounts.emailTemplates = {                                                                // 1
  from: "Meteor Accounts <no-reply@meteor.com>",                                           // 2
  siteName: Meteor.absoluteUrl().replace(/^https?:\/\//, '').replace(/\/$/, ''),           // 3
                                                                                           // 4
  resetPassword: {                                                                         // 5
    subject: function(user) {                                                              // 6
      return "How to reset your password on " + Accounts.emailTemplates.siteName;          // 7
    },                                                                                     // 8
    text: function(user, url) {                                                            // 9
      var greeting = (user.profile && user.profile.name) ?                                 // 10
            ("Hello " + user.profile.name + ",") : "Hello,";                               // 11
      return greeting + "\n"                                                               // 12
        + "\n"                                                                             // 13
        + "To reset your password, simply click the link below.\n"                         // 14
        + "\n"                                                                             // 15
        + url + "\n"                                                                       // 16
        + "\n"                                                                             // 17
        + "Thanks.\n";                                                                     // 18
    }                                                                                      // 19
  },                                                                                       // 20
  verifyEmail: {                                                                           // 21
    subject: function(user) {                                                              // 22
      return "How to verify email address on " + Accounts.emailTemplates.siteName;         // 23
    },                                                                                     // 24
    text: function(user, url) {                                                            // 25
      var greeting = (user.profile && user.profile.name) ?                                 // 26
            ("Hello " + user.profile.name + ",") : "Hello,";                               // 27
      return greeting + "\n"                                                               // 28
        + "\n"                                                                             // 29
        + "To verify your account email, simply click the link below.\n"                   // 30
        + "\n"                                                                             // 31
        + url + "\n"                                                                       // 32
        + "\n"                                                                             // 33
        + "Thanks.\n";                                                                     // 34
    }                                                                                      // 35
  },                                                                                       // 36
  enrollAccount: {                                                                         // 37
    subject: function(user) {                                                              // 38
      return "An account has been created for you on " + Accounts.emailTemplates.siteName; // 39
    },                                                                                     // 40
    text: function(user, url) {                                                            // 41
      var greeting = (user.profile && user.profile.name) ?                                 // 42
            ("Hello " + user.profile.name + ",") : "Hello,";                               // 43
      return greeting + "\n"                                                               // 44
        + "\n"                                                                             // 45
        + "To start using the service, simply click the link below.\n"                     // 46
        + "\n"                                                                             // 47
        + url + "\n"                                                                       // 48
        + "\n"                                                                             // 49
        + "Thanks.\n";                                                                     // 50
    }                                                                                      // 51
  }                                                                                        // 52
};                                                                                         // 53
                                                                                           // 54
/////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

/////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                         //
// packages/accounts-password/password_server.js                                           //
//                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////
                                                                                           //
///                                                                                        // 1
/// LOGIN                                                                                  // 2
///                                                                                        // 3
                                                                                           // 4
// Users can specify various keys to identify themselves with.                             // 5
// @param user {Object} with one of `id`, `username`, or `email`.                          // 6
// @returns A selector to pass to mongo to get the user record.                            // 7
                                                                                           // 8
var selectorFromUserQuery = function (user) {                                              // 9
  if (user.id)                                                                             // 10
    return {_id: user.id};                                                                 // 11
  else if (user.username)                                                                  // 12
    return {username: user.username};                                                      // 13
  else if (user.email)                                                                     // 14
    return {"emails.address": user.email};                                                 // 15
  throw new Error("shouldn't happen (validation missed something)");                       // 16
};                                                                                         // 17
                                                                                           // 18
// XXX maybe this belongs in the check package                                             // 19
var NonEmptyString = Match.Where(function (x) {                                            // 20
  check(x, String);                                                                        // 21
  return x.length > 0;                                                                     // 22
});                                                                                        // 23
                                                                                           // 24
var userQueryValidator = Match.Where(function (user) {                                     // 25
  check(user, {                                                                            // 26
    id: Match.Optional(NonEmptyString),                                                    // 27
    username: Match.Optional(NonEmptyString),                                              // 28
    email: Match.Optional(NonEmptyString)                                                  // 29
  });                                                                                      // 30
  if (_.keys(user).length !== 1)                                                           // 31
    throw new Match.Error("User property must have exactly one field");                    // 32
  return true;                                                                             // 33
});                                                                                        // 34
                                                                                           // 35
// Step 1 of SRP password exchange. This puts an `M` value in the                          // 36
// session data for this connection. If a client later sends the same                      // 37
// `M` value to a method on this connection, it proves they know the                       // 38
// password for this user. We can then prove we know the password to                       // 39
// them by sending our `HAMK` value.                                                       // 40
//                                                                                         // 41
// @param request {Object} with fields:                                                    // 42
//   user: either {username: (username)}, {email: (email)}, or {id: (userId)}              // 43
//   A: hex encoded int. the client's public key for this exchange                         // 44
// @returns {Object} with fields:                                                          // 45
//   identity: random string ID                                                            // 46
//   salt: random string ID                                                                // 47
//   B: hex encoded int. server's public key for this exchange                             // 48
Meteor.methods({beginPasswordExchange: function (request) {                                // 49
  check(request, {                                                                         // 50
    user: userQueryValidator,                                                              // 51
    A: String                                                                              // 52
  });                                                                                      // 53
  var selector = selectorFromUserQuery(request.user);                                      // 54
                                                                                           // 55
  var user = Meteor.users.findOne(selector);                                               // 56
  if (!user)                                                                               // 57
    throw new Meteor.Error(403, "User not found");                                         // 58
                                                                                           // 59
  if (!user.services || !user.services.password ||                                         // 60
      !user.services.password.srp)                                                         // 61
    throw new Meteor.Error(403, "User has no password set");                               // 62
                                                                                           // 63
  var verifier = user.services.password.srp;                                               // 64
  var srp = new SRP.Server(verifier);                                                      // 65
  var challenge = srp.issueChallenge({A: request.A});                                      // 66
                                                                                           // 67
  // save off results in the current session so we can verify them                         // 68
  // later.                                                                                // 69
  this._sessionData.srpChallenge =                                                         // 70
    { userId: user._id, M: srp.M, HAMK: srp.HAMK };                                        // 71
                                                                                           // 72
  return challenge;                                                                        // 73
}});                                                                                       // 74
                                                                                           // 75
// Handler to login with password via SRP. Checks the `M` value set by                     // 76
// beginPasswordExchange.                                                                  // 77
Accounts.registerLoginHandler(function (options) {                                         // 78
  if (!options.srp)                                                                        // 79
    return undefined; // don't handle                                                      // 80
  check(options.srp, {M: String});                                                         // 81
                                                                                           // 82
  // we're always called from within a 'login' method, so this should                      // 83
  // be safe.                                                                              // 84
  var currentInvocation = DDP._CurrentInvocation.get();                                    // 85
  var serialized = currentInvocation._sessionData.srpChallenge;                            // 86
  if (!serialized || serialized.M !== options.srp.M)                                       // 87
    throw new Meteor.Error(403, "Incorrect password");                                     // 88
  // Only can use challenges once.                                                         // 89
  delete currentInvocation._sessionData.srpChallenge;                                      // 90
                                                                                           // 91
  var userId = serialized.userId;                                                          // 92
  var user = Meteor.users.findOne(userId);                                                 // 93
  // Was the user deleted since the start of this challenge?                               // 94
  if (!user)                                                                               // 95
    throw new Meteor.Error(403, "User not found");                                         // 96
  var stampedLoginToken = Accounts._generateStampedLoginToken();                           // 97
  Meteor.users.update(                                                                     // 98
    userId, {$push: {'services.resume.loginTokens': stampedLoginToken}});                  // 99
                                                                                           // 100
  return {token: stampedLoginToken.token, id: userId, HAMK: serialized.HAMK};              // 101
});                                                                                        // 102
                                                                                           // 103
// Handler to login with plaintext password.                                               // 104
//                                                                                         // 105
// The meteor client doesn't use this, it is for other DDP clients who                     // 106
// haven't implemented SRP. Since it sends the password in plaintext                       // 107
// over the wire, it should only be run over SSL!                                          // 108
//                                                                                         // 109
// Also, it might be nice if servers could turn this off. Or maybe it                      // 110
// should be opt-in, not opt-out? Accounts.config option?                                  // 111
Accounts.registerLoginHandler(function (options) {                                         // 112
  if (!options.password || !options.user)                                                  // 113
    return undefined; // don't handle                                                      // 114
                                                                                           // 115
  check(options, {user: userQueryValidator, password: String});                            // 116
                                                                                           // 117
  var selector = selectorFromUserQuery(options.user);                                      // 118
  var user = Meteor.users.findOne(selector);                                               // 119
  if (!user)                                                                               // 120
    throw new Meteor.Error(403, "User not found");                                         // 121
                                                                                           // 122
  if (!user.services || !user.services.password ||                                         // 123
      !user.services.password.srp)                                                         // 124
    throw new Meteor.Error(403, "User has no password set");                               // 125
                                                                                           // 126
  // Just check the verifier output when the same identity and salt                        // 127
  // are passed. Don't bother with a full exchange.                                        // 128
  var verifier = user.services.password.srp;                                               // 129
  var newVerifier = SRP.generateVerifier(options.password, {                               // 130
    identity: verifier.identity, salt: verifier.salt});                                    // 131
                                                                                           // 132
  if (verifier.verifier !== newVerifier.verifier)                                          // 133
    throw new Meteor.Error(403, "Incorrect password");                                     // 134
                                                                                           // 135
  var stampedLoginToken = Accounts._generateStampedLoginToken();                           // 136
  Meteor.users.update(                                                                     // 137
    user._id, {$push: {'services.resume.loginTokens': stampedLoginToken}});                // 138
                                                                                           // 139
  return {token: stampedLoginToken.token, id: user._id};                                   // 140
});                                                                                        // 141
                                                                                           // 142
                                                                                           // 143
///                                                                                        // 144
/// CHANGING                                                                               // 145
///                                                                                        // 146
                                                                                           // 147
// Let the user change their own password if they know the old                             // 148
// password. Checks the `M` value set by beginPasswordExchange.                            // 149
Meteor.methods({changePassword: function (options) {                                       // 150
  if (!this.userId)                                                                        // 151
    throw new Meteor.Error(401, "Must be logged in");                                      // 152
  check(options, {                                                                         // 153
    // If options.M is set, it means we went through a challenge with the old              // 154
    // password. For now, we don't allow changePassword without knowing the old            // 155
    // password.                                                                           // 156
    M: String,                                                                             // 157
    srp: Match.Optional(SRP.matchVerifier),                                                // 158
    password: Match.Optional(String)                                                       // 159
  });                                                                                      // 160
                                                                                           // 161
  var serialized = this._sessionData.srpChallenge;                                         // 162
  if (!serialized || serialized.M !== options.M)                                           // 163
    throw new Meteor.Error(403, "Incorrect password");                                     // 164
  if (serialized.userId !== this.userId)                                                   // 165
    // No monkey business!                                                                 // 166
    throw new Meteor.Error(403, "Incorrect password");                                     // 167
  // Only can use challenges once.                                                         // 168
  delete this._sessionData.srpChallenge;                                                   // 169
                                                                                           // 170
  var verifier = options.srp;                                                              // 171
  if (!verifier && options.password) {                                                     // 172
    verifier = SRP.generateVerifier(options.password);                                     // 173
  }                                                                                        // 174
  if (!verifier)                                                                           // 175
    throw new Meteor.Error(400, "Invalid verifier");                                       // 176
                                                                                           // 177
  // XXX this should invalidate all login tokens other than the current one                // 178
  // (or it should assign a new login token, replacing existing ones)                      // 179
  Meteor.users.update({_id: this.userId},                                                  // 180
                      {$set: {'services.password.srp': verifier}});                        // 181
                                                                                           // 182
  var ret = {passwordChanged: true};                                                       // 183
  if (serialized)                                                                          // 184
    ret.HAMK = serialized.HAMK;                                                            // 185
  return ret;                                                                              // 186
}});                                                                                       // 187
                                                                                           // 188
                                                                                           // 189
// Force change the users password.                                                        // 190
Accounts.setPassword = function (userId, newPassword) {                                    // 191
  var user = Meteor.users.findOne(userId);                                                 // 192
  if (!user)                                                                               // 193
    throw new Meteor.Error(403, "User not found");                                         // 194
  var newVerifier = SRP.generateVerifier(newPassword);                                     // 195
                                                                                           // 196
  Meteor.users.update({_id: user._id}, {                                                   // 197
    $set: {'services.password.srp': newVerifier}});                                        // 198
};                                                                                         // 199
                                                                                           // 200
                                                                                           // 201
///                                                                                        // 202
/// RESETTING VIA EMAIL                                                                    // 203
///                                                                                        // 204
                                                                                           // 205
// Method called by a user to request a password reset email. This is                      // 206
// the start of the reset process.                                                         // 207
Meteor.methods({forgotPassword: function (options) {                                       // 208
  check(options, {email: String});                                                         // 209
                                                                                           // 210
  var user = Meteor.users.findOne({"emails.address": options.email});                      // 211
  if (!user)                                                                               // 212
    throw new Meteor.Error(403, "User not found");                                         // 213
                                                                                           // 214
  Accounts.sendResetPasswordEmail(user._id, options.email);                                // 215
}});                                                                                       // 216
                                                                                           // 217
// send the user an email with a link that when opened allows the user                     // 218
// to set a new password, without the old password.                                        // 219
//                                                                                         // 220
Accounts.sendResetPasswordEmail = function (userId, email) {                               // 221
  // Make sure the user exists, and email is one of their addresses.                       // 222
  var user = Meteor.users.findOne(userId);                                                 // 223
  if (!user)                                                                               // 224
    throw new Error("Can't find user");                                                    // 225
  // pick the first email if we weren't passed an email.                                   // 226
  if (!email && user.emails && user.emails[0])                                             // 227
    email = user.emails[0].address;                                                        // 228
  // make sure we have a valid email                                                       // 229
  if (!email || !_.contains(_.pluck(user.emails || [], 'address'), email))                 // 230
    throw new Error("No such email for user.");                                            // 231
                                                                                           // 232
  var token = Random.id();                                                                 // 233
  var when = +(new Date);                                                                  // 234
  Meteor.users.update(userId, {$set: {                                                     // 235
    "services.password.reset": {                                                           // 236
      token: token,                                                                        // 237
      email: email,                                                                        // 238
      when: when                                                                           // 239
    }                                                                                      // 240
  }});                                                                                     // 241
                                                                                           // 242
  var resetPasswordUrl = Accounts.urls.resetPassword(token);                               // 243
  Email.send({                                                                             // 244
    to: email,                                                                             // 245
    from: Accounts.emailTemplates.from,                                                    // 246
    subject: Accounts.emailTemplates.resetPassword.subject(user),                          // 247
    text: Accounts.emailTemplates.resetPassword.text(user, resetPasswordUrl)});            // 248
};                                                                                         // 249
                                                                                           // 250
// send the user an email informing them that their account was created, with              // 251
// a link that when opened both marks their email as verified and forces them              // 252
// to choose their password. The email must be one of the addresses in the                 // 253
// user's emails field, or undefined to pick the first email automatically.                // 254
//                                                                                         // 255
// This is not called automatically. It must be called manually if you                     // 256
// want to use enrollment emails.                                                          // 257
//                                                                                         // 258
Accounts.sendEnrollmentEmail = function (userId, email) {                                  // 259
  // XXX refactor! This is basically identical to sendResetPasswordEmail.                  // 260
                                                                                           // 261
  // Make sure the user exists, and email is in their addresses.                           // 262
  var user = Meteor.users.findOne(userId);                                                 // 263
  if (!user)                                                                               // 264
    throw new Error("Can't find user");                                                    // 265
  // pick the first email if we weren't passed an email.                                   // 266
  if (!email && user.emails && user.emails[0])                                             // 267
    email = user.emails[0].address;                                                        // 268
  // make sure we have a valid email                                                       // 269
  if (!email || !_.contains(_.pluck(user.emails || [], 'address'), email))                 // 270
    throw new Error("No such email for user.");                                            // 271
                                                                                           // 272
                                                                                           // 273
  var token = Random.id();                                                                 // 274
  var when = +(new Date);                                                                  // 275
  Meteor.users.update(userId, {$set: {                                                     // 276
    "services.password.reset": {                                                           // 277
      token: token,                                                                        // 278
      email: email,                                                                        // 279
      when: when                                                                           // 280
    }                                                                                      // 281
  }});                                                                                     // 282
                                                                                           // 283
  var enrollAccountUrl = Accounts.urls.enrollAccount(token);                               // 284
  Email.send({                                                                             // 285
    to: email,                                                                             // 286
    from: Accounts.emailTemplates.from,                                                    // 287
    subject: Accounts.emailTemplates.enrollAccount.subject(user),                          // 288
    text: Accounts.emailTemplates.enrollAccount.text(user, enrollAccountUrl)               // 289
  });                                                                                      // 290
};                                                                                         // 291
                                                                                           // 292
                                                                                           // 293
// Take token from sendResetPasswordEmail or sendEnrollmentEmail, change                   // 294
// the users password, and log them in.                                                    // 295
Meteor.methods({resetPassword: function (token, newVerifier) {                             // 296
  check(token, String);                                                                    // 297
  check(newVerifier, SRP.matchVerifier);                                                   // 298
                                                                                           // 299
  var user = Meteor.users.findOne({                                                        // 300
    "services.password.reset.token": ""+token});                                           // 301
  if (!user)                                                                               // 302
    throw new Meteor.Error(403, "Token expired");                                          // 303
  var email = user.services.password.reset.email;                                          // 304
  if (!_.include(_.pluck(user.emails || [], 'address'), email))                            // 305
    throw new Meteor.Error(403, "Token has invalid email address");                        // 306
                                                                                           // 307
  var stampedLoginToken = Accounts._generateStampedLoginToken();                           // 308
                                                                                           // 309
  // Update the user record by:                                                            // 310
  // - Changing the password verifier to the new one                                       // 311
  // - Replacing all valid login tokens with new ones (changing                            // 312
  //   password should invalidate existing sessions).                                      // 313
  // - Forgetting about the reset token that was just used                                 // 314
  // - Verifying their email, since they got the password reset via email.                 // 315
  Meteor.users.update({_id: user._id, 'emails.address': email}, {                          // 316
    $set: {'services.password.srp': newVerifier,                                           // 317
           'services.resume.loginTokens': [stampedLoginToken],                             // 318
           'emails.$.verified': true},                                                     // 319
    $unset: {'services.password.reset': 1}                                                 // 320
  });                                                                                      // 321
                                                                                           // 322
  this.setUserId(user._id);                                                                // 323
  return {token: stampedLoginToken.token, id: user._id};                                   // 324
}});                                                                                       // 325
                                                                                           // 326
///                                                                                        // 327
/// EMAIL VERIFICATION                                                                     // 328
///                                                                                        // 329
                                                                                           // 330
                                                                                           // 331
// send the user an email with a link that when opened marks that                          // 332
// address as verified                                                                     // 333
//                                                                                         // 334
Accounts.sendVerificationEmail = function (userId, address) {                              // 335
  // XXX Also generate a link using which someone can delete this                          // 336
  // account if they own said address but weren't those who created                        // 337
  // this account.                                                                         // 338
                                                                                           // 339
  // Make sure the user exists, and address is one of their addresses.                     // 340
  var user = Meteor.users.findOne(userId);                                                 // 341
  if (!user)                                                                               // 342
    throw new Error("Can't find user");                                                    // 343
  // pick the first unverified address if we weren't passed an address.                    // 344
  if (!address) {                                                                          // 345
    var email = _.find(user.emails || [],                                                  // 346
                       function (e) { return !e.verified; });                              // 347
    address = (email || {}).address;                                                       // 348
  }                                                                                        // 349
  // make sure we have a valid address                                                     // 350
  if (!address || !_.contains(_.pluck(user.emails || [], 'address'), address))             // 351
    throw new Error("No such email address for user.");                                    // 352
                                                                                           // 353
                                                                                           // 354
  var tokenRecord = {                                                                      // 355
    token: Random.id(),                                                                    // 356
    address: address,                                                                      // 357
    when: +(new Date)};                                                                    // 358
  Meteor.users.update(                                                                     // 359
    {_id: userId},                                                                         // 360
    {$push: {'services.email.verificationTokens': tokenRecord}});                          // 361
                                                                                           // 362
  var verifyEmailUrl = Accounts.urls.verifyEmail(tokenRecord.token);                       // 363
  Email.send({                                                                             // 364
    to: address,                                                                           // 365
    from: Accounts.emailTemplates.from,                                                    // 366
    subject: Accounts.emailTemplates.verifyEmail.subject(user),                            // 367
    text: Accounts.emailTemplates.verifyEmail.text(user, verifyEmailUrl)                   // 368
  });                                                                                      // 369
};                                                                                         // 370
                                                                                           // 371
// Take token from sendVerificationEmail, mark the email as verified,                      // 372
// and log them in.                                                                        // 373
Meteor.methods({verifyEmail: function (token) {                                            // 374
  check(token, String);                                                                    // 375
                                                                                           // 376
  var user = Meteor.users.findOne(                                                         // 377
    {'services.email.verificationTokens.token': token});                                   // 378
  if (!user)                                                                               // 379
    throw new Meteor.Error(403, "Verify email link expired");                              // 380
                                                                                           // 381
  var tokenRecord = _.find(user.services.email.verificationTokens,                         // 382
                           function (t) {                                                  // 383
                             return t.token == token;                                      // 384
                           });                                                             // 385
  if (!tokenRecord)                                                                        // 386
    throw new Meteor.Error(403, "Verify email link expired");                              // 387
                                                                                           // 388
  var emailsRecord = _.find(user.emails, function (e) {                                    // 389
    return e.address == tokenRecord.address;                                               // 390
  });                                                                                      // 391
  if (!emailsRecord)                                                                       // 392
    throw new Meteor.Error(403, "Verify email link is for unknown address");               // 393
                                                                                           // 394
  // Log the user in with a new login token.                                               // 395
  var stampedLoginToken = Accounts._generateStampedLoginToken();                           // 396
                                                                                           // 397
  // By including the address in the query, we can use 'emails.$' in the                   // 398
  // modifier to get a reference to the specific object in the emails                      // 399
  // array. See                                                                            // 400
  // http://www.mongodb.org/display/DOCS/Updating/#Updating-The%24positionaloperator)      // 401
  // http://www.mongodb.org/display/DOCS/Updating#Updating-%24pull                         // 402
  Meteor.users.update(                                                                     // 403
    {_id: user._id,                                                                        // 404
     'emails.address': tokenRecord.address},                                               // 405
    {$set: {'emails.$.verified': true},                                                    // 406
     $pull: {'services.email.verificationTokens': {token: token}},                         // 407
     $push: {'services.resume.loginTokens': stampedLoginToken}});                          // 408
                                                                                           // 409
  this.setUserId(user._id);                                                                // 410
  return {token: stampedLoginToken.token, id: user._id};                                   // 411
}});                                                                                       // 412
                                                                                           // 413
                                                                                           // 414
                                                                                           // 415
///                                                                                        // 416
/// CREATING USERS                                                                         // 417
///                                                                                        // 418
                                                                                           // 419
// Shared createUser function called from the createUser method, both                      // 420
// if originates in client or server code. Calls user provided hooks,                      // 421
// does the actual user insertion.                                                         // 422
//                                                                                         // 423
// returns an object with id: userId, and (if options.generateLoginToken is                // 424
// set) token: loginToken.                                                                 // 425
var createUser = function (options) {                                                      // 426
  // Unknown keys allowed, because a onCreateUserHook can take arbitrary                   // 427
  // options.                                                                              // 428
  check(options, Match.ObjectIncluding({                                                   // 429
    generateLoginToken: Boolean,                                                           // 430
    username: Match.Optional(String),                                                      // 431
    email: Match.Optional(String),                                                         // 432
    password: Match.Optional(String),                                                      // 433
    srp: Match.Optional(SRP.matchVerifier)                                                 // 434
  }));                                                                                     // 435
                                                                                           // 436
  var username = options.username;                                                         // 437
  var email = options.email;                                                               // 438
  if (!username && !email)                                                                 // 439
    throw new Meteor.Error(400, "Need to set a username or email");                        // 440
                                                                                           // 441
  // Raw password. The meteor client doesn't send this, but a DDP                          // 442
  // client that didn't implement SRP could send this. This should                         // 443
  // only be done over SSL.                                                                // 444
  if (options.password) {                                                                  // 445
    if (options.srp)                                                                       // 446
      throw new Meteor.Error(400, "Don't pass both password and srp in options");          // 447
    options.srp = SRP.generateVerifier(options.password);                                  // 448
  }                                                                                        // 449
                                                                                           // 450
  var user = {services: {}};                                                               // 451
  if (options.srp)                                                                         // 452
    user.services.password = {srp: options.srp}; // XXX validate verifier                  // 453
  if (username)                                                                            // 454
    user.username = username;                                                              // 455
  if (email)                                                                               // 456
    user.emails = [{address: email, verified: false}];                                     // 457
                                                                                           // 458
  return Accounts.insertUserDoc(options, user);                                            // 459
};                                                                                         // 460
                                                                                           // 461
// method for create user. Requests come from the client.                                  // 462
Meteor.methods({createUser: function (options) {                                           // 463
  // createUser() above does more checking.                                                // 464
  check(options, Object);                                                                  // 465
  options.generateLoginToken = true;                                                       // 466
  if (Accounts._options.forbidClientAccountCreation)                                       // 467
    throw new Meteor.Error(403, "Signups forbidden");                                      // 468
                                                                                           // 469
  // Create user. result contains id and token.                                            // 470
  var result = createUser(options);                                                        // 471
  // safety belt. createUser is supposed to throw on error. send 500 error                 // 472
  // instead of sending a verification email with empty userid.                            // 473
  if (!result.id)                                                                          // 474
    throw new Error("createUser failed to insert new user");                               // 475
                                                                                           // 476
  // If `Accounts._options.sendVerificationEmail` is set, register                         // 477
  // a token to verify the user's primary email, and send it to                            // 478
  // that address.                                                                         // 479
  if (options.email && Accounts._options.sendVerificationEmail)                            // 480
    Accounts.sendVerificationEmail(result.id, options.email);                              // 481
                                                                                           // 482
  // client gets logged in as the new user afterwards.                                     // 483
  this.setUserId(result.id);                                                               // 484
  return result;                                                                           // 485
}});                                                                                       // 486
                                                                                           // 487
// Create user directly on the server.                                                     // 488
//                                                                                         // 489
// Unlike the client version, this does not log you in as this user                        // 490
// after creation.                                                                         // 491
//                                                                                         // 492
// returns userId or throws an error if it can't create                                    // 493
//                                                                                         // 494
// XXX add another argument ("server options") that gets sent to onCreateUser,             // 495
// which is always empty when called from the createUser method? eg, "admin:               // 496
// true", which we want to prevent the client from setting, but which a custom             // 497
// method calling Accounts.createUser could set?                                           // 498
//                                                                                         // 499
Accounts.createUser = function (options, callback) {                                       // 500
  options = _.clone(options);                                                              // 501
  options.generateLoginToken = false;                                                      // 502
                                                                                           // 503
  // XXX allow an optional callback?                                                       // 504
  if (callback) {                                                                          // 505
    throw new Error("Accounts.createUser with callback not supported on the server yet."); // 506
  }                                                                                        // 507
                                                                                           // 508
  var userId = createUser(options).id;                                                     // 509
                                                                                           // 510
  return userId;                                                                           // 511
};                                                                                         // 512
                                                                                           // 513
///                                                                                        // 514
/// PASSWORD-SPECIFIC INDEXES ON USERS                                                     // 515
///                                                                                        // 516
Meteor.users._ensureIndex('emails.validationTokens.token',                                 // 517
                          {unique: 1, sparse: 1});                                         // 518
Meteor.users._ensureIndex('emails.password.reset.token',                                   // 519
                          {unique: 1, sparse: 1});                                         // 520
                                                                                           // 521
/////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);


/* Exports */
if (typeof Package === 'undefined') Package = {};
Package['accounts-password'] = {};

})();
