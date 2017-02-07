EMACS ?= emacs

all: generate

generate:
	${EMACS} -Q --script "scripts/makefile-script.el"

clean:
	$(RM) *.html

.PHONY: all generate
