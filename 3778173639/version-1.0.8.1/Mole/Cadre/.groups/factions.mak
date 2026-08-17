SRC_DIR:=
ALL_OUT:=../Groups
OUT_DIR:=$(ALL_OUT)/$(faction)

FACTIONS:=Folktails IronTeeth
FACTIONS+=Emberpelts LeafCoats
FACTIONS+=Whitepaws FrostyWhiskers Ampears IslandBeavers PolarBeavers
FACTIONS+=Dragonclaws Dirtclaws Badfurs Copperclaws

DIRS:=$(wildcard $(SRC_DIR)**/.)
SRCS:=$(wildcard $(SRC_DIR)**.json)

