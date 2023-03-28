/// @desc CSM - Concurrent State Machine
csm = new ConcurrentStateMachine();

csm.add_state("init", new state_machine());

csm.add_state("idle", new state_machine());

csm.add_state("move", new state_machine());

csm.add_state("attack", new state_machine());

csm.add_state("damaged",new state_machine());

csm.add_state("death", new state_machine());

csm.add_state("animation", new state_machine());

