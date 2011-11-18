vows     = require 'vows'
assert   = require 'assert'
Document = require('../../models/document')
cleaner  = new (require 'database-cleaner') 'mongodb'

db = require("mongoose").connection.db
cleaner = new (require "database-cleaner")("mongodb")

vows.describe('Document').addBatch
  'document attributes는':
    topic: -> new Document()
    "데이터가 없으면":
      topic: (topic) ->
        topic.save @callback
      '에러가 나야 합니다.': (err, document) ->
        assert.equal   err, "cant be blank"
    "title을 가지고 있고":
      topic: (topic) ->
        topic.title = "제목"
        topic.save @callback
        return
      '저장이 가능해야 합니다.': (err, document) ->
        assert.isObject document
        assert.equal    document.title, "제목"
      '에러가 없어야 합니다.': (err, document) ->
        assert.isNull   err
    teardown: (callback) ->
      cleaner.clean(db, callback)
.export module
