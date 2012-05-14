# Base mirage object

class Mirage.Object

  constructor: (@id, options) ->
    if @initChain
      for initializer in @initChain
        try
          initializer.call(@, options)
        catch error
          console.log error.message


  extractOptions: (options, requiredOptions...) ->
    for requiredOption in requiredOptions
      if options?[requiredOption]?
        @[requiredOption] = options[requiredOption]
      # else
      #   throw "#{requiredOption} is required!"

  @initialize: (method) ->
      if @prototype.initChain?
        @prototype.initChain = @prototype.initChain.slice()
        @prototype.initChain.push method
      else
        @prototype.initChain = [method]


  include: (module, options...) ->
    for methodName of module
      @[methodName] = module[methodName] unless methodName == 'initialize'
    module.initialize?.call(@, options...)