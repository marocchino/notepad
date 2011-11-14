require.paths.unshift('vendor/mongoose');
var mongoose = require('mongoose');
var db = mongoose.connect('mongodb://localhost:27017/notepad');
var Schema = mongoose.Schema;
var Document = new Schema({
  properties: ['title', 'data', 'tags'],
  indexes: [
    'title'
  ]
});

var ObjectId = Schema.ObjectId;

mongoose.model('Document', Document);

exports.Document = function(db) {
  return db.model('Document');  // ‘Document’라는 문서모델에 접근한다.
};
