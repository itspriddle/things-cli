DIRS=bin share
INSTALL_DIRS=`find $(DIRS) -type d`
INSTALL_FILES=`find $(DIRS) -type f`

PREFIX?=/usr/local
SHARE_DIR=share

test: test-shellcheck test-bats

test-shellcheck:
	shellcheck -f gcc -s bash bin/things test/*.bats test/*.bash

test-bats: bats-setup
	./test/bats/bin/bats test

bats-setup:
	[ -d test/bats ] || (git clone https://github.com/bats-core/bats-core.git test/bats && cd test/bats && git checkout v1.3.0)
	[ -d test/test_helper ] || mkdir test/test_helper
	[ -d test/test_helper/bats-support ] || git clone https://github.com/bats-core/bats-support.git test/test_helper/bats-support
	[ -d test/test_helper/bats-assert ] || git clone https://github.com/bats-core/bats-assert.git test/test_helper/bats-assert

share/man/man1/things.1: doc/man/things.1.md
	kramdown-man doc/man/things.1.md > share/man/man1/things.1

man: doc/man/things.1.md share/man/man1/things.1

install:
	for dir in $(INSTALL_DIRS); do mkdir -p $(DESTDIR)$(PREFIX)/$$dir; done
	for file in $(INSTALL_FILES); do cp $$file $(DESTDIR)$(PREFIX)/$$file; done

uninstall:
	for file in $(INSTALL_FILES); do rm -f $(DESTDIR)$(PREFIX)/$$file; done

.PHONY: bats-setup test test-shellcheck test-bats man install uninstall
