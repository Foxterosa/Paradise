
//////////////////////
//		Pizzas		//
//////////////////////

/obj/item/reagent_containers/food/snacks/sliceable/pizza
	icon = 'icons/obj/food/pizza.dmi'
	slices_num = 6
	filling_color = "#BAA14C"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizza/margherita
	name = "pizza margarita"
	desc = "El estandar dorado de las pizzas."
	icon_state = "pizzamargherita"
	slice_path = /obj/item/reagent_containers/food/snacks/margheritaslice
	list_reagents = list("nutriment" = 30, "tomatojuice" = 6, "vitamin" = 5)

/obj/item/reagent_containers/food/snacks/margheritaslice
	name = "trozo de pizza margarita"
	desc = "Un trozo de una clasica pizza."
	icon = 'icons/obj/food/pizza.dmi'
	icon_state = "pizzamargheritaslice"
	filling_color = "#BAA14C"
	list_reagents = list("nutriment" = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizza/meatpizza
	name = "pizza con carne"
	desc = "Una pizza con trozos de carne por encima."
	icon_state = "meatpizza"
	slice_path = /obj/item/reagent_containers/food/snacks/meatpizzaslice
	list_reagents = list("protein" = 30, "tomatojuice" = 6, "vitamin" = 8)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)

/obj/item/reagent_containers/food/snacks/meatpizzaslice
	name = "trozo de pizza con carne"
	desc = "Un trozo de pizza con carne."
	icon = 'icons/obj/food/pizza.dmi'
	icon_state = "meatpizzaslice"
	filling_color = "#BAA14C"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizza/mushroompizza
	name = "pizza con setas"
	desc = "Una muy especial pizza."
	icon_state = "mushroompizza"
	slice_path = /obj/item/reagent_containers/food/snacks/mushroompizzaslice
	list_reagents = list("plantmatter" = 30, "vitamin" = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushroom" = 1)


/obj/item/reagent_containers/food/snacks/mushroompizzaslice
	name = "trozo de pizza con setas"
	desc = "Puede que tal vez sea tu ultimo trozo de pizza de tu vida"
	icon = 'icons/obj/food/pizza.dmi'
	icon_state = "mushroompizzaslice"
	filling_color = "#BAA14C"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushroom" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizza/vegetablepizza
	name = "pizza vegetal"
	desc = "No Tomato Sapiens were harmed during the making of this pizza."
	icon_state = "vegetablepizza"
	slice_path = /obj/item/reagent_containers/food/snacks/vegetablepizzaslice
	list_reagents = list("plantmatter" = 25, "tomatojuice" = 6, "oculine" = 12, "vitamin" = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "carrot" = 1, "vegetables" = 1)


/obj/item/reagent_containers/food/snacks/vegetablepizzaslice
	name = "trozo de pizza vegetal"
	desc = "Un trozo de la pizza mas verde de todas las pizzas sin ingredientes de color verde"
	icon = 'icons/obj/food/pizza.dmi'
	icon_state = "vegetablepizzaslice"
	filling_color = "#BAA14C"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "carrot" = 1, "vegetables" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizza/hawaiianpizza
	name = "pizza hawaiana"
	desc = "Odiado o amado, esta pizza divide las opiniones. Completamente jugosa"
	icon_state = "hawaiianpizza" //NEEDED
	slice_path = /obj/item/reagent_containers/food/snacks/hawaiianpizzaslice
	list_reagents = list("protein" = 15, "tomatojuice" = 6, "plantmatter" = 20, "pineapplejuice" = 6, "vitamin" = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pineapple" = 1)

/obj/item/reagent_containers/food/snacks/hawaiianpizzaslice
	name = "trozo de pizza hawaiana"
	desc = "Un torzo de pizza desagradable."
	icon = 'icons/obj/food/pizza.dmi'
	icon_state = "hawaiianpizzaslice"
	filling_color = "#e5b437"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pineapple" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizza/macpizza
	name = "pizza de quedo y macarrones"
	desc = "Gastronomicos aun no han clasificado este plato como una 'pizza'."
	icon_state = "macpizza"
	slice_path = /obj/item/reagent_containers/food/snacks/macpizzaslice
	list_reagents = list("nutriment" = 40, "vitamin" = 5) //More nutriment because carbs, but it's not any more vitaminicious
	filling_color = "#ffe45d"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 2, "pasta" = 1)

/obj/item/reagent_containers/food/snacks/macpizzaslice
	name = "mac n cheese pizza slice"
	desc = "Espera, que diantres? Quien querria esto?"
	icon = 'icons/obj/food/pizza.dmi'
	icon_state = "macpizzaslice"
	filling_color = "#ffe45d"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 2, "pasta" = 1)


//////////////////////
//		Boxes		//
//////////////////////

/obj/item/pizzabox
	name = "caja para pizzas"
	desc = "Una caja adecuada para pizzas."
	icon = 'icons/obj/food/pizza.dmi'
	icon_state = "pizzabox1"

	var/open = 0 // Is the box open?
	var/ismessy = 0 // Fancy mess on the lid
	var/obj/item/reagent_containers/food/snacks/sliceable/pizza/pizza // Content pizza
	var/list/boxes = list() // If the boxes are stacked, they come here
	var/boxtag = ""

/obj/item/pizzabox/update_icon()
	overlays = list()

	// Set appropriate description
	if(open && pizza)
		desc = "Una caja adecuada para pizzas. Parece tener una [pizza.name] dentro."
	else if(boxes.len > 0)
		desc = "Una pila de cajas adecuadas para pizzas. Parece que hay en ella [boxes.len + 1] cajas en la pila."
		var/obj/item/pizzabox/topbox = boxes[boxes.len]
		var/toptag = topbox.boxtag
		if(toptag != "")
			desc = "[desc] La caja de arriba tiene una etiqueta que pone: '[toptag]'."
	else
		desc = "Una caja adecuada para pizzas."
		if(boxtag != "")
			desc = "[desc] La caja tiene una etiqueta de pone '[boxtag]'."

	// Icon states and overlays
	if(open)
		if(ismessy)
			icon_state = "pizzabox_messy"
		else
			icon_state = "pizzabox_open"
		if(pizza)
			var/image/pizzaimg = image("food/pizza.dmi", icon_state = pizza.icon_state)
			pizzaimg.pixel_y = -3
			overlays += pizzaimg

		return
	else
		// Stupid code because byondcode sucks
		var/doimgtag = 0
		if(boxes.len > 0)
			var/obj/item/pizzabox/topbox = boxes[boxes.len]
			if(topbox.boxtag != "")
				doimgtag = 1
		else
			if(boxtag != "")
				doimgtag = 1
		if(doimgtag)
			var/image/tagimg = image("food/pizza.dmi", icon_state = "pizzabox_tag")
			tagimg.pixel_y = boxes.len * 3
			overlays += tagimg
	icon_state = "pizzabox[boxes.len+1]"

/obj/item/pizzabox/attack_hand(mob/user)
	if(open && pizza)
		user.put_in_hands(pizza)
		to_chat(user, "<span class='warning'>Tomas la [pizza] fuera de la [src].</span>")
		pizza = null
		update_icon()
		return

	if(boxes.len > 0)
		if(user.is_in_inactive_hand(src))
			..()
			return
		var/obj/item/pizzabox/box = boxes[boxes.len]
		boxes -= box
		user.put_in_hands(box)
		to_chat(user, "<span class='warning'>Quitas el mas alto [src] de tu mano.</span>")
		box.update_icon()
		update_icon()
		return
	..()

/obj/item/pizzabox/attack_self(mob/user)
	if(boxes.len > 0)
		return
	open = !open
	if(open && pizza)
		ismessy = 1
	update_icon()

/obj/item/pizzabox/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/pizzabox/))
		var/obj/item/pizzabox/box = I
		if(!box.open && !open)
			// Make a list of all boxes to be added
			var/list/boxestoadd = list()
			boxestoadd += box
			for(var/obj/item/pizzabox/i in box.boxes)
				boxestoadd += i
			if((boxes.len+1) + boxestoadd.len <= 5)
				user.drop_item()
				box.loc = src
				box.boxes = list() // Clear the box boxes so we don't have boxes inside boxes. - Xzibit
				boxes.Add(boxestoadd)
				box.update_icon()
				update_icon()
				to_chat(user, "<span class='warning'>Pones la [box] encima de la [src]!</span>")
			else
				to_chat(user, "<span class='warning'>La pila es muy alta!</span>")
		else
			to_chat(user, "<span class='warning'>Cierra la [box] primero!</span>")
		return

	if(istype(I, /obj/item/reagent_containers/food/snacks/sliceable/pizza/)) // Long ass fucking object name
		if(open)
			user.drop_item()
			I.loc = src
			pizza = I

			update_icon()

			to_chat(user, "<span class='warning'>Colocas [I] en [src]!</span>")
		else
			to_chat(user, "<span class='warning'>Intentas empujar el [I] a traves de la tapa pero parece que no funciona!</span>")
		return

	if(istype(I, /obj/item/pen/))
		if(open)
			return
		var/t = clean_input("Pon lo que quieres añadir a la etiqueta:", "Escribir", null)
		var/obj/item/pizzabox/boxtotagto = src
		if(boxes.len > 0)
			boxtotagto = boxes[boxes.len]
		boxtotagto.boxtag = copytext("[boxtotagto.boxtag][t]", 1, 30)
		update_icon()
		return
	..()

/obj/item/pizzabox/margherita/New()
	..()
	pizza = new /obj/item/reagent_containers/food/snacks/sliceable/pizza/margherita(src)
	boxtag = "margherita deluxe"

/obj/item/pizzabox/vegetable/New()
	..()
	pizza = new /obj/item/reagent_containers/food/snacks/sliceable/pizza/vegetablepizza(src)
	boxtag = "gourmet vegatable"

/obj/item/pizzabox/mushroom/New()
	..()
	pizza = new /obj/item/reagent_containers/food/snacks/sliceable/pizza/mushroompizza(src)
	boxtag = "mushroom special"

/obj/item/pizzabox/meat/New()
	..()
	pizza = new /obj/item/reagent_containers/food/snacks/sliceable/pizza/meatpizza(src)
	boxtag = "meatlover's supreme"

/obj/item/pizzabox/hawaiian/New()
	..()
	pizza = new /obj/item/reagent_containers/food/snacks/sliceable/pizza/hawaiianpizza(src)
	boxtag = "Hawaiian feast"
