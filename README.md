# oomph-state-machine
State Machine Mixin for oomph classes


### Usage
````
stateMachine = require 'oomph-state-machine'

class ChangingStateClass
  @registerStateMachine.call this, 
    stateAttribute: 'state'
    defaultState: 'pending'
    states:
      pending: 
        ready: [(-> console.log 'ready')]
        done: null
      ready:
        done: null
      done: null

c = new ChangingStateClass

c.currentState() #=> 'pending'
c.currentStateIs('ready') #=> false
c.canTransitionStateTo('ready') #=> true
c.transitionStateTo('done') # returns a promise
c.canTrnasitionStateTo('ready') #=> false
````
