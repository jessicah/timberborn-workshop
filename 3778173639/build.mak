include factions.mak

JSON:=.MoleCadre.$(FACTION).blueprint.json

CADRE:=$(VERSION)/$(CADRE)
SRC_DIR:=$(VERSION)/$(SRC_DIR)
MAIN_DIR:=$(VERSION)/$(OUT_DIR)
OUT_DIR:=$(MAIN_DIR)/$(FACTION)
SRC_DIRS:=$(wildcard $(SRC_DIR)**/.)
SRC_DIRS:=$(SRC_DIRS:$(SRC_DIR)/%=%)
OUT_DIRS:=$(SRC_DIRS:%=$(OUT_DIR)/%/.)
SRC_JSON:=$(wildcard $(SRC_DIR)/*.json)
OUT_JSON:=$(SRC_JSON:$(SRC_DIR)/%.json=$(OUT_DIR)/%$(JSON))

ORDER:=$(call indexof,$(FACTION),Adaptors $(FACTIONS))
FACTIONS_DIR:=$(if $(filter FrostyWhiskers,$(FACTION)),Factions_&_Collections,Factions)
MENU:=$(VERSION)/$(FACTIONS_DIR)/Faction.$(FACTION).optional.blueprint.json

ICON:=$(or $(wildcard $(CADRE)/$(FACTION).png),$(CADRE)/Unknown.png)
DEFS+=-D order=$(ORDER)
DEFS+=-D FACTION=$(FACTION)
DEFS+=-D ICON=$(ICON:$(VERSION)/Mole/Cadre/%.png=%)

all: $(OUT_JSON) $(MENU)

$(MENU): defines.h factions.mak
	F="./$@" && echo "{ \"FactionSpec\": { \"Order\": 9 } }" > $$F

$(OUT_DIR)/%$(JSON): $(SRC_DIR)/%.json $(OUT_DIRS) defines.h factions.mak
	gcc $(DEFS) -I . -o $@ -E -x c -P $<

$(OUT_DIRS): $(OUT_DIR)/.
	$(if $(wildcard $@),,mkdir $(@:%/.=%))

$(OUT_DIR)/.: $(MAIN_DIR)/.
	$(if $(wildcard $@),,mkdir $(@:%/.=%))

$(MAIN_DIR)/.:
	$(if $(wildcard $@),,mkdir $(@:%/.=%))


.PHONY: all
