Helper = require('hubot-test-helper')
nock = require('nock')
expect = require('chai').expect

helper = new Helper('../src/codenames.coffee')

describe 'codenames', ->
  beforeEach ->
    nock('http://codenames.clivemurray.com')
      .get('/data/prefixes.json')
      .reply(200, [{title: 'black', attributes: ['colour']}])
      .get('/data/animals.json')
      .reply(200, [{title: 'bat', attributes: ['air', 'mammal']}])
    @room = helper.createRoom(httpd: false)

  afterEach ->
    nock.cleanAll()

  context 'user asks for a suggestion', ->
    beforeEach (done) ->
      @room.user.say 'alice', 'hubot suggest a name'
      setTimeout done, 100

    it 'responds to suggestions', ->
      expect(@room.messages).to.eql [
        ['alice', 'hubot suggest a name'],
        ['hubot', '@alice How about BlackBat?'],
      ]
