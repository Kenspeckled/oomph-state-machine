Promise = require 'promise'

stateMachineMethods =

  currentState: ->
    if this[@constructor._stateAttribute]
      this[@constructor._stateAttribute]
    else
      @constructor._defaultState

  currentStateIs: (testState) ->
    @currentState() == testState

  canTransitionStateTo: (newState) ->
    oldState = @currentState()
    @constructor._states[oldState].hasOwnProperty(newState)

  transitionStateTo: (newState) ->
    oldState = @currentState()
    if !@canTransitionStateTo(newState)
      throw new Error 'Cannot transition state from ' + oldState + ' to ' + newState
    stateCallbacks = @constructor._states[oldState][newState]
    if stateCallbacks and Object.prototype.toString.call( stateCallbacks ) == '[object Array]' and stateCallbacks.length > 0
      returnArray = []
      stateCallbacks.forEach (fn) =>
        returnArray.push fn.call(this)
      Promise.all(returnArray).then =>
        this[@constructor._stateAttribute] = newState
        return this
    else
      new Promise (resolve) =>
        this[@constructor._stateAttribute] = newState
        resolve(this)


stateMachine =

  registerStateMachine: (args) ->
    if !args.hasOwnProperty('stateAttribute')
      throw new Error 'stateAttribute not defined'
    if !args.hasOwnProperty('states')
      throw new Error 'states not defined'
    if !args.hasOwnProperty('defaultState')
      throw new Error 'defaultState not defined'
    @_stateAttribute = args.stateAttribute
    @_states = args.states
    @_defaultState = args.defaultState
    @prototype.currentState = stateMachineMethods.currentState
    @prototype.currentStateIs = stateMachineMethods.currentStateIs
    @prototype.canTransitionStateTo = stateMachineMethods.canTransitionStateTo
    @prototype.transitionStateTo = stateMachineMethods.transitionStateTo

module.exports = stateMachine
