vows   = require 'vows'
assert = require 'assert'
Document = require('../../models/document')

vows.describe('Document').addBatch
  'document attributes는':
    topic: -> new Document()
    "title을 가지고 있고":
      topic: (topic)->
        topic.title = "제목"
        topic.save @callback

      '저장이 가능해야 합니다.': (err, document) ->
        assert.isObject document
        assert.equal    document.title, "제목"
      '에러가 없어야 합니다.': (err, document) ->
        assert.isNull   err

.export module
