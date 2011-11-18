mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

db = mongoose.connect 'mongodb://localhost:27017/notepad'
presence = (str) ->
  console.log str
  console.log typeof str
  str.length > 0

DocumentSchema = new Schema
  title     :
    type    : String
    validate: [presence, 'cant be blank']
  note      :
    type    : String
    validate: [presence, 'cant be blank']
  created_at:
    type    : Date
    default : Date.now
  tags      : String

mongoose.model 'Document', DocumentSchema
module.exports = db.model 'Document'
