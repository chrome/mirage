window.onload = ->
  rm = new Mirage.ResourceManager()
  rm.add new Mirage.ImageResource('ship', '/images/spaceship.png')

  rm.loadAll ->
    Mirage.getRenderer()
      .drawImage(
        rm.get('ship')
        x: 200
        y: 200
        cropStartX: 42
        cropWidth: 42
        cropHeight: 42
        angle: Math.PI / 3
      )
      .drawImage(
        rm.get('ship')
        x: 200
        y: 100
        cropWidth: 42
        cropHeight: 42
        angle: Math.PI / 5
        scale: 2
      )
      .drawImage(
        rm.get('ship')
        x: 100
        y: 100
        cropStartX: 42
        cropWidth: 42
        cropHeight: 42
      )