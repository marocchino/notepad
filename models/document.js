var mongoose = require('mongoose')
  , Schema = mongoose.Schema
  , ObjectId = Schema.ObjectId;

var db = mongoose.connect('mongodb://localhost:27017/notepad');

var Document = new Schema({
    title     : String
  , note      : String
  , created_at: Date
  , tags      : String
});
Document.pre('save', function(next) {
  if (this.isNew) {
    this.created_at = new Date();
  }
  next();
});

mongoose.model('Document', Document);
module.exports = db.model('Document');
