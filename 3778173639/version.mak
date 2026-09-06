include factions.mak

all: $(VERSIONS)

$(VERSIONS):
	make -f build.mak FACTION=$(FACTION) VERSION=$@

.PHONY: $(VERSIONS)
