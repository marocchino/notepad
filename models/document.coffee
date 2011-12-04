mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

db = mongoose.connect 'mongodb://localhost:27017/notepad'
validatePresenceOf = (str) ->
  str && str.length

DocumentSchema = new Schema
  title     :
    type    : String
    validate: [validatePresenceOf, 'title cant be blank']
  note      :
    type    : String
    validate: [validatePresenceOf, 'note cant be blank']
  created_at:
    type    : Date
    default : Date.now
  tags      : String

mongoose.model 'Document', DocumentSchema
exports.Document = (db) -> db.model 'Document'
