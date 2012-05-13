class TestSprite extends Mirage.Sprite
  direction: 0

  action: (dT) ->
    if Mirage.controls().isDown(Mirage.KEYS.right)
      @direction = 1
    else if Mirage.controls().isDown(Mirage.KEYS.left)
      @direction = -1
    else
      @direction = 0

    @x += 400 * dT * @direction

class TestGame extends Mirage.Game
  initialize: ->
    Mirage.controls(new Mirage.Controls())
    @rm = new Mirage.ResourceManager()

    @rm.add(new Mirage.ImageResource('ship', '/images/spaceship.png'))

    @addScene(new Mirage.Scene('main'))
    @setActiveScene('main')

    @rm.loadAll =>
      @createActors()
      @startLoop()

  createActors: ->
    @getScene('main')
      .addActor(new TestSprite('ship', @rm.get('ship')))
      .getActor('ship')
        .moveTo(300, 200)

window.onload = ->
  game = new TestGame()