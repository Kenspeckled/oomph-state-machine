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
    if @canTransitionStateTo(newState)
      this[@constructor._stateAttribute] = newState

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
