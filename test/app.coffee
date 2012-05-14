class Bullet extends Mirage.AnimatedSprite

  @initialize (options) ->
    @extractOptions(options, 'startX', 'startY', 'angle')

    @rm = window.game.rm

    unless @rm.get('bullet')
      animation = new Mirage.Animation('bullet')
      animation
        .addFrame(7, 134, 3, 9)
        .addFrame(12, 134, 3, 9)
        .setSpeed(10)

      @rm.add(animation)

    @image = @rm.get('ship')
    @setAnimation(@rm.get('bullet'))
    @play()

    @speed = 600
    @distantion = 1000
    @moveTo(@startX, @startY)

  action: (dT) ->
    dXY = Mirage.Tools.getVector(@angle - Math.PI / 2, @speed * dT)
    @translate(dXY.x, dXY.y)

    if Mirage.Tools.distantion(@startX, @startY, @x, @y) >= @distantion
      @die()



class Spaceship  extends Mirage.AnimatedSprite
  @initialize (options) ->
    @rm = window.game.rm


    unless @rm.get('ship-fly')
      animation = new Mirage.Animation('ship-fly')
      animation
        .addFrame(42, 40, 42, 46)
        .addFrame(42, 86, 42, 46)
        .setSpeed(10)
      @rm.add(animation)

    unless @rm.get('ship-stand')
      animation = new Mirage.Animation('ship-stand')
      animation
        .addFrame(42, 0, 42, 46)
        .setSpeed(1)
      @rm.add(animation)

    @image = @rm.get('ship')

    @setAnimation(@rm.get('ship-stand'))

    @moveTo(100, 100)

    @fireTime = 0
    @activeGun = true

    @angle = 0

    @movingVector = angle: @angle, speed: 0
    @maxSpeed = 300

  fire: (dT) ->
    @fireTime += dT * 1000
    return if @fireTime < 100

    @fireTime = 0


    leftGun =
      x: Math.cos(Math.PI * 1.70 + @angle) * 15 + @x
      y: Math.sin(Math.PI * 1.70 + @angle) * 15 + @y

    rightGun =
      x: Math.cos(Math.PI * 1.25 + @angle) * 18 + @x
      y: Math.sin(Math.PI * 1.25 + @angle) * 18 + @y

    gun = if @activeGun then leftGun else rightGun
    @activeGun = not @activeGun

    window.game.getScene('main')
      .addActor(
        new Bullet(
          Date.now()
          startX: gun.x
          startY: gun.y
          angle: @angle
        )
      )


  action: (dT) ->
    if Mirage.controls().isDown(Mirage.KEYS.space)
      @fire(dT)

    @inMove = false

    if Mirage.controls().isDown(Mirage.KEYS.right)
      @angle += Math.PI * dT
    else if Mirage.controls().isDown(Mirage.KEYS.left)
      @angle -= Math.PI * dT

    if Mirage.controls().isDown(Mirage.KEYS.up)
      @inMove = true
      thrust = 200 * dT
      thrustVector = angle: @angle - Math.PI / 2, speed: thrust
      @movingVector = Mirage.Tools.sumVectors(@movingVector, thrustVector)
      if @movingVector.speed > @maxSpeed
        @movingVector.speed = @maxSpeed
    else
      @movingVector.speed -= 100 * dT

      if @movingVector.speed < 0
        @movingVector.speed = 0

    dXY = Mirage.Tools.getVector(@movingVector.angle, @movingVector.speed)
    @x += dXY.x * dT
    @y += dXY.y * dT

    if @inMove
      @setAnimation(@rm.get('ship-fly'))
      @play()
    else
      @setAnimation(@rm.get('ship-stand'))
      @stop()

    if @x < 0
      @x = 0
    if @x > Mirage.renderer().getCanvas().width
      @x = Mirage.renderer().getCanvas().width
    if @y < 0
      @y = 0
    if @y > Mirage.renderer().getCanvas().height
      @y = Mirage.renderer().getCanvas().height


class TestGame extends Mirage.Game

  @initialize ->
    Mirage.controls(new Mirage.Controls())
    @rm = new Mirage.ResourceManager()

    @rm.add(new Mirage.ImageResource('ship', url: '/images/spaceship.png'))

    @addScene(new Mirage.Scene('main'))
    @setActiveScene('main')

    @rm.loadAll =>
      @createActors()
      @startLoop()

  createActors: ->
    @getScene('main')
      .addActor(new Spaceship('main-ship'))

window.onload = ->
  window.game = new TestGame()