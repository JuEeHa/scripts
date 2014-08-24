DESTDIR     ?=
PREFIX      ?= $(HOME)
EXEC_PREFIX ?= $(PREFIX)

BEST_PICKS = amdtbl.awk fbb git-commit.sh git-dump.sh ircurls.sh mdp2html.sh vidplay yt ytdl 

all:
	@echo DESTDIR     = $(DESTDIR)
	@echo PREFIX      = $(PREFIX)
	@echo EXEC_PREFIX = $(EXEC_PREFIX)
	@echo will install to: $(DESTDIR)$(EXEC_PREFIX)/bin
	@echo "do 'make install' to install best picks ($(BEST_PICKS)) or 'make install-all' to install everything"
install:
	mkdir -p $(DESTDIR)$(EXEC_PREFIX)/bin
	cd src; install $(BEST_PICKS) $(DESTDIR)$(EXEC_PREFIX)/bin

install-all:
	mkdir -p $(DESTDIR)$(EXEC_PREFIX)/bin
	install src/* $(DESTDIR)$(EXEC_PREFIX)/bin
