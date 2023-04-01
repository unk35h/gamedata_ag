return {
	OnAnimtionEvent = function (slot0)
		print("Animation Event key = " .. slot0)

		if slot0 == "EquipEnchantSuccess" or slot0 == "EquipEnchantConfirm" then
			manager.notify:CallUpdateFunc(EQUIP_ENCHANT_ANIMATION_EVENT, slot0)
		elseif slot0 == "MythicLinePlayEnd" then
			manager.notify:CallUpdateFunc(MYTHIC_ANIMATION_EVENT, slot0)
		elseif slot0 == "OnSevenSignBeginEvent" then
			manager.notify:CallUpdateFunc(SEVEN_DAY_SIGN_ANIMATION_EVENT, slot0)
		elseif slot0 == "GuildActivityEnterLevel" then
			manager.notify:CallUpdateFunc(GUILD_ACTIVITY_ENTER_LEVEL_ANIMATION, slot0)
		else
			manager.notify:CallUpdateFunc(OBTAIN_HERO_MOVIE_ANIMATION, slot0)
		end
	end
}
