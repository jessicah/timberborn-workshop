include factions.mak

indices=$(eval indices_i=)\
	$(foreach w,$2,\
		$(eval indices_i=$(indices_i) 1)\
		$(if $(filter $1,$w),$(words $(indices_i)))\
	)
indexof=$(word 1,$(call indices,$1,$2))

F:=$(faction)
GROUP:=$(faction).MoleCadre
ORDER:=$(call indexof,$F,$(FACTIONS))

JSON:=.MoleCadre.$(faction).blueprint.json
DIRS:=$(TOPS:$(SRC_DIR)%/.=$(OUT_DIR)%)
SRCS:=$(SRCS:$(SRC_DIR)%.json=$(OUT_DIR)%$(JSON))

$(info SRCS=$(SRCS))

DEFS+=-D order=$(ORDER)
DEFS+=-D faction=$(faction)
DEFS+=-D icon=$(if $(wildcard ../$(faction).png),$(faction),Unknown)

all: $(SRCS)

$(OUT_DIR)%$(JSON): $(SRC_DIR)%.json $(DIRS) $(OUT_DIR) $(ALL_OUT)
	gcc $(DEFS) -I . -o $@ -E -x c -P $<

$(DIRS): $(OUT_DIR)
$(OUT_DIR): $(ALL_OUT)

$(DIRS) $(OUT_DIR) $(ALL_OUT):
	$(if $(wildcard $@),,mkdir $@)

.FORCE: $(SRCS)
