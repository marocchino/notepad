var mongoose = require('mongoose')
  , Schema = mongoose.Schema
  , ObjectId = Schema.ObjectId;

var db = mongoose.connect('mongodb://localhost:27017/notepad');

var DocumentSchema = new Schema({
    title     : String
  , note      : String
  , created_at: {
      type: Date
    , default: Date.now
  }
  , tags      : String
});

mongoose.model('Document', DocumentSchema);
module.exports = db.model('Document');
