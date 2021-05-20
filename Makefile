.PHONY: test
test: test-shellcheck test-bats

.PHONY: test-shellcheck

test-shellcheck:
	shellcheck -f gcc -s bash bin/things

.PHONY: test-bats
test-bats: bats-setup
	./test/bats/bin/bats test

.PHONY: bats-setup
bats-setup:
	[ -d test/bats ] || (git clone https://github.com/bats-core/bats-core.git test/bats && cd test/bats && git checkout v1.3.0)
	[ -d test/test_helper ] || mkdir test/test_helper
	[ -d test/test_helper/bats-support ] || git clone https://github.com/bats-core/bats-support.git test/test_helper/bats-support
	[ -d test/test_helper/bats-assert ] || git clone https://github.com/bats-core/bats-assert.git test/test_helper/bats-assert
