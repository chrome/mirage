class Mirage.AnimatedSprite extends Mirage.Sprite


  @initialize ->
    @currentAnimation = null
    @currentFrame = 0
    @lastFrameTime = 0
    @playing = false

  setAnimation: (animation) ->
    unless animation?.id == @currentAnimation?.id
      @currentAnimation = animation
      @currentFrame = 0
      @lastFrameTime = 0
    @

  play: ->
    @playing = true
    @

  stop: ->
    @playing = false
    @currentFrame = 0
    @lastFrameTime = 0
    @

  pause: ->
    @playing = false
    @lastFrameTime = 0
    @

  preAction: (deltaTime) ->
    if @playing && @currentAnimation
      @lastFrameTime += deltaTime * 1000
      if @lastFrameTime >= 1000 / @currentAnimation.speed
        @lastFrameTime = 0
        @currentFrame++
      if @currentFrame >= @currentAnimation.framesCount()
        if @currentAnimation.loop
          @currentFrame = 0
        else
          @currentFrame = @currentAnimation.framesCount() - 1
          @playing = false

  render: ->
    Mirage.renderer()
      .drawImage(
        @image
        x: @x
        y: @y
        angle: @angle
        scale: @scale
        cropStartX: @currentAnimation.getFrame(@currentFrame).x
        cropStartY: @currentAnimation.getFrame(@currentFrame).y
        cropWidth:  @currentAnimation.getFrame(@currentFrame).width
        cropHeight: @currentAnimation.getFrame(@currentFrame).height
      )