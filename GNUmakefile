# vim: ft=make ts=8 sts=2 sw=2 noet

PREFIX         ?= /usr/local
BINDIR         ?= $(PREFIX)/bin
MANDIR         ?= $(PREFIX)/share/man
MAN1DIR        ?= $(MANDIR)/man1

srcdir          = $(dir $(firstword $(MAKEFILE_LIST)))

CRAMCMD         = cram

INSTALL_DATA   ?= install -m 644
INSTALL_DIR    ?= install -m 755 -d
INSTALL_SCRIPT ?= install -m 755
RST2HTML       ?= $(call first_in_path,rst2html.py rst2html)

name            = haveopt

installed       = $(name).sh
artifacts       = $(installed) README.html PKGBUILD $(name).spec

revname         = $(shell git describe --always --first-parent)

.DEFAULT_GOAL  := most

.PHONY: all
all: $(artifacts)

$(name).sh: s/$(name).sh
	$(INSTALL_SCRIPT) $< $@

.PHONY: most
most: $(installed)

.PHONY: clean
clean:
	$(RM) $(artifacts)

.PHONY: check
check: $(.DEFAULT_GOAL)
	env -i CRAM="$(CRAM)" PATH="$$PWD/t:$$PWD:$(PATH)" $(CRAMCMD) t

.PHONY: html
html: README.html

.PHONY: install
install: $(installed)
	$(INSTALL_DIR) $(DESTDIR)$(BINDIR)
	$(INSTALL_DIR) $(DESTDIR)$(MAN1DIR)
	$(INSTALL_SCRIPT) $(name).sh $(DESTDIR)$(BINDIR)/$(name).sh
	$(INSTALL_DATA) $(srcdir)/m/$(name).1 $(DESTDIR)$(MAN1DIR)/$(name).1

.PHONY: tarball
tarball: .git
	git archive \
	  --format tar.gz \
	  --prefix $(name)-$(fix_version)/ \
	  --output $(name)-$(fix_version).tar.gz \
	  HEAD

%.html: %.rest
	$(RST2HTML) --strict $< $@

.PHONY: pkg-SUSE
pkg-SUSE: $(name).spec

$(name).spec: p/$(name).spec.in
	$(call subst_version,^Version:)

.PHONY: pkg-ArchLinux
pkg-ArchLinux: PKGBUILD

PKGBUILD: p/PKGBUILD.in
	$(call subst_version,^pkgver=)

.PHONY: pkg-FreeBSD
pkg-FreeBSD: FreeBSD/Makefile FreeBSD/pkg-descr FreeBSD/pkg-plist

FreeBSD:
	mkdir $@

FreeBSD/Makefile: p/FreeBSD/Makefile.in | FreeBSD
	$(call subst_version,^PORTVERSION=)

FreeBSD/%: p/FreeBSD/% | FreeBSD
	cp $< $@

define subst_version
	sed -e "/$(1)/s/__VERSION__/$(fix_version)/" \
	    $< | tee $@ >/dev/null
endef

fix_version = $(subst -,+,$(patsubst v%,%,$(revname)))

define first_in_path
$(or \
  $(firstword $(wildcard \
    $(foreach p,$(1),$(addsuffix /$(p),$(subst :, ,$(PATH)))) \
  )) \
, $(error Need one of: $(1)) \
)
endef

