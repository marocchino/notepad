vows    = require 'vows'
assert  = require 'assert'
tobi    = require 'tobi'

vows.describe('Root').addBatch
  '브라우저에서':
    topic: -> tobi.createBrowser 3000, 'localhost'
    'GET /의':
      topic: (topic) ->
        topic.get "/", @callback.bind(@, null)
        return
      "상태 코드는 200이 나와야 합니다": (_, res, $) ->
        res.should.have.status 200
      "제목은 Express라는 글을 포함해야 합니다": (_, res, $) ->
        $('h1').should.include.text 'Express'
.export module
