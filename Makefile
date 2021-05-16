.PHONY: test

test:
	shellcheck -f gcc -s bash bin/things
