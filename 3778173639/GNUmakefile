include factions.mak

$(info VERSIONS=$(VERSIONS))
$(info FACTIONS=$(FACTIONS))
$(foreach,v,$(VERSIONS),$(info v/.../*=$(wildcard $v/Mole/Cadre/.groups/*))
$(info SRCS=$(SRCS))

all: $(FACTIONS)

$(FACTIONS):
	make -f version.mak FACTION=$@

.PHONY: $(FACTIONS)
