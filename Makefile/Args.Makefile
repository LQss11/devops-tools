COMMANDS_WITH_ARGS=command1 command2
ifeq (1, $(words $(filter $(firstword $(MAKECMDGOALS)), $(COMMANDS_WITH_ARGS))))
  # use the rest as arguments for the command
  ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(ARGS):;@:)
endif

command1:
	@echo $@ args are $(ARGS)
command2:
	@echo $@ args are $(ARGS)
