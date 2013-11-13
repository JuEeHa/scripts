PREFIX ?= $(HOME)

all:
	@echo PREFIX = $(PREFIX)
	@echo do `make install`

install:
	install src/* $(PREFIX)/bin
