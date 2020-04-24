
//////////////////////
//	Ice Cream		//
//////////////////////

/obj/item/reagent_containers/food/snacks/icecream
	name = "helado"
	desc = "Delicioso helado."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "icecream_cone"
	bitesize = 3
	list_reagents = list("nutriment" = 1, "sugar" = 1)
	tastes = list("ice cream" = 1)

/obj/item/reagent_containers/food/snacks/icecream/New()
	..()
	update_icon()

/obj/item/reagent_containers/food/snacks/icecream/update_icon()
	overlays.Cut()
	var/image/filling = image('icons/obj/kitchen.dmi', src, "icecream_color")
	filling.icon += mix_color_from_reagents(reagents.reagent_list)
	overlays += filling

/obj/item/reagent_containers/food/snacks/icecream/icecreamcone
	name = "cono de helado"
	desc = "Delicioso cono de helado."
	icon_state = "icecream_cone"
	volume = 50
	bitesize = 3
	list_reagents = list("nutriment" = 3, "sugar" = 7, "ice" = 2)

/obj/item/reagent_containers/food/snacks/icecream/icecreamcup
	name = "cono de helado de chocolate"
	desc = "Delicioso cono de helado."
	icon_state = "icecream_cup"
	volume = 50
	bitesize = 6
	list_reagents = list("nutriment" = 5, "chocolate" = 8, "ice" = 2)

/obj/item/reagent_containers/food/snacks/icecreamsandwich
	name = "sandwich de helado"
	desc = "Helado portable en su propio equipaje."
	icon_state = "icecreamsandwich"
	list_reagents = list("nutriment" = 2, "ice" = 2)


//////////////////////
//		Misc		//
//////////////////////

/obj/item/reagent_containers/food/snacks/friedbanana
	name = "banana frita"
	desc = "Goreng Pisang, también conocido como banana frita."
	icon_state = "friedbanana"
	list_reagents = list("sugar" = 5, "nutriment" = 8, "cornoil" = 4)

/obj/item/reagent_containers/food/snacks/ricepudding
	name = "pudin de arroz"
	desc = "Donde esta la jalea?"
	icon_state = "rpudding"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#FFFBDB"
	list_reagents = list("nutriment" = 7, "vitamin" = 2)
	tastes = list("rice" = 1, "sweetness" = 1)

/obj/item/reagent_containers/food/snacks/spacylibertyduff
	name = "libertad espacial duff"
	desc = "Hola gelatina, del libro de cocina de Alfred Hubbard"
	icon_state = "spacylibertyduff"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#42B873"
	bitesize = 3
	list_reagents = list("nutriment" = 6, "psilocybin" = 6)
	tastes = list("jelly" = 1, "mushroom" = 1)

/obj/item/reagent_containers/food/snacks/amanitajelly
	name = "jalea de amanita"
	desc = "Looks curiously toxic."
	icon_state = "amanitajelly"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#ED0758"
	bitesize = 3
	list_reagents = list("nutriment" = 6, "amanitin" = 6, "psilocybin" = 3)
	tastes = list("jelly" = 1, "mushroom" = 1)

/obj/item/reagent_containers/food/snacks/candiedapple
	name = "manzana dulce"
	desc = "Una manzana cubierta de dulce azucar."
	icon_state = "candiedapple"
	filling_color = "#F21873"
	bitesize = 3
	list_reagents = list("nutriment" = 3, "sugar" = 2)
	tastes = list("apple" = 2, "sweetness" = 2)

/obj/item/reagent_containers/food/snacks/mint
	name = "menta"
	desc = "Para quitarte el apestoso aliento."
	icon_state = "mint"
	bitesize = 1
	filling_color = "#F2F2F2"
	list_reagents = list("minttoxin" = 1)
