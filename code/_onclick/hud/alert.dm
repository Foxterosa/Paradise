//A system to manage and display alerts on screen without needing you to do it yourself

//PUBLIC -  call these wherever you want


/mob/proc/throw_alert(category, type, severity, obj/new_master, override = FALSE)

/*
 Proc to create or update an alert. Returns the alert if the alert is new or updated, 0 if it was thrown already
 category is a text string. Each mob may only have one alert per category; the previous one will be replaced
 path is a type path of the actual alert type to throw
 severity is an optional number that will be placed at the end of the icon_state for this alert
 For example, high pressure's icon_state is "highpressure" and can be serverity 1 or 2 to get "highpressure1" or "highpressure2"
 new_master is optional and sets the alert's icon state to "template" in the ui_style icons with the master as an overlay.
 Clicks are forwarded to master
 Override makes it so the alert is not replaced until cleared by a clear_alert with clear_override, and it's used for hallucinations.
 */

	if(!category)
		return

	var/obj/screen/alert/alert = LAZYACCESS(alerts, category)
	if(alert)
		if(alert.override_alerts)
			return 0
		if(new_master && new_master != alert.master)
			WARNING("[src] threw alert [category] with new_master [new_master] while already having that alert with master [alert.master]")
			clear_alert(category)
			return .()
		else if(alert.type != type)
			clear_alert(category)
			return .()
		else if(!severity || severity == alert.severity)
			if(alert.timeout)
				clear_alert(category)
				return .()
			else //no need to update
				return 0
	else
		alert = new type()
		alert.override_alerts = override
		if(override)
			alert.timeout = null

	if(new_master)
		var/old_layer = new_master.layer
		var/old_plane = new_master.plane
		new_master.layer = FLOAT_LAYER
		new_master.plane = FLOAT_PLANE
		alert.overlays += new_master
		new_master.layer = old_layer
		new_master.plane = old_plane
		alert.icon_state = "template" // We'll set the icon to the client's ui pref in reorganize_alerts()
		alert.master = new_master
	else
		alert.icon_state = "[initial(alert.icon_state)][severity]"
		alert.severity = severity

	LAZYSET(alerts, category, alert) // This also creates the list if it doesn't exist
	if(client && hud_used)
		hud_used.reorganize_alerts()
	alert.transform = matrix(32, 6, MATRIX_TRANSLATE)
	animate(alert, transform = matrix(), time = 2.5, easing = CUBIC_EASING)

	if(alert.timeout)
		spawn(alert.timeout)
			if(alert.timeout && alerts[category] == alert && world.time >= alert.timeout)
				clear_alert(category)
		alert.timeout = world.time + alert.timeout - world.tick_lag
	return alert

// Proc to clear an existing alert.
/mob/proc/clear_alert(category, clear_override = FALSE)
	var/obj/screen/alert/alert = LAZYACCESS(alerts, category)
	if(!alert)
		return 0
	if(alert.override_alerts && !clear_override)
		return 0

	alerts -= category
	if(client && hud_used)
		hud_used.reorganize_alerts()
		client.screen -= alert
	qdel(alert)

/obj/screen/alert
	icon = 'icons/mob/screen_alert.dmi'
	icon_state = "default"
	name = "Alert"
	desc = "Something seems to have gone wrong with this alert, so report this bug please"
	mouse_opacity = MOUSE_OPACITY_ICON
	var/timeout = 0 //If set to a number, this alert will clear itself after that many deciseconds
	var/severity = 0
	var/alerttooltipstyle = ""
	var/override_alerts = FALSE //If it is overriding other alerts of the same type


/obj/screen/alert/MouseEntered(location,control,params)
	openToolTip(usr, src, params, title = name, content = desc, theme = alerttooltipstyle)


/obj/screen/alert/MouseExited()
	closeToolTip(usr)


//Gas alerts
/obj/screen/alert/not_enough_oxy
	name = "Asfixia (No O2)"
	desc = "No estas recibiendo suficiente oxigeno. Encuentra el aire correcto antes de que te desmayes! La caja en tu mochila tiene un tanque de oxigeno y una mascarilla."
	icon_state = "not_enough_oxy"

/obj/screen/alert/too_much_oxy
	name = "Asfixia (O2)"
	desc = "Hay demasiado oxigeno en el aire, y lo estas respirando! Encuentra el aire correcto antes de que te desmayes!"
	icon_state = "too_much_oxy"

/obj/screen/alert/not_enough_nitro
    name = "Asfixia (No N)"
    desc = "No estas recibiendo suficiente nitrogeno. Encuentra el aire correcto antes de que te desmayes!"
    icon_state = "not_enough_nitro"

/obj/screen/alert/too_much_nitro
    name = "Asfixia (N)"
    desc = "Hay demasiado nitrogeno en el aire, y lo estas respirando! Encuentra el aire correcto antes de que te desmayes!"
    icon_state = "too_much_nitro"

/obj/screen/alert/not_enough_co2
	name = "Asfixia (No CO2)"
	desc = "No estas recibiendo suficiente dioxido de carbono. Encuentra el aire correcto antes de que te desmayes!"
	icon_state = "not_enough_co2"

/obj/screen/alert/too_much_co2
	name = "Asfixia (CO2)"
	desc = "Hay demasiado dioxido de carbono en el aire, y lo estas respirando! Encuentra el aire correcto antes de que te desmayes!"
	icon_state = "too_much_co2"

/obj/screen/alert/not_enough_tox
	name = "Asfixia (No Plasma)"
	desc = "No estas recibiendo suficiente plasma. Encuentra el aire correcto antes de que te desmayes!"
	icon_state = "not_enough_tox"

/obj/screen/alert/too_much_tox
	name = "Asfixia (Plasma)"
	desc = "Hay un altamente inflamable plasma toxico en el aire y lo estas respirando. Busca algo de aire frsco. TLa caja en tu mochila tiene un tanque de oxigeno y una mascarilla."
	icon_state = "too_much_tox"
//End gas alerts


/obj/screen/alert/fat
	name = "Gordo"
	desc = "Comiste demasiada comida. Corre alrededor de la estacion y pierde peso."
	icon_state = "fat"

/obj/screen/alert/full
	name = "Lleno"
	desc = "Te sientes lleno y satisfecho, pero no deberias comer mucho mas."
	icon_state = "full"

/obj/screen/alert/well_fed
	name = "Bien alimentado"
	desc = "Te sientes bastante satisfecho, pero quiza podrias comer un poco mas."
	icon_state = "well_fed"

/obj/screen/alert/fed
	name = "Alimentado"
	desc = "Te sientes moderadamente satisfecho, pero un poco mas de comida no haria dano."
	icon_state = "fed"

/obj/screen/alert/hungry
	name = "Hambre"
	desc = "Algo de comida vendria bien ahora mismo."
	icon_state = "hungry"

/obj/screen/alert/starving
	name = "Hambriento"
	desc = "Estas severamente desnutrido."
	icon_state = "starving"

///Vampire "hunger"

/obj/screen/alert/fat/vampire
	name = "Fat"
	desc = "You somehow drank too much blood, lardass. Run around the station and lose some weight."
	icon_state = "v_fat"

/obj/screen/alert/full/vampire
	name = "Full"
	desc = "You feel full and satisfied, but you know you will thirst for more blood soon..."
	icon_state = "v_full"

/obj/screen/alert/well_fed/vampire
	name = "Well Fed"
	desc = "You feel quite satisfied, but you could do with a bit more blood."
	icon_state = "v_well_fed"

/obj/screen/alert/fed/vampire
	name = "Fed"
	desc = "You feel moderately satisfied, but a bit more blood wouldn't hurt."
	icon_state = "v_fed"

/obj/screen/alert/hungry/vampire
	name = "Hungry"
	desc = "You currently thirst for blood."
	icon_state = "v_hungry"

/obj/screen/alert/starving/vampire
	name = "Starving"
	desc = "You're severely thirsty. The thirst pains make moving around a chore."
	icon_state = "v_starving"

//End of Vampire "hunger"


/obj/screen/alert/hot
	name = "Muy caliente"
	desc = "¡Estas ardiendo! Ve a un lugar mas fresco y quitate la ropa aislante como un traje de bombero."
	icon_state = "hot"

/obj/screen/alert/hot/robot
    desc = "El aire a tu alrededor es demasiado caluroso para un humanoide. Ten cuidado de no exponerlos a este entorno."

/obj/screen/alert/cold
	name = "Muy frio"
	desc = "Te estas congelando! Ve a un lugar mas calido y quitate la ropa aislante como un traje espacial."
	icon_state = "cold"

/obj/screen/alert/cold/drask
    name = "Frio"
    desc = "Estas respirando gas super frio! Esta estimulando tu metabolismo para regenerar el tejido dañado."

/obj/screen/alert/cold/robot
    desc = "The air around you is too cold for a humanoid. Ten cuidado de no exponerlos a este entorno."

/obj/screen/alert/lowpressure
	name = "Baja Presion"
	desc = "El aire a tu alrededor tiene una muy baja presion . Un traje espacial te protegeria."
	icon_state = "lowpressure"

/obj/screen/alert/highpressure
	name = "Alta Presion"
	desc = "El aire a tu alrededor es peligrosamente denso. Un traje de bombero te protegeria."
	icon_state = "highpressure"

/obj/screen/alert/lightexposure
	name = "Exposicion a la luz"
	desc = "Estas expuesto a la luz."
	icon_state = "lightexposure"

/obj/screen/alert/nolight
	name = "Sin luz"
	desc = "No estas expuesto a ninguna luz."
	icon_state = "nolight"

/obj/screen/alert/blind
	name = "Ciego"
	desc = "No puedes ver! Esto puede ser causado por un efecto genetico, problemas en el ojo, estar inconsciente, \
o algo cubriendo tus ojos."
	icon_state = "blind"

/obj/screen/alert/high
	name = "High"
	desc = "Whoa man, you're tripping balls! Careful you don't get addicted... if you aren't already."
	icon_state = "high"

/obj/screen/alert/drunk //Not implemented
	name = "Ebrio"
	desc = "Todo el alcohol que has estado tomando modifica tu habla, habilidades motoras y cognicion mental."
	icon_state = "drunk"

/obj/screen/alert/embeddedobject
	name = "Objeto Incrustado"
	desc = "Algo se alojo en tu carne y esta causando un sangrado grave. Podria salir con el tiempo, pero la cirugia es la forma mas segura. \
			Si te sientes osado, clickeate a ti mismo en intento de ayuda para sacarte el objeto."
	icon_state = "embeddedobject"

/obj/screen/alert/embeddedobject/Click()
	if(isliving(usr))
		var/mob/living/carbon/human/M = usr
		return M.help_shake_act(M)

/obj/screen/alert/asleep
	name = "Dormido"
	desc = "Te has dormido. Espera un poco y deberias despertarte. Amenos que no, Considera lo indefenso que estas."
	icon_state = "asleep"

/obj/screen/alert/weightless
	name = "Weightless"
	desc = "Gravity has ceased affecting you, and you're floating around aimlessly. You'll need something large and heavy, like a \
wall or lattice, to push yourself off if you want to move. A jetpack would enable free range of motion. A pair of \
magboots would let you walk around normally on the floor. Barring those, you can throw things, use a fire extinguisher, \
or shoot a gun to move around via Newton's 3rd Law of Motion."
	icon_state = "weightless"

/obj/screen/alert/fire
	name = "En llamas"
	desc = "Estas en llamas. Detente, tirate y rueda para apagarte o muete a un area sin oxigeno."
	icon_state = "fire"

/obj/screen/alert/fire/Click()
	if(isliving(usr))
		var/mob/living/L = usr
		return L.resist()


//ALIENS

/obj/screen/alert/alien_tox
	name = "Plasma"
	desc = "Hay plasma inflamable en el area. Si se enciende, seras una tostada."
	icon_state = "alien_tox"
	alerttooltipstyle = "alien"

/obj/screen/alert/alien_fire
// This alert is temporarily gonna be thrown for all hot air but one day it will be used for literally being on fire
	name = "Too Hot"
	desc = "It's too hot! Flee to space or at least away from the flames. Standing on weeds will heal you."
	icon_state = "alien_fire"
	alerttooltipstyle = "alien"

/obj/screen/alert/alien_vulnerable
	name = "Severed Matriarchy"
	desc = "Your queen has been killed, you will suffer movement penalties and loss of hivemind. A new queen cannot be made until you recover."
	icon_state = "alien_noqueen"
	alerttooltipstyle = "alien"

//BLOBS

/obj/screen/alert/nofactory
	name = "No Factory"
	desc = "You have no factory, and are slowly dying!"
	icon_state = "blobbernaut_nofactory"
	alerttooltipstyle = "blob"

//SILICONS

/obj/screen/alert/nocell
	name = "Missing Power Cell"
	desc = "Unit has no power cell. No modules available until a power cell is reinstalled. Robotics may provide assistance."
	icon_state = "nocell"

/obj/screen/alert/emptycell
	name = "Out of Power"
	desc = "Unit's power cell has no charge remaining. No modules available until power cell is recharged. \
Recharging stations are available in robotics, the dormitory bathrooms, and the AI satellite."
	icon_state = "emptycell"

/obj/screen/alert/lowcell
	name = "Low Charge"
	desc = "Unit's power cell is running low. Recharging stations are available in robotics, the dormitory bathrooms, and the AI satellite."
	icon_state = "lowcell"

//Diona Nymph
/obj/screen/alert/nymph
	name = "Gestalt merge"
	desc = "You have merged with a diona gestalt and are now part of it's biomass. You can still wiggle yourself free though."

/obj/screen/alert/nymph/Click()
	if(!usr || !usr.client)
		return
	if(isnymph(usr))
		var/mob/living/simple_animal/diona/D = usr
		return D.resist()

//Need to cover all use cases - emag, illegal upgrade module, malf AI hack, traitor cyborg
/obj/screen/alert/hacked
	name = "Hacked"
	desc = "Hazardous non-standard equipment detected. Please ensure any usage of this equipment is in line with unit's laws, if any."
	icon_state = "hacked"

/obj/screen/alert/locked
	name = "Locked Down"
	desc = "Unit has been remotely locked down. Usage of a Robotics Control Console like the one in the Director de Ciencias's \
office by your AI master or any qualified human may resolve this matter. Robotics may provide further assistance if necessary."
	icon_state = "locked"

/obj/screen/alert/newlaw
	name = "Law Update"
	desc = "Laws have potentially been uploaded to or removed from this unit. Please be aware of any changes \
so as to remain in compliance with the most up-to-date laws."
	icon_state = "newlaw"
	timeout = 300

/obj/screen/alert/hackingapc
	name = "Hacking APC"
	desc = "An Area Power Controller is being hacked. When the process is \
		complete, you will have exclusive control of it, and you will gain \
		additional processing time to unlock more malfunction abilities."
	icon_state = "hackingapc"
	timeout = 600
	var/atom/target = null

/obj/screen/alert/hackingapc/Destroy()
	target = null
	return ..()

/obj/screen/alert/hackingapc/Click()
	if(!usr || !usr.client)
		return
	if(!target)
		return
	var/mob/living/silicon/ai/AI = usr
	var/turf/T = get_turf(target)
	if(T)
		AI.eyeobj.setLoc(T)

//MECHS
/obj/screen/alert/low_mech_integrity
	name = "Mech Damaged"
	desc = "Mech integrity is low."
	icon_state = "low_mech_integrity"

/obj/screen/alert/mech_port_available
	name = "Connect to Port"
	desc = "Click here to connect to an air port and refill your oxygen!"
	icon_state = "mech_port"
	var/obj/machinery/atmospherics/unary/portables_connector/target = null

/obj/screen/alert/mech_port_available/Destroy()
	target = null
	return ..()

/obj/screen/alert/mech_port_available/Click()
	if(!usr || !usr.client)
		return
	if(!istype(usr.loc, /obj/mecha) || !target)
		return
	var/obj/mecha/M = usr.loc
	if(M.connect(target))
		to_chat(usr, "<span class='notice'>[M] connects to the port.</span>")
	else
		to_chat(usr, "<span class='notice'>[M] failed to connect to the port.</span>")

/obj/screen/alert/mech_port_disconnect
	name = "Disconnect from Port"
	desc = "Click here to disconnect from your air port."
	icon_state = "mech_port_x"

/obj/screen/alert/mech_port_disconnect/Click()
	if(!usr || !usr.client)
		return
	if(!istype(usr.loc, /obj/mecha))
		return
	var/obj/mecha/M = usr.loc
	if(M.disconnect())
		to_chat(usr, "<span class='notice'>[M] disconnects from the port.</span>")
	else
		to_chat(usr, "<span class='notice'>[M] is not connected to a port at the moment.</span>")

/obj/screen/alert/mech_nocell
	name = "Missing Power Cell"
	desc = "Mech has no power cell."
	icon_state = "nocell"

/obj/screen/alert/mech_emptycell
	name = "Out of Power"
	desc = "Mech is out of power."
	icon_state = "emptycell"

/obj/screen/alert/mech_lowcell
	name = "Low Charge"
	desc = "Mech is running out of power."
	icon_state = "lowcell"

/obj/screen/alert/mech_maintenance
	name = "Maintenance Protocols"
	desc = "Maintenance protocols are currently in effect, most actions disabled."
	icon_state = "locked"

//GUARDIANS
/obj/screen/alert/cancharge
	name = "Charge Ready"
	desc = "You are ready to charge at a location!"
	icon_state = "guardian_charge"
	alerttooltipstyle = "parasite"

/obj/screen/alert/canstealth
	name = "Stealth Ready"
	desc = "You are ready to enter stealth!"
	icon_state = "guardian_canstealth"
	alerttooltipstyle = "parasite"

/obj/screen/alert/instealth
	name = "In Stealth"
	desc = "You are in stealth and your next attack will do bonus damage!"
	icon_state = "guardian_instealth"
	alerttooltipstyle = "parasite"


//GHOSTS
//TODO: expand this system to replace the pollCandidates/CheckAntagonist/"choose quickly"/etc Yes/No messages
/obj/screen/alert/notify_cloning
	name = "Revival"
	desc = "Someone is trying to revive you. Re-enter your corpse if you want to be revived!"
	icon_state = "template"
	timeout = 300

/obj/screen/alert/notify_cloning/Click()
	if(!usr || !usr.client)
		return
	var/mob/dead/observer/G = usr
	G.reenter_corpse()

/obj/screen/alert/notify_action
	name = "Body created"
	desc = "A body was created. You can enter it."
	icon_state = "template"
	timeout = 300
	var/atom/target = null
	var/action = NOTIFY_JUMP

/obj/screen/alert/notify_action/Destroy()
	target = null
	return ..()

/obj/screen/alert/notify_action/Click()
	if(!usr || !usr.client)
		return
	if(!target)
		return
	var/mob/dead/observer/G = usr
	if(!istype(G))
		return
	switch(action)
		if(NOTIFY_ATTACK)
			target.attack_ghost(G)
		if(NOTIFY_JUMP)
			var/turf/T = get_turf(target)
			if(T && isturf(T))
				G.loc = T
		if(NOTIFY_FOLLOW)
			G.ManualFollow(target)

/obj/screen/alert/notify_soulstone
	name = "Soul Stone"
	desc = "Someone is trying to capture your soul in a soul stone. Click to allow it."
	icon_state = "template"
	timeout = 10 SECONDS
	var/obj/item/soulstone/stone = null
	var/stoner = null

/obj/screen/alert/notify_soulstone/Click()
	if(!usr || !usr.client)
		return
	if(stone)
		if(alert(usr, "Do you want to be captured by [stoner]'s soul stone? This will destroy your corpse and make it \
		impossible for you to get back into the game as your regular character.",, "No", "Yes") ==  "Yes")
			stone.opt_in = TRUE

/obj/screen/alert/notify_soulstone/Destroy()
	stone = null
	return ..()


//OBJECT-BASED

/obj/screen/alert/restrained/buckled
	name = "Buckled"
	desc = "You've been buckled to something. Click the alert to unbuckle unless you're handcuffed."
	icon_state = "buckled"

/obj/screen/alert/restrained/handcuffed
	name = "Handcuffed"
	desc = "You're handcuffed and can't act. If anyone drags you, you won't be able to move. Click the alert to free yourself."

/obj/screen/alert/restrained/legcuffed
	name = "Legcuffed"
	desc = "You're legcuffed, which slows you down considerably. Click the alert to free yourself."

/obj/screen/alert/restrained/Click()
	if(isliving(usr))
		var/mob/living/L = usr
		return L.resist()

/obj/screen/alert/restrained/buckled/Click()
	var/mob/living/L = usr
	if(!istype(L) || !L.can_resist())
		return
	L.changeNext_move(CLICK_CD_RESIST)
	if(L.last_special <= world.time)
		return L.resist_buckle()

// PRIVATE = only edit, use, or override these if you're editing the system as a whole

// Re-render all alerts - also called in /datum/hud/show_hud() because it's needed there
/datum/hud/proc/reorganize_alerts()
	var/list/alerts = mymob.alerts
	if(!alerts)
		return FALSE
	var/icon_pref
	if(!hud_shown)
		for(var/i in 1 to alerts.len)
			mymob.client.screen -= alerts[alerts[i]]
		return TRUE
	for(var/i in 1 to alerts.len)
		var/obj/screen/alert/alert = alerts[alerts[i]]
		if(alert.icon_state == "template")
			if(!icon_pref)
				icon_pref = ui_style2icon(mymob.client.prefs.UI_style)
			alert.icon = icon_pref
		switch(i)
			if(1)
				. = ui_alert1
			if(2)
				. = ui_alert2
			if(3)
				. = ui_alert3
			if(4)
				. = ui_alert4
			if(5)
				. = ui_alert5 // Right now there's 5 slots
			else
				. = ""
		alert.screen_loc = .
		mymob.client.screen |= alert
	return TRUE

/mob
	var/list/alerts // lazy list. contains /obj/screen/alert only // On /mob so clientless mobs will throw alerts properly

/obj/screen/alert/Click(location, control, params)
	if(!usr || !usr.client)
		return
	var/paramslist = params2list(params)
	if(paramslist["shift"]) // screen objects don't do the normal Click() stuff so we'll cheat
		to_chat(usr, "<span class='boldnotice'>[name]</span> - <span class='info'>[desc]</span>")
		return
	if(master)
		return usr.client.Click(master, location, control, params)

/obj/screen/alert/Destroy()
	severity = 0
	master = null
	screen_loc = ""
	return ..()
