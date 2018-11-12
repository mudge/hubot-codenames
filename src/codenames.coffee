# Description:
#   Suggesting solid gold, business appropriate names since 2013. Using Clive
#   Murray's excellent http://codenames.clivemurray.com/
#
# Dependencies:
#   "pacta": "0.5.1"
#
# Commands:
#   hubot suggest a name - suggest a name
#
# Author:
#   mudge

Promise = require 'pacta'

module.exports = (robot) ->
  getJSON = (url) ->
    promise = new Promise()
    robot.http(url).get() (err, res, body) ->
      if err
        promise.reject(err)
      else
        promise.resolve(JSON.parse(body))

    promise

  titlecase = (word) ->
    word[0].toUpperCase() + word[1..-1].toLowerCase()

  allPrefixes = getJSON 'https://codenames.clivemurray.com/data/prefixes.json'
  allAnimals  = getJSON 'https://codenames.clivemurray.com/data/animals.json'

  robot.respond /suggest a( project)? name/i, (res) ->
    Promise.of([]).append(allPrefixes).append(allAnimals).spread (prefixes, animals) ->
      prefix = res.random(prefixes).title
      animal = res.random(animals).title

      res.reply "How about #{ titlecase(prefix) }#{ titlecase(animal) }?"
