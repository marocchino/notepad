require('coffee-script');
var server = require('./app');
var port = process.env.PORT || "3000";
if (!module.parent) {
  server.listen(port);
  console.log("Express server listening on port %d in %s mode", server.address().port, server.settings.env);
}
