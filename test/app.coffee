window.onload = ->
  rm = new Mirage.ResourceManager()
  rm.add new Mirage.ImageResource('ship', '/images/spaceship.png')

  rm.loadAll ->
    Mirage.getRenderer().drawImage(500, 50, 0, 1, rm.get('ship'))
    Mirage.getRenderer().drawImage(100, 100, Math.PI / 3, 2, rm.get('ship'))
    Mirage.getRenderer().drawImage(200, 300, Math.PI / 5, 1.5, rm.get('ship'))
    Mirage.getRenderer().drawImage(300, 300, 0, 1, rm.get('ship'))