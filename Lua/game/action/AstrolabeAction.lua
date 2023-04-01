return {
	AstrolabeUnlock = function (slot0, slot1)
		manager.net:SendWithLoadingNew(14026, {
			id = slot0,
			astrolabe_id = slot1
		}, 14027, uv0.OnAstrolabeUnlock)
	end,
	OnAstrolabeUnlock = function (slot0, slot1)
		if isSuccess(slot0.result) then
			HeroData:AstrolabeUnlock(slot1.id, slot1.astrolabe_id)
		end

		manager.notify:CallUpdateFunc(ASTROLABE_UNLOCK, slot0, slot1)
	end,
	AstrolabeEquip = function (slot0, slot1)
		manager.net:SendWithLoadingNew(14028, {
			operation = 1,
			id = slot0,
			astrolabe_id = slot1
		}, 14029, uv0.OnAstrolabeEquip)
	end,
	OnAstrolabeEquip = function (slot0, slot1)
		if isSuccess(slot0.result) then
			HeroData:AstrolabeEquip(slot1.id, slot1.astrolabe_id)
		end

		manager.notify:CallUpdateFunc(ASTROLABE_EQUIP, slot0, slot1)
	end,
	AstrolabeEquipAll = function (slot0, slot1)
		manager.net:SendWithLoadingNew(14038, {
			hero_id = slot0,
			astrolabe_suit_id = slot1
		}, 14039, uv0.OnAstrolabeEquipAll)
	end,
	OnAstrolabeEquipAll = function (slot0, slot1)
		if isSuccess(slot0.result) then
			HeroData:AstrolabeEquipAll(slot1.hero_id, slot1.astrolabe_suit_id)
		end

		manager.notify:CallUpdateFunc(ASTROLABE_EQUIP, slot0, slot1)
	end,
	AstrolabeUnload = function (slot0, slot1)
		manager.net:SendWithLoadingNew(14028, {
			operation = 2,
			id = slot0,
			astrolabe_id = slot1
		}, 14029, uv0.OnAstrolabeUnload)
	end,
	OnAstrolabeUnload = function (slot0, slot1)
		if isSuccess(slot0.result) then
			HeroData:AstrolabeUnload(slot1.id, slot1.astrolabe_id)
		end

		manager.notify:CallUpdateFunc(ASTROLABE_UNLOAD, slot0, slot1)
	end,
	AstrolabeUnloadAll = function (slot0)
		manager.net:SendWithLoadingNew(14040, {
			hero_id = slot0
		}, 14041, uv0.OnAstrolabeUnloadAll)
	end,
	OnAstrolabeUnloadAll = function (slot0, slot1)
		if isSuccess(slot0.result) then
			HeroData:AstrolabeUnloadAll(slot1.hero_id)
		end

		manager.notify:CallUpdateFunc(ASTROLABE_UNLOAD, slot0, slot1)
	end
}
