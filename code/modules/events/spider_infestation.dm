GLOBAL_VAR_INIT(sent_spiders_to_station, 0)

/datum/event/spider_infestation
	announceWhen	= 400
	var/spawncount = 1

/datum/event/spider_infestation/setup()
	announceWhen = rand(announceWhen, announceWhen + 50)
	spawncount = round(num_players() * 0.8)
	GLOB.sent_spiders_to_station = 1

/datum/event/spider_infestation/announce()
	GLOB.event_announcement.Announce("Se detectaron signos de vida no identificados a bordo de la [station_name()]. Asegure cualquier acceso exterior, incluidos los conductos y la ventilacion.", "Alerta de Signos de Vida", new_sound = 'sound/AI/aliens.ogg')

/datum/event/spider_infestation/start()

	var/list/vents = list()
	for(var/obj/machinery/atmospherics/unary/vent_pump/temp_vent in SSair.atmos_machinery)
		if(is_station_level(temp_vent.loc.z) && !temp_vent.welded)
			if(temp_vent.parent.other_atmosmch.len > 50)
				vents += temp_vent

	while((spawncount >= 1) && vents.len)
		var/obj/vent = pick(vents)
		var/obj/structure/spider/spiderling/S = new(vent.loc)
		if(prob(66))
			S.grow_as = /mob/living/simple_animal/hostile/poison/giant_spider/nurse
		vents -= vent
		spawncount--
