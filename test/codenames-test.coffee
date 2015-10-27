chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'codenames', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      http: ->
        get: ->
          ->

    require('../src/codenames')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/suggest a( project)? name/i)
