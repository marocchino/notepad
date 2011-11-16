vows    = require 'vows'
assert  = require 'assert'
tobi    = require 'tobi'

vows.describe('Documents').addBatch
  '브라우저에서':
    topic: -> tobi.createBrowser 3000, 'localhost'
    'GET /documents의':
      topic: (topic) ->
        topic.get "/documents", @callback.bind(@, null)
        return
      "상태 코드는 200이 나와야 합니다": (_, res, $) ->
        res.should.have.status 200
      "글작성 페이지로 가는 링크가 있어야합니다": (_, res, $) ->
        $('a').should.have.attr 'href', '/documents/new'

    'POST /documents에 정상적인 데이터가 들어가면':
      topic: (topic) ->
        topic.post "/documents",
          { body: "document[title]=Title&document[note]=Note" },
          @callback.bind(@, null)
        return
      "상태 코드는 200이 나와야 합니다": (_, res, $) ->
        res.should.have.status 200

    'POST /documents에 빈 데이터가 들어가면':
      topic: (topic) ->
        topic.post "/documents",
          { body: "" },
          @callback.bind(@, null)
        return
      "폼화면이 나와야 합니다": (_, res, $) ->
        $('*').should.include.text('My Site')

    'GET /documents/new의':
      topic: (topic) ->
        topic.get "/documents/new", @callback.bind(@, null)
        return
      "상태 코드는 200이 나와야 합니다": (_, res, $) ->
        res.should.have.status 200
      "목록으로 가는 링크가 있어야합니다": (_, res, $) ->
        $('a').should.have.attr 'href', '/documents'
      "타이틀입력 폼이 있어야합니다": (_, res, $) ->
        $('form').should.have.one 'input[name="document[title]"]'
      "노트입력 폼이 있어야합니다": (_, res, $) ->
        $('form').should.have.one 'textarea[name="document[note]"]'
      "저장 버튼이 있어야합니다": (_, res, $) ->
        $('form').should.have.one 'input:submit'
.export module
