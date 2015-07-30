# oomph-state-machine
State Machine Mixin for oomph classes


### Usage
````
stateMachine = require 'oomph-state-machine'

class ChangingStateClass
  @registerStateMachine.call this, 
    stateAttribute: 'state'
    states:
      pending: 
        ready: [(-> console.log 'ready')]
        done: null
      ready:
        done: null
      done: null
````


