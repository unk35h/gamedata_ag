return {
	getItemNum = function (slot0, slot1)
		if ItemCfg[slot0].type == ItemConst.ITEM_TYPE.CURRENCY then
			return CurrencyData:GetCurrencyNum(slot0) or 0
		elseif slot3 == ItemConst.ITEM_TYPE.HERO_PIECE then
			if HeroData:GetHeroData(slot2.hero_id) then
				return slot4.piece
			end
		elseif slot3 == ItemConst.ITEM_TYPE.MATERIAL or slot3 == ItemConst.ITEM_TYPE.PROPS or slot3 == ItemConst.ITEM_TYPE.GIFT or slot3 == ItemConst.ITEM_TYPE.ARCHIVE_GIFT or slot3 == ItemConst.ITEM_TYPE.SKIN_CHANGE then
			if MaterialData:GetMaterial(slot0, slot1) then
				return slot4.num
			end
		elseif slot3 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			print("todo:钥从数量未更新")

			return 1
		elseif slot3 == ItemConst.ITEM_TYPE.EQUIP then
			return #EquipTools.GetEquipListByEquipid(slot0)
		elseif slot3 == ItemConst.ITEM_TYPE.HERO_SKIN then
			return HeroTools.IsSkinUnlock(slot0) and 1 or 0
		elseif slot3 == ItemConst.ITEM_TYPE.PORTRAIT then
			return PlayerData:GetPortrait(slot0).unlock == 1 and 1 or 0
		elseif slot3 == ItemConst.ITEM_TYPE.FRAME then
			return PlayerData:GetFrame(slot0).unlock == 1 and 1 or 0
		elseif slot3 == ItemConst.ITEM_TYPE.STICKER then
			return PlayerData:GetSticker(slot0).unlock == 1 and 1 or 0
		elseif slot3 == ItemConst.ITEM_TYPE.CANTEEN_INGREDIENTS then
			return CanteenData:GetHadIngredientNum(slot0) or 0
		elseif slot3 == ItemConst.ITEM_TYPE.CLUB_COMMON then
			-- Nothing
		elseif slot3 == ItemConst.ITEM_TYPE.DORM_FURNITURE then
			return DormData:GetFurNumInfo(slot0).num or 0
		else
			print("未知的Item类型", slot3)
		end

		return 0
	end,
	getItemSprite = function (slot0, slot1)
		if ItemCfg[slot0].type == ItemConst.ITEM_TYPE.EQUIP then
			return getSpriteWithoutAtlas(SpritePathCfg.EquipIcon.path .. slot2.icon)
		elseif SpritePathConst.texturePath[slot2.type] then
			return getSpriteWithoutAtlas(SpritePathConst.texturePath[slot2.type] .. slot2.icon)
		elseif slot2.type == ItemConst.ITEM_TYPE.HERO_SKIN then
			return getSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. slot2.icon)
		elseif slot2.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			return getSpriteWithoutAtlas(SpritePathCfg.ServantIcon.path .. slot2.icon)
		elseif slot2.type == ItemConst.ITEM_TYPE.PORTRAIT then
			if slot2.sub_type == 1 then
				return getSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. slot2.icon)
			elseif slot2.sub_type == 2 then
				return getSpriteWithoutAtlas("Textures/Item/Portrait/" .. slot2.icon)
			else
				print("暂未定义的头像来源")
			end
		elseif slot2.type == ItemConst.ITEM_TYPE.FRAME then
			return getSpriteWithoutAtlas("Textures/Frame/" .. slot2.icon)
		elseif slot2.type == ItemConst.ITEM_TYPE.STICKER then
			slot3 = 2

			if slot1 and slot1.size then
				slot3 = slot1.size
			end

			if getSpriteWithoutAtlas("Textures/Sticker/" .. slot2.icon .. "_" .. slot3) then
				return slot4
			else
				return getSpriteWithoutAtlas("Textures/Sticker/" .. slot2.icon .. "_" .. slot3 .. SettingData:GetCurrentLanguageKey())
			end
		else
			return getSpriteWithoutAtlas(SpritePathCfg.ItemIcon.path .. slot2.icon)
		end
	end,
	GetItemSpriteAsync = function (slot0, slot1, slot2)
		slot3 = ItemCfg[slot0]
		slot4 = true

		if not slot2 then
			slot2 = ""
			slot5 = false

			if slot3.type == ItemConst.ITEM_TYPE.EQUIP then
				slot2 = SpritePathCfg.EquipIcon.path .. slot3.icon
			elseif SpritePathConst.texturePath[slot3.type] then
				slot2 = SpritePathConst.texturePath[slot3.type] .. slot3.icon
			elseif slot3.type == ItemConst.ITEM_TYPE.HERO_SKIN then
				slot2 = SpritePathCfg.HeroLittleIcon.path .. slot3.icon
			elseif slot3.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
				slot2 = SpritePathCfg.ServantIcon.path .. slot3.icon
			elseif slot3.type == ItemConst.ITEM_TYPE.PORTRAIT then
				if slot3.sub_type == 1 then
					slot2 = SpritePathCfg.HeroLittleIcon.path .. slot3.icon
				elseif slot3.sub_type == 2 then
					slot2 = "Textures/Item/Portrait/" .. slot3.icon
				else
					print("暂未定义的头像来源")
				end
			elseif slot3.type == ItemConst.ITEM_TYPE.FRAME then
				slot2 = "Textures/Frame/" .. slot3.icon
			elseif slot3.type == ItemConst.ITEM_TYPE.STICKER then
				slot2 = "Textures/Sticker/" .. slot3.icon
				slot4 = false
			else
				slot2 = SpritePathCfg.ItemIcon.path .. slot3.icon
			end
		end

		if not slot4 then
			slot1(slot0, uv0.getItemSprite(slot0))
		else
			getSpriteWithoutAtlasAsync(slot2, function (slot0)
				uv0(uv1, slot0)
			end)
		end
	end,
	getItemLittleSprite = function (slot0)
		if ItemCfg[slot0].type == ItemConst.ITEM_TYPE.HERO_PIECE then
			return getSpriteWithoutAtlas(SpritePathCfg.HeroPieceSmall.path .. slot1.icon)
		end

		if slot1.littleicon == nil or slot1.littleicon == "" then
			return uv0.getItemSprite(slot0)
		end

		if SpritePathConst.LittleIconAtlas[slot1.type] then
			return getSprite(slot2, slot1.littleicon)
		end

		return nil
	end,
	GetItemExpiredTimeByInfo = function (slot0)
		if slot0.time_valid ~= nil and slot0.time_valid > 0 then
			return slot0.time_valid
		end

		return uv0.GetItemExpiredTimeByID(slot0.id)
	end,
	GetItemExpiredTimeByID = function (slot0)
		if ItemCfg[slot0].time ~= nil and slot1.time ~= "" then
			if slot1.time[1] == 1 then
				for slot6, slot7 in ipairs(slot1.time[2]) do
					slot8, slot9 = ActivityData:GetActivityTime(slot7)

					return slot9
				end
			elseif slot2 == 2 then
				return slot1.time[2][1]
			elseif slot2 == 3 then
				return _G.gameTimer:GetNextWeekFreshTime() + slot1.time[2][1] * 604800 + (slot1.time[2][2][1] - 1) * 24 * 3600 + (slot1.time[2][2][2] - 5) * 3600
			end
		end

		return 0
	end,
	IsItemExpired = function (slot0)
		if uv0.IsItemExpiredByItemId(slot0.id) then
			return true
		end

		if slot0.time_valid ~= nil and slot0.time_valid > 0 and slot0.time_valid < manager.time:GetServerTime() then
			return true
		end

		return false
	end,
	IsItemExpiredByItemId = function (slot0)
		if ItemCfg[slot0].type ~= ItemConst.ITEM_TYPE.MATERIAL then
			return false
		end

		if ItemCfg[slot0].time ~= nil and slot2.time ~= "" then
			if slot2.time[1] == 1 then
				return not ActivityData:GetActivityIsOpen(slot2.time[2][1])
			elseif slot3 == 2 then
				return slot2.time[2][1] < manager.time:GetServerTime()
			end
		end

		return false
	end
}
