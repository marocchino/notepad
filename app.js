
/**
 * Module dependencies.
 */
require('coffee-script');
var express = require('express');
var routes = require('./routes');
var app = module.exports = express.createServer();


// Models
var Document = require('./models/document');

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
  app.use(express.errorHandler());
});

// Routes

app.get('/', routes.index);

// Document list
app.get('/documents', function(req, res) {
  console.log('GET /documents');
  Document.find({},function(err, documents) {
    res.render('documents/index.jade', {
      title: 'documents index',
      documents: documents
    });
  });
});

app.get('/documents/new', function(req, res) {
  console.log('GET /documents/new');
  res.render('documents/new.jade', {
    title: 'new document',
    document: new Document()
  });
});

app.post('/documents', function(req, res) {
  console.log('POST /documents');
  var document = new Document(req.body['document']);
  document.save(function(err) {
    if (!err) {
      res.redirect('/documents');
    } else {
      console.log(err)
      res.render('documents/new.jade', {
        title: 'new document',
        document: document
      });
    };
  });
});

if (!module.parent) {
  app.listen(3000);
  console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
}
