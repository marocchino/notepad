var mongoose = require('mongoose')
  , Schema = mongoose.Schema
  , ObjectId = Schema.ObjectId;

var Document = new Schema({
    author    : ObjectId
  , title     : String
  , date      : Date
  , tags      : String
});

mongoose.model('Document', Document);

exports.Document = function(db) {
  return db.model('Document');  // ‘Document’라는 문서모델에 접근한다.
};
