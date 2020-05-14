/obj/machinery/cell_charger
	name = "cargador de baterias"
	desc = "Esto carga celulas de energia."
	icon = 'icons/obj/power.dmi'
	icon_state = "ccharger0"
	anchored = 1
	use_power = IDLE_POWER_USE
	idle_power_usage = 5
	active_power_usage = 60
	power_channel = EQUIP
	pass_flags = PASSTABLE
	var/obj/item/stock_parts/cell/charging = null
	var/chargelevel = -1

/obj/machinery/cell_charger/deconstruct()
	if(charging)
		charging.forceMove(drop_location())
	return ..()

/obj/machinery/cell_charger/Destroy()
	QDEL_NULL(charging)
	return ..()

/obj/machinery/cell_charger/proc/updateicon()
	icon_state = "ccharger[charging ? 1 : 0]"

	if(charging && !(stat & (BROKEN|NOPOWER)))
		var/newlevel = 	round(charging.percent() * 4 / 100)

		if(chargelevel != newlevel)
			chargelevel = newlevel

			overlays.Cut()
			overlays += "ccharger-o[newlevel]"

	else
		overlays.Cut()

/obj/machinery/cell_charger/examine(mob/user)
	. = ..()
	. += "There's [charging ? "a" : "no"] cell in the charger."
	if(charging)
		. += "Current charge: [round(charging.percent(), 1)]%"

/obj/machinery/cell_charger/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stock_parts/cell))
		if(stat & BROKEN)
			to_chat(user, "<span class='warning'>[src] esta roto!</span>")
			return
		if(!anchored)
			to_chat(user, "<span class='warning'>[src] no esta unido al suelo!</span>")
			return
		if(charging)
			to_chat(user, "<span class='warning'>Ya hay una celula de energia colocada</span>")
			return
		else
			var/area/a = loc.loc // Gets our locations location, like a dream within a dream
			if(!isarea(a))
				return
			if(a.power_equip == 0) // There's no APC in this area, don't try to cheat power!
				to_chat(user, "<span class='warning'>[src] parpadea en rojo cuando intentar meter la celula de energia</span>")
				return
			if(!user.drop_item())
				return

			I.forceMove(src)
			charging = I
			user.visible_message("[user] inserta una celula de energia en el cargador", "<span class='notice'>Has insertado una celula de energia en el cargador.</span>")
			chargelevel = -1
			updateicon()
	else
		return ..()

/obj/machinery/cell_charger/wrench_act(mob/user, obj/item/I)
	. = TRUE
	if(charging)
		to_chat(user, "<span class='warning'>Quita la celula de energia primero!</span>")
		return
	if(!I.use_tool(src, user, 0, volume = I.tool_volume))
		return
	anchored = !anchored
	if(anchored)
		WRENCH_ANCHOR_MESSAGE
	else
		WRENCH_UNANCHOR_MESSAGE


/obj/machinery/cell_charger/proc/removecell()
	charging.update_icon()
	charging = null
	chargelevel = -1
	updateicon()

/obj/machinery/cell_charger/attack_hand(mob/user)
	if(!charging)
		return

	user.put_in_hands(charging)
	charging.add_fingerprint(user)

	user.visible_message("[user] removes [charging] from [src].", "<span class='notice'>Has quitado [charging] del [src].</span>")

	removecell()

/obj/machinery/cell_charger/attack_tk(mob/user)
	if(!charging)
		return

	charging.forceMove(loc)
	to_chat(user, "<span class='notice'>Quitas telequineticamente [charging] del [src].</span>")

	removecell()

/obj/machinery/cell_charger/attack_ai(mob/user)
	return

/obj/machinery/cell_charger/emp_act(severity)
	if(stat & (BROKEN|NOPOWER))
		return

	if(charging)
		charging.emp_act(severity)

	..(severity)


/obj/machinery/cell_charger/process()
	if(!charging || !anchored || (stat & (BROKEN|NOPOWER)))
		return

	if(charging.percent() >= 100)
		return

	use_power(200)		//this used to use CELLRATE, but CELLRATE is fucking awful. feel free to fix this properly!
	charging.give(175)	//inefficiency.

	updateicon()
