(function () {

/* Imports */
var Meteor = Package.meteor.Meteor;
var _ = Package.underscore._;

/* Package-scope variables */
var Email, EmailTest;

(function () {

/////////////////////////////////////////////////////////////////////////////////
//                                                                             //
// packages/email/email.js                                                     //
//                                                                             //
/////////////////////////////////////////////////////////////////////////////////
                                                                               //
var Future = Npm.require('fibers/future');                                     // 1
var urlModule = Npm.require('url');                                            // 2
var MailComposer = Npm.require('mailcomposer').MailComposer;                   // 3
                                                                               // 4
Email = {};                                                                    // 5
EmailTest = {};                                                                // 6
                                                                               // 7
var makePool = function (mailUrlString) {                                      // 8
  var mailUrl = urlModule.parse(mailUrlString);                                // 9
  if (mailUrl.protocol !== 'smtp:')                                            // 10
    throw new Error("Email protocol in $MAIL_URL (" +                          // 11
                    mailUrlString + ") must be 'smtp'");                       // 12
                                                                               // 13
  var port = +(mailUrl.port);                                                  // 14
  var auth = false;                                                            // 15
  if (mailUrl.auth) {                                                          // 16
    var parts = mailUrl.auth.split(':', 2);                                    // 17
    auth = {user: parts[0] && decodeURIComponent(parts[0]),                    // 18
            pass: parts[1] && decodeURIComponent(parts[1])};                   // 19
  }                                                                            // 20
                                                                               // 21
  var simplesmtp = Npm.require('simplesmtp');                                  // 22
  var pool = simplesmtp.createClientPool(                                      // 23
    port,  // Defaults to 25                                                   // 24
    mailUrl.hostname,  // Defaults to "localhost"                              // 25
    { secureConnection: (port === 465),                                        // 26
      // XXX allow maxConnections to be configured?                            // 27
      auth: auth });                                                           // 28
                                                                               // 29
  pool._future_wrapped_sendMail = _.bind(Future.wrap(pool.sendMail), pool);    // 30
  return pool;                                                                 // 31
};                                                                             // 32
                                                                               // 33
// We construct smtpPool at the first call to Email.send, so that              // 34
// Meteor.startup code can set $MAIL_URL.                                      // 35
var smtpPool = null;                                                           // 36
var maybeMakePool = function () {                                              // 37
  // We check MAIL_URL in case someone else set it in Meteor.startup code.     // 38
  var mailUrl = process.env.MAIL_URL ||                                        // 39
        (typeof __meteor_bootstrap__ !== 'undefined' &&                        // 40
         Meteor._get(__meteor_bootstrap__.deployConfig,                        // 41
                     'packages', 'email', 'url'));                             // 42
  if (!smtpPool && mailUrl) {                                                  // 43
    smtpPool = makePool(mailUrl);                                              // 44
  }                                                                            // 45
};                                                                             // 46
                                                                               // 47
var next_devmode_mail_id = 0;                                                  // 48
var output_stream = process.stdout;                                            // 49
                                                                               // 50
// Testing hooks                                                               // 51
EmailTest.overrideOutputStream = function (stream) {                           // 52
  next_devmode_mail_id = 0;                                                    // 53
  output_stream = stream;                                                      // 54
};                                                                             // 55
                                                                               // 56
EmailTest.restoreOutputStream = function () {                                  // 57
  output_stream = process.stdout;                                              // 58
};                                                                             // 59
                                                                               // 60
var devModeSend = function (mc) {                                              // 61
  var devmode_mail_id = next_devmode_mail_id++;                                // 62
                                                                               // 63
  // Make sure we use whatever stream was set at the time of the Email.send    // 64
  // call even in the 'end' callback, in case there are multiple concurrent    // 65
  // test runs.                                                                // 66
  var stream = output_stream;                                                  // 67
                                                                               // 68
  // This approach does not prevent other writers to stdout from interleaving. // 69
  stream.write("====== BEGIN MAIL #" + devmode_mail_id + " ======\n");         // 70
  mc.streamMessage();                                                          // 71
  mc.pipe(stream, {end: false});                                               // 72
  var future = new Future;                                                     // 73
  mc.on('end', function () {                                                   // 74
    stream.write("====== END MAIL #" + devmode_mail_id + " ======\n");         // 75
    future['return']();                                                        // 76
  });                                                                          // 77
  future.wait();                                                               // 78
};                                                                             // 79
                                                                               // 80
var smtpSend = function (mc) {                                                 // 81
  smtpPool._future_wrapped_sendMail(mc).wait();                                // 82
};                                                                             // 83
                                                                               // 84
/**                                                                            // 85
 * Mock out email sending (eg, during a test.) This is private for now.        // 86
 *                                                                             // 87
 * f receives the arguments to Email.send and should return true to go         // 88
 * ahead and send the email (or at least, try subsequent hooks), or            // 89
 * false to skip sending.                                                      // 90
 */                                                                            // 91
var sendHooks = [];                                                            // 92
EmailTest.hookSend = function (f) {                                            // 93
  sendHooks.push(f);                                                           // 94
};                                                                             // 95
                                                                               // 96
/**                                                                            // 97
 * Send an email.                                                              // 98
 *                                                                             // 99
 * Connects to the mail server configured via the MAIL_URL environment         // 100
 * variable. If unset, prints formatted message to stdout. The "from" option   // 101
 * is required, and at least one of "to", "cc", and "bcc" must be provided;    // 102
 * all other options are optional.                                             // 103
 *                                                                             // 104
 * @param options                                                              // 105
 * @param options.from {String} RFC5322 "From:" address                        // 106
 * @param options.to {String|String[]} RFC5322 "To:" address[es]               // 107
 * @param options.cc {String|String[]} RFC5322 "Cc:" address[es]               // 108
 * @param options.bcc {String|String[]} RFC5322 "Bcc:" address[es]             // 109
 * @param options.replyTo {String|String[]} RFC5322 "Reply-To:" address[es]    // 110
 * @param options.subject {String} RFC5322 "Subject:" line                     // 111
 * @param options.text {String} RFC5322 mail body (plain text)                 // 112
 * @param options.html {String} RFC5322 mail body (HTML)                       // 113
 * @param options.headers {Object} custom RFC5322 headers (dictionary)         // 114
 */                                                                            // 115
Email.send = function (options) {                                              // 116
  for (var i = 0; i < sendHooks.length; i++)                                   // 117
    if (! sendHooks[i](options))                                               // 118
      return;                                                                  // 119
                                                                               // 120
  var mc = new MailComposer();                                                 // 121
                                                                               // 122
  // setup message data                                                        // 123
  // XXX support attachments (once we have a client/server-compatible binary   // 124
  //     Buffer class)                                                         // 125
  mc.setMessageOption({                                                        // 126
    from: options.from,                                                        // 127
    to: options.to,                                                            // 128
    cc: options.cc,                                                            // 129
    bcc: options.bcc,                                                          // 130
    replyTo: options.replyTo,                                                  // 131
    subject: options.subject,                                                  // 132
    text: options.text,                                                        // 133
    html: options.html                                                         // 134
  });                                                                          // 135
                                                                               // 136
  _.each(options.headers, function (value, name) {                             // 137
    mc.addHeader(name, value);                                                 // 138
  });                                                                          // 139
                                                                               // 140
  maybeMakePool();                                                             // 141
                                                                               // 142
  if (smtpPool) {                                                              // 143
    smtpSend(mc);                                                              // 144
  } else {                                                                     // 145
    devModeSend(mc);                                                           // 146
  }                                                                            // 147
};                                                                             // 148
                                                                               // 149
                                                                               // 150
/////////////////////////////////////////////////////////////////////////////////

}).call(this);


/* Exports */
if (typeof Package === 'undefined') Package = {};
Package.email = {
  Email: Email,
  EmailTest: EmailTest
};

})();
