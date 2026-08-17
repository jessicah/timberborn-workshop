if exiting a game to menu, loading another -> it likely wont Load() again
	-> make specs reload for this case!
	-> whitepaws patch spec should update if faction changed
	-> might want to re-evaluate map sizing too [1.0]

need favor might do without harmony patch
	-> would need to duplicate the tooltip logic

may want to add services from seasons scripts for general use?
	-> not sure it's really a problem to have seasons support
	-> but it forces moddable weather, which might conflict
		-> having the basic feature here might resolve some of it?
		   that is the modifiers and ui elements for those
		   not the seasons or weather abstraction itself

want to move the map resizer reader here
	-> it's convenient to support bigger maps
	   without requiring all the map-maker extra options

might extend the need effect formatter to continuous and ranged types too?
    -> but not want to expose if whitepaws wonder is good or bad either.. 
        (currently _any_ need or modifier always is displayed green with up arrow in vanilla timberborn)

---
---

Bugs in whitepaws/ rare edge cases not covered by vanilla timberborn

	* drain house (any pump) from pressurised source would change contamination (rounding issue?)
		=> been upstream reported
	* rope would freeze beavers if cutting tree below it
	    -> can work around, but either way has issues still..
    * rope requires floor occupancy rn, but vanilla plants have that occupied
        -> a patch script might be fun

---
---

Extend simple light implementation some more

    * fire particles
    * baked light
    * spot angle
    * editor preview?? (how does that work?)

---
---

Would be nice if workshops got pausible, yet kept being house
    -> i.e. override the pause feature and make a new state below (fake-pause)

