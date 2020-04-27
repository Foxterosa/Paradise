// Funcion que detecta cuando un personaje llega a la estacion
/mob/new_player/proc/start_player(mob/user)
	var/mob/living/carbon/human/target = user

//		CONNOR RYALS
	if(isskrell(target) && target.real_name == "Connor Ryals" && target.ckey == "spiritualshadow")
		for(var/obj/item/storage/backpack/B in (target.contents))
			new /obj/item/clothing/glasses/hud/health/sunglasses/eyepatch(B)
			return
//		---

/obj/item/clothing/glasses/hud/health/sunglasses/eyepatch
	name = "Medical HUDpatch"
	desc = "Un parche con nanotecnologías que le permite actuar como un hud regular, con la ventaja añadida de protección a flashes y verse guay, tiene una inscripción en letra pequeña 'Recuerda cerrar el otro ojo, Connor.'"
	icon_state = "eyepatchhud"

