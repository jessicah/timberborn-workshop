FACTIONS:=Folktails IronTeeth
FACTIONS+=Emberpelts LeafCoats CharcoalBeavers
FACTIONS+=Whitepaws FrostyWhiskers Ampears IslandBeavers PolarBeavers
FACTIONS+=Dragonclaws Dirtclaws Badfurs Copperclaws

VERSIONS:=$(subst /.,,$(wildcard version-*/.))

CADRE:=Mole/Cadre
SRC_DIR:=$(CADRE)/.groups
OUT_DIR:=$(CADRE)/Groups

indices=$(eval indices_i=)\
	$(foreach w,$2,\
		$(eval indices_i=$(indices_i) 1)\
		$(if $(filter $1,$w),$(words $(indices_i)))\
	)
indexof=$(word 1,$(call indices,$1,$2))
