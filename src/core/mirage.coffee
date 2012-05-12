# Base class

class Mirage
  @setRenderer: (@renderer) ->

  @getRenderer: ->
    @renderer ?= new Mirage.Renderer('body')

(exports ? @).Mirage = Mirage
