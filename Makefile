me:
	@:

a:
	@:

sandwich:
	@if test `whoami` != "root"; then\
    echo 'What? Make it yourself.'; else echo 'Okay.'; fi
