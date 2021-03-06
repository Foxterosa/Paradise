/datum/wires/vending
	holder_type = /obj/machinery/vending
	wire_count = 4

#define VENDING_WIRE_THROW 1
#define VENDING_WIRE_CONTRABAND 2
#define VENDING_WIRE_ELECTRIFY 4
#define VENDING_WIRE_IDSCAN 8

/datum/wires/vending/GetWireName(index)
	switch(index)
		if(VENDING_WIRE_THROW)
			return "Item Throw"

		if(VENDING_WIRE_CONTRABAND)
			return "Contraband"

		if(VENDING_WIRE_ELECTRIFY)
			return "Electrification"

		if(VENDING_WIRE_IDSCAN)
			return "ID Scan"

/datum/wires/vending/CanUse(mob/living/L)
	var/obj/machinery/vending/V = holder
	if(!istype(L, /mob/living/silicon))
		if(V.seconds_electrified)
			if(V.shock(L, 100))
				return 0
	if(V.panel_open)
		return 1
	return 0

/datum/wires/vending/get_status()
	. = ..()
	var/obj/machinery/vending/V = holder
	. += "La luz naranja esta [V.seconds_electrified ? "on" : "off"]."
	. += "La luz roja esta [V.shoot_inventory ? "off" : "blinking"]."
	. += "La luz verde esta [V.extended_inventory ? "on" : "off"]."
	. += "Una luz [V.scan_id ? "purple" : "yellow"] esta encendida."

/datum/wires/vending/UpdatePulsed(index)
	var/obj/machinery/vending/V = holder
	switch(index)
		if(VENDING_WIRE_THROW)
			V.shoot_inventory = !V.shoot_inventory
		if(VENDING_WIRE_CONTRABAND)
			V.extended_inventory = !V.extended_inventory
		if(VENDING_WIRE_ELECTRIFY)
			V.seconds_electrified = 30
		if(VENDING_WIRE_IDSCAN)
			V.scan_id = !V.scan_id
	..()

/datum/wires/vending/UpdateCut(index, mended)
	var/obj/machinery/vending/V = holder
	switch(index)
		if(VENDING_WIRE_THROW)
			V.shoot_inventory = !mended
		if(VENDING_WIRE_CONTRABAND)
			V.extended_inventory = FALSE
		if(VENDING_WIRE_ELECTRIFY)
			if(mended)
				V.seconds_electrified = 0
			else
				V.seconds_electrified = -1
		if(VENDING_WIRE_IDSCAN)
			V.scan_id = 1
	..()
