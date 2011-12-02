###
 * Module dependencies.
###

express = require("express")
routes = require("./routes")
app = module.exports = express.createServer()

# Configuration

app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + "/public")

app.configure "development", ->
  app.use express.logger()
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )
  app.set "db-uri", "mongodb://localhost:27017/notepad_development"

app.configure "test", ->
  app.use express.logger()
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )
  app.set "db-uri", "mongodb://travis:test@localhost:27017/notepad_test"

app.configure "production", ->
  app.use express.logger()
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )
  app.set "db-uri", process.env.DB_URI || "mongodb://localhost:27017/notepad"

# Models
connection = require("mongoose").createConnection(app.set("db-uri"))
app.Document = require("./models/document").Document(connection)

# Routes
app.get "/", routes.index
app.get "/documents", (req, res) ->
  app.Document.find {}, (err, documents) ->
    res.render "documents/index",
      title: "documents index"
      documents: documents

app.get "/documents/new", (req, res) ->
  res.render "documents/new",
    title: "new document"
    document: new app.Document()

app.post "/documents", (req, res) ->
  document = new app.Document(req.body["document"])
  document.save (err) ->
    unless err
      res.redirect "/documents"
    else
      console.log err
      res.render "documents/new",
        title: "new document"
        document: document
