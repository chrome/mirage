class TestSprite extends Mirage.AnimatedSprite
  direction: 0

  initialize: (@flyAnimation, @standAnimation) ->
    @angle = Math.PI / 2

  action: (dT) ->
    if Mirage.controls().isDown(Mirage.KEYS.right)
      @direction = 1
    else if Mirage.controls().isDown(Mirage.KEYS.left)
      @direction = -1
    else
      @direction = 0

    if @direction == 0
      @setAnimation(@standAnimation)
      @stop()
    else
      @setAnimation(@flyAnimation)
      @play()

    @x += 400 * dT * @direction

class TestGame extends Mirage.Game
  initialize: ->
    Mirage.controls(new Mirage.Controls())
    @rm = new Mirage.ResourceManager()

    @rm.add(new Mirage.ImageResource('ship', '/images/spaceship.png'))

    animation = new Mirage.Animation('ship-fly')
    animation
      .addFrame(42, 40, 42, 46)
      .addFrame(42, 86, 42, 46)
      .setSpeed(10)
    @rm.add(animation)

    animation = new Mirage.Animation('ship-stand')
    animation
      .addFrame(42, 0, 42, 46)
      .setSpeed(1)
    @rm.add(animation)

    @addScene(new Mirage.Scene('main'))
    @setActiveScene('main')

    @rm.loadAll =>
      @createActors()
      @startLoop()

  createActors: ->
    @getScene('main')
      .addActor(new TestSprite('ship', @rm.get('ship'), @rm.get('ship-fly'), @rm.get('ship-stand')))
      .getActor('ship')
        .moveTo(300, 200)
        .setAnimation(@rm.get('ship-stand'))

window.onload = ->
  game = new TestGame()