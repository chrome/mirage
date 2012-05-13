# Base class

class Mirage
  @renderer: (rendererClass) ->
    if rendererClass?
      @rendererClass = rendererClass
    else
      @rendererClass ?= new Mirage.Renderer()

  @controls: (controlsClass) ->
    if controlsClass?
      @controlsClass = controlsClass
    else
      @controlsClass

(exports ? @).Mirage = Mirage
