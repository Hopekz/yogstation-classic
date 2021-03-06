/obj/item/device/autoimplanter
	name = "autoimplanter"
	desc = "A device that automatically injects a cyber-implant into the user without the hassle of extensive surgery. It has a slot to insert implants and a screwdriver slot for removing accidentally added implants."
	icon_state = "gangtool-white"
	item_state = "walkietalkie"
	w_class = 2
	var/obj/item/organ/internal/cyberimp/storedorgan

/obj/item/device/autoimplanter/attack_self(mob/user, obj/item/I)//when the object it used...
	if(!storedorgan)
		user << "<span class='notice'>[src] currently has no implant stored.</span>"
		return
	storedorgan.Insert(user)//insert stored organ into the user
	user << "<span class='notice'>You feel a slight tickle as [src] quickly implants you with the [storedorgan].</span>"
	storedorgan = null

/obj/item/device/autoimplanter/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/organ/internal/cyberimp))
		if(storedorgan)
			user << "<span class='notice'>[src] already has an implant stored.</span>"
			return
		user.unEquip(I)
		I.loc = src
		storedorgan = I
		user << "<span class='notice'>You insert the [I] into [src].</span>"
	if(istype(I, /obj/item/weapon/tool/screwdriver))
		if(!storedorgan)
			user << "<span class='notice'>There's no implant in [src] for you to remove.</span>"
		else
			var/turf/floorloc = get_turf(user)
			floorloc.contents += contents
			user << "<span class='notice'>You remove the [storedorgan] from [src].</span>"
			storedorgan = null
