# Base mirage object

class Mirage.Object
  id: null

  include: (module, options...) ->
    for methodName of module
      @[methodName] = module[methodName] unless methodName == 'initialize'
    module.initialize?.call(@, options...)
