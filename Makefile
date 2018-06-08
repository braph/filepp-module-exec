MODULE = exec.pm

PREFIX = /usr

build:

install:
	install -m 0644 $(MODULE) $(PREFIX)/share/filepp/modules/$(MODULE)

test:
	./t/test.sh
