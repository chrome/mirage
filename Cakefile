fs     = require('fs')
exec   = require('child_process').exec
http   = require('http')
path   = require('path')
print  = require('util').print
coffee = require('coffee-script')

unitedFiles = ->
  files = [
    'core/mirage'
    'core/object'
    'entities/resources/resource'
    'entities/resources/image'
    'entities/actor'
    'entities/scene'
    'components/renderer'
    'components/resource_manager'
    'components/game'
  ]
  mirageCoffee = ''
  for file in files
    mirageCoffee += "# #{file}\n\n"
    mirageCoffee += fs.readFileSync("src/#{file}.coffee") + "\n"
  mirageCoffee

task 'build', 'Builds mirage.coffee file', ->
  print "Building mirage.coffee...\n"
  mirageCoffee = unitedFiles()
  fs.writeFileSync('build/mirage.coffee', mirageCoffee)
  fs.writeFileSync('build/mirage.js', coffee.compile(mirageCoffee))
  print "Done.\n"

task 'test', 'Run mocha specs', ->
  print "Starting web server...\n"
  server = http.createServer (req, res) ->
    if req.url == '/'
      res.writeHead 200, { 'Content-Type': 'text/html' }
      res.write fs.readFileSync('test/index.html')
    else if req.url == '/mirage.js'
      res.writeHead 200, {'Content-Type': 'text/javascript'}
      res.write coffee.compile(unitedFiles())
    else if req.url == '/app.js'
      res.writeHead 200, {'Content-Type': 'text/javascript'}
      res.write coffee.compile(fs.readFileSync('test/app.coffee') + '')
    else if (match = /images\/([\w\-_\.]+)/.exec(req.url))?
      fileName = "test/images/#{match[1]}"
      if path.existsSync(fileName)
        res.writeHead 200
        res.write fs.readFileSync(fileName)
      else
        res.writeHead 404, {'Content-Type': 'text/plain'}
        res.write 'Not Found'
    else
      res.writeHead 404, {'Content-Type': 'text/plain'}
      res.write 'Not Found'
    res.end()
  server.listen 3300
  print "Done. Port 3300.\n"