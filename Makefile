PREFIX ?= $(HOME)

all:
	@echo PREFIX = $(PREFIX)
	@echo "do 'make install' to install best picks or 'make install-all' to install everything"

install:
	mkdir -p $(PREFIX)/bin
	cd src; install yt ytdl aytdl vidplay fbb git-commit.sh git-dump.sh mdp2html.sh amdtbl.awk ircurls.sh $(PREFIX)/bin

install-all:
	mkdir -p $(PREFIX)/bin
	install src/* $(PREFIX)/bin
