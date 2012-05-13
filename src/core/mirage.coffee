# Base class

class Mirage
  @renderer: (renderer) ->
    if renderer?
      @renderer = renderer
    else
      @renderer ?= new Mirage.Renderer()

  @controls: (controlsClass) ->
    if controlsClass?
      @controlsClass = controlsClass
    else
      @controlsClass

(exports ? @).Mirage = Mirage
