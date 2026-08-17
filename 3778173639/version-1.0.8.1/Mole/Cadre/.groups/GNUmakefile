include factions.mak

$(info FACTIONS=$(FACTIONS))
$(info DIRS=$(DIRS))

all: $(FACTIONS)

$(FACTIONS):
	make -f build.mak faction=$@ all

.FORCE: $(FACTIONS)
.PHONY: $(FACTIONS)
