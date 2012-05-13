# Base mirage object

class Mirage.Object

  constructor: (@id, options...) ->
    @initialize?(options...)

  include: (module, options...) ->
    for methodName of module
      @[methodName] = module[methodName] unless methodName == 'initialize'
    module.initialize?.call(@, options...)
