class Mirage.Tools
  @distantion: (sX, sY, dX, dY) ->
    dX = Math.abs(sX - dX)
    dY = Math.abs(sY - dY)
    Math.round(Math.sqrt(dX * dX + dY * dY))

  @getAngle: (x1, y1, x2, y2) ->
    dx = (x2 - x1)
    dy = (y2 - y1)
    return -1 if x1 == x2 && y1 == y2

    # some king of bullshit is going on here
    # to complicated function, but it works

    if dy == 0
      if dx >= 0
        return 0
      else
        return Math.PI
    else
      angle = Math.atan(dy / dx)
      if dx < 0 && dy > 0
        angle += Math.PI

      if dx < 0 && dy < 0
        angle += Math.PI

      if dx > 0 && dy < 0
        angle += Math.PI * 2

      if dx == 0 && dy < 0
        angle += Math.PI * 2
    angle


  @getVector: (angle, c) ->
    return {x: 0, y: 0} if angle == 0 and c == 0
    x = Math.round(Math.cos(angle) * c)
    y = Math.round(Math.sin(angle) * c)
    {x, y}


  @sumVectors: (v1, v2) ->
    v1XY = Mirage.Tools.getVector(v1.angle, v1.speed)
    v2XY = Mirage.Tools.getVector(v2.angle, v2.speed)

    vrXY = x: v1XY.x + v2XY.x, y: v1XY.y + v2XY.y


    speed = Math.round(Math.sqrt(vrXY.x * vrXY.x + vrXY.y * vrXY.y))
    angle = Mirage.Tools.getAngle(0, 0, vrXY.x, vrXY.y)

    {speed, angle}

