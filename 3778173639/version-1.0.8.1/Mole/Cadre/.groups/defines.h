#define _TOSTR(TXT) #TXT
#define TOSTR(TXT) _TOSTR(TXT)
#define _CONCATE(A,B) A##B
#define CONCATE(A,B) _CONCATE(A,B)
#define ORDER(POS) CONCATE(order,POS)
#define TOTOOL(NAME) TOSTR(NAME.faction)
#define TOID(NAME) TOSTR(NAME.MoleCadre.faction)
// Must be called NAME.png
#define TOICON(NAME) TOSTR(Mole/Cadre/NAME)

#define __TOGROUP(POS,ID,KEY,IMG) \
  "BlockObjectToolGroupSpec": \
  { \
    "Id": TOID(ID), \
    "Order": ORDER(POS), \
    "NameLocKey": TOSTR(Group.KEY), \
    "Icon": TOICON(IMG), \
    "FallbackGroup": false \
  }
#define _TOGROUP(POS,KEY,IMG) __TOGROUP(POS,KEY,KEY,IMG)
#define TOGROUP(POS,NAME) _TOGROUP(POS,NAME,NAME)
