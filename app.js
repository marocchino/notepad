
/**
 * Module dependencies.
 */
require('coffee-script');
var express = require('express');
var routes = require('./routes');
var app = module.exports = express.createServer();
var db;
var mongoose = require('mongoose');

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
  app.use(express.logger());
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
  app.set('db-uri', 'mongodb://localhost:27017/notepad_development');
});

app.configure('test', function(){
  app.use(express.logger());
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
  app.set('db-uri', 'mongodb://localhost:27017/notepad_test');
});

app.configure('production', function(){
  app.use(express.errorHandler());
  app.set('db-uri', 'mongodb://localhost:27017/notepad');
});

// Models

db = mongoose.createConnection(app.set('db-uri'));
app.Document = require('./models/document').Document(db);

// Routes

app.get('/', routes.index);

// Document list
app.get('/documents', function(req, res) {
  console.log('GET /documents');
  app.Document.find({},function(err, documents) {
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
    document: new app.Document()
  });
});

app.post('/documents', function(req, res) {
  console.log('POST /documents');
  var document = new app.Document(req.body['document']);
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
