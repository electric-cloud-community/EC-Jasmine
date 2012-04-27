# Makefile

SRCTOP=..
include $(SRCTOP)/build/vars.mak

PLUGIN_PATCH_LEVEL=1.0.3

build: package
unittest:
systemtest: test-setup test-run
jasminetest:
	$(MAKE) NTESTFILES="systemtest/jasmine.ntest" RUNFLOGTESTS=1 test-setup test-run

NTESTFILES ?= systemtest

test-setup:
	$(EC_PERL) ../EC-Jasmine/systemtest/setup.pl $(TEST_SERVER) $(PLUGINS_ARTIFACTS)

test-run: systemtest-run

include $(SRCTOP)/build/rules.mak
