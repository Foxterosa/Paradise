/datum/event/electrical_storm
	var/lightsoutAmount	= 1
	var/lightsoutRange	= 25

/datum/event/electrical_storm/announce()
	GLOB.event_announcement.Announce("Se detecto una tormenta electrica en su area, repare posibles sobrecargas electronicas.", "Alerta de Tormenta Electrica")

/datum/event/electrical_storm/start()
	var/list/epicentreList = list()

	for(var/i=1, i <= lightsoutAmount, i++)
		var/list/possibleEpicentres = list()
		for(var/thing in GLOB.landmarks_list)
			var/obj/effect/landmark/newEpicentre = thing
			if(newEpicentre.name == "lightsout" && !(newEpicentre in epicentreList))
				possibleEpicentres += newEpicentre
		if(possibleEpicentres.len)
			epicentreList += pick(possibleEpicentres)
		else
			break

	if(!epicentreList.len)
		return

	for(var/thing in epicentreList)
		var/obj/effect/landmark/epicentre = thing
		for(var/obj/machinery/power/apc/apc in range(epicentre, lightsoutRange))
			apc.overload_lighting()

