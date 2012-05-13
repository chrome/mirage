class TestSprite extends Mirage.Sprite
  direction: 1

  action: (dT) ->
    @x += 400 * dT * @direction

    if @x > 1000
      @direction = -1
    if @x < 300
      @direction = 1


class TestGame extends Mirage.Game
  initialize: ->
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
#   rm = new Mirage.ResourceManager()
#   rm.add new Mirage.ImageResource('ship', '/images/spaceship.png')

#   rm.loadAll ->
#     Mirage.getRenderer()
#       .drawImage(
#         rm.get('ship')
#         x: 200
#         y: 200
#         cropStartX: 42
#         cropWidth: 42
#         cropHeight: 42
#         angle: Math.PI / 3
#       )
#       .drawImage(
#         rm.get('ship')
#         x: 200
#         y: 100
#         cropWidth: 42
#         cropHeight: 42
#         angle: Math.PI / 5
#         scale: 2
#       )
#       .drawImage(
#         rm.get('ship')
#         x: 100
#         y: 100
#         cropStartX: 42
#         cropWidth: 42
#         cropHeight: 42
#       )