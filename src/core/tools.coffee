class Mirage.Tools
  @distantion: (sX, sY, dX, dY) ->
    dX = Math.abs(sX - dX)
    dY = Math.abs(sY - dY)
    Math.round(Math.sqrt(dX * dX + dY * dY))