slot1 = manager.net

slot1:Bind(14007, function (slot0)
	HeroData:ModifyHero(slot0.hero)
	uv0.UpdateOneHeroNotice(slot0.hero.id)
end)

slot1 = manager.net

slot1:Bind(14009, function (slot0)
	HeroData:InitHero(slot0.hero_info_list, slot0.piece_list)
	HeroData:InitFavorite(slot0.favorites)
	ArchiveData:InitArchive(slot0.archives)
	ProposalData:InitProposal(slot0.proposal_list)
	uv0.OnHeroInit()
end)

slot1 = manager.net

slot1:Bind(14019, function (slot0)
	HeroData:ModifyHeroPiece(slot0.piece_list)
end)

slot1 = manager.notify

slot1:RegistListener(HERO_DATA_INIT, function ()
	uv0.UpdatePieceRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(HERO_PIECE_MODIFY, function (slot0)
	uv0.UpdateUnlockNotice(slot0)
	uv0.UpdateStarNotice(slot0)
	uv0.UpdatePieceRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(HERO_DATA_MODIFY, function (slot0)
	uv0.UpdatePieceRedPoint()
	uv0.UpdateUnlockNotice(slot0)
	uv0.UpdateBreakNotice(slot0)
	uv0.UpdateStarNotice(slot0)
end)

slot1 = manager.notify

slot1:RegistListener(MATERIAL_INIT, function ()
	uv0.CheckHeroBreakNotice()
end)

slot1 = manager.notify

slot1:RegistListener(MATERIAL_LIST_UPDATE, function ()
	uv0.CheckHeroBreakNotice()
end)

slot1 = manager.notify

slot1:RegistListener(MATERIAL_MODIFY, function ()
	uv0.CheckHeroBreakNotice()
end)

slot1 = manager.notify

slot1:RegistListener(CURRENCY_UPDATE, function (slot0)
	if slot0 == CurrencyConst.CURRENCY_TYPE_GOLD then
		uv0.CheckHeroBreakNotice()
		uv0.UpdateAllStarNotice()
	end
end)

slot1 = manager.notify

slot1:RegistListener(PLAYER_LEVEL_UP, function ()
	uv0.CheckHeroBreakNotice()
end)

slot1 = nil

return {
	UpdateUnlockNotice = function (slot0)
		slot3 = GameSetting.unlock_hero_need.value[HeroCfg[slot0].rare]

		if HeroData:GetHeroData(slot0).unlock == 0 and slot3 <= slot1.piece then
			manager.redPoint:setTip(RedPointConst.HERO_UNLOCK_ID .. slot0, 1)
		else
			manager.redPoint:setTip(RedPointConst.HERO_UNLOCK_ID .. slot0, 0)
		end
	end,
	UpdateBreakNotice = function (slot0)
		if HeroTools.CanBreakHero(slot0) then
			manager.redPoint:setTip(RedPointConst.HERO_BREAK_ID .. slot0, 1)
		else
			manager.redPoint:setTip(RedPointConst.HERO_BREAK_ID .. slot0, 0)
		end
	end,
	UpdateAllStarNotice = function ()
		slot2 = HeroData
		slot4 = slot2

		for slot3, slot4 in pairs(slot2.GetHeroList(slot4)) do
			uv0.UpdateStarNotice(slot4.id)
		end
	end,
	UpdateStarNotice = function (slot0)
		if HeroTools.GetIsCanUpStar(HeroData:GetHeroData(slot0)) then
			manager.redPoint:setTip(RedPointConst.HERO_STAR_ID .. slot0, 1)
		else
			manager.redPoint:setTip(RedPointConst.HERO_STAR_ID .. slot0, 0)
		end
	end,
	UpdatePieceRedPoint = function ()
		if #HeroTools.GetCanExchangeHero() > 0 then
			manager.redPoint:setTip(RedPointConst.HERO_PIECE_EXCHANGE, 1)
		else
			manager.redPoint:setTip(RedPointConst.HERO_PIECE_EXCHANGE, 0)
		end
	end,
	OnHeroInit = function ()
		uv0.CheckHeroBreakNotice()
		uv0.CheckHeroUnlockNotice()
		uv0.UpdateAllStarNotice()
		uv0.UpdateHeartRedPoint()
		uv0.UpdateStoryRedPoint()
		uv0.UpdateAllHeroSkinRedPoint()
	end,
	UpdateAllHeroSkinRedPoint = function ()
		slot2 = HeroData
		slot4 = slot2

		for slot3, slot4 in pairs(slot2.GetHeroList(slot4)) do
			uv0.UpdateSkinCouponRedPoint(slot4.id)
		end
	end,
	UpdateSkinCouponRedPoint = function (slot0)
		slot2 = HeroData:GetHeroList()[slot0].unlock > 0

		for slot7, slot8 in ipairs(SkinCfg.get_id_list_by_hero[slot0]) do
			if slot2 == true and HeroTools.CanChangeSkin(slot8) then
				manager.redPoint:setTip(RedPointConst.HERO_SKIN_ID .. slot0, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.HERO_SKIN_ID .. slot0, 0)
	end,
	CheckHeroBreakNotice = function ()
		slot2 = HeroData
		slot4 = slot2

		for slot3, slot4 in pairs(slot2.GetHeroList(slot4)) do
			uv0.UpdateBreakNotice(slot4.id)
		end
	end,
	CheckHeroUnlockNotice = function ()
		slot2 = HeroData
		slot4 = slot2

		for slot3, slot4 in pairs(slot2.GetHeroList(slot4)) do
			uv0.UpdateUnlockNotice(slot4.id)
		end
	end,
	UpdateOneHeroNotice = function (slot0)
		uv0.UpdateUnlockNotice(slot0)
		uv0.UpdateBreakNotice(slot0)
		uv0.UpdateStarNotice(slot0)
	end,
	HeroPieceModify = function (slot0, slot1)
		HeroData:HeroPieceModify(slot0, slot1)
	end,
	HeroBreak = function (slot0)
		manager.net:SendWithLoadingNew(14036, {
			hero_id = slot0
		}, 14037, uv0.OnHeroBreak)
	end,
	OnHeroBreak = function (slot0, slot1)
		manager.notify:CallUpdateFunc(HERO_BREAK, slot0, slot1)
	end,
	AddHeroExp = function (slot0, slot1)
		manager.net:SendWithLoadingNew(14014, {
			id = slot0,
			item_list = slot1
		}, 14015, uv0.OnAddHeroExp)
	end,
	OnAddHeroExp = function (slot0, slot1)
		if isSuccess(slot0.result) then
			for slot5, slot6 in ipairs(slot1.item_list) do
				MaterialAction.MaterialModify(slot6.id, -1 * slot6.num)
			end
		else
			ShowTips(slot0.result)
		end

		manager.notify:CallUpdateFunc(ON_HERO_ADD_EXP, slot0)
	end,
	UnlockHeroSuccess = function (slot0)
		HeroData:UnlockHeroSuccess(slot0)
		uv0.UpdateHeartRedPoint()
		uv0.UpdateStoryRedPoint()
		PlayerAction.UnlockPortrait(SkinCfg[slot0].portrait or 2110111)
	end,
	AddHeroExpSuccess = function (slot0, slot1, slot2)
		HeroData:AddHeroExpSuccess(slot0, slot1, slot2)
	end,
	BreakSuccess = function (slot0, slot1)
		HeroData:BreakSuccess(slot0, slot1)
	end,
	WeaponStr = function (slot0, slot1, slot2)
		HeroData:WeaponStr(slot0, slot1, slot2)
	end,
	WeaponBreak = function (slot0, slot1)
		HeroData:WeaponBreak(slot0, slot1)
	end,
	ServantReplace = function (slot0, slot1)
		HeroData:ServantReplace(slot0, slot1)
	end,
	EquipSwap = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(13012, {
			hero_id = slot0,
			equip_id = slot1,
			pos = slot2
		}, 13013, uv0.OnEquipSwap)
	end,
	OnEquipSwap = function (slot0, slot1)
		if isSuccess(slot0.result) then
			HeroData:EquipSwap(slot1.hero_id, slot1.equip_id, slot1.pos)
		end

		manager.notify:CallUpdateFunc(EQUIP_SWAP, slot0, slot1)
	end,
	EquipUnloadAll = function (slot0)
		manager.net:SendWithLoadingNew(13018, {
			hero_id = slot0
		}, 13019, uv0.OnEquipUnloadAll)
	end,
	OnEquipUnloadAll = function (slot0, slot1)
		if isSuccess(slot0.result) then
			HeroData:EquipUnloadAll(slot1.hero_id)
		end

		manager.notify:CallUpdateFunc(EQUIP_UNLOAD_ALL, slot0, slot1)
	end,
	HeroChangeEquip = function (slot0, slot1, slot2)
		HeroData:EquipSwap(slot0, slot1, slot2)
	end,
	HeroSkillUpgrade = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(14030, {
			hero_id = slot0,
			skill_id = slot1,
			num = slot2
		}, 14031, uv0.OnHeroSkillUpgrade)
	end,
	OnHeroSkillUpgrade = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot7 = slot1.num

			for slot7, slot8 in pairs(SkillTools.GetSkillUpCostNum(slot1.skill_id, HeroTools.GetSkillLv(slot1.hero_id, slot1.skill_id), slot7)) do
				MaterialData:ModifyNum(slot7, -1 * slot8)
			end

			HeroData:HeroSkillUpgrade(slot1.hero_id, slot1.skill_id, slot1.num)
		end

		manager.notify:CallUpdateFunc(HERO_SKILL_UPGRADE, slot0, slot1)
	end,
	SelectSkin = function (slot0, slot1)
		if slot0 == slot1 then
			slot1 = 0
		end

		return manager.net:SendWithLoadingNew(14034, {
			hero_id = slot0,
			skin_id = slot1
		}, 14035, uv0.OnSelectSkin)
	end,
	HeroStarUp = function (slot0)
		manager.net:SendWithLoadingNew(14012, {
			id = slot0
		}, 14013, uv0.OnHeroStarUp)
	end,
	OnHeroStarUp = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot3 = HeroStarCfg[HeroData:GetHeroData(slot1.id).star]

			CurrencyData:CurrencyModify(CurrencyConst.CURRENCY_TYPE_GOLD, -1 * slot3.gold_cost)
			HeroData:HeroPieceModify(slot1.id, -1 * slot3.star_up)
			HeroData:HeroStarUp(slot1.id)
		end

		manager.notify:CallUpdateFunc(HERO_STAR_UP, slot0, slot1)
	end,
	OnSelectSkin = function (slot0, slot1)
		if isSuccess(slot0.result) then
			HeroData:SelectSkin(slot1.hero_id, slot1.skin_id)
		else
			ShowTips(slot0.result)
		end

		manager.notify:CallUpdateFunc(HERO_SKIN_SELECT, slot0, slot1)
	end,
	SkinAdd = function (slot0)
		table.insert(HeroData:GetHeroData(SkinCfg[slot0].hero).unlocked_skin, slot0)
		PlayerAction.UnlockPortrait(SkinCfg[slot0].portrait)
	end,
	SendGift = function (slot0, slot1, slot2)
		uv0 = slot2

		manager.net:SendWithLoadingNew(14100, {
			archive_id = slot0,
			gift_list = slot1
		}, 14101, uv1.OnSendGift)
	end,
	OnSendGift = function (slot0, slot1)
		if isSuccess(slot0.result) then
			for slot5, slot6 in pairs(slot1.gift_list) do
				MaterialData:ModifyNum(slot6.id, -slot6.num)
			end

			ArchiveData:AddExp(slot1.archive_id, uv0)
			ArchiveData:AddGift(slot1.archive_id, slot1.gift_list)
			uv1.UpdateHeartRedPoint()
			uv1.UpdateStoryRedPoint()
			manager.notify:CallUpdateFunc(HERO_SEND_GIFT, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	UpdateStoryRedPoint = function ()
		function slot0(slot0)
			for slot5, slot6 in ipairs(HeroRecordCfg[slot0].plot_id) do
				slot8 = IsConditionAchieved(GameSetting.hero_plot_unlock_condition.value[slot5], {
					heroId = slot0
				})
				slot9 = true
				slot10 = nil

				if slot5 > 1 then
					slot9 = ArchiveData:IsStoryRead(slot0, HeroRecordCfg[slot0].plot_id[slot5 - 1])
				end

				slot10 = ArchiveData:IsStoryRead(slot0, HeroRecordCfg[slot0].plot_id[slot5])

				if slot8 and slot9 and not slot10 then
					return true
				end
			end

			return false
		end

		if not ArchiveData:GetArchiveList() then
			return
		end

		for slot5, slot6 in pairs(slot1) do
			manager.redPoint:setTip(RedPointConst.HERO_STORY_ID .. slot5, slot0(slot5) and 1 or 0)
		end
	end,
	UpdateHeartRedPoint = function ()
		if not HeroRecordCfg.all then
			return
		end

		for slot4, slot5 in pairs(slot0) do
			manager.redPoint:setTip(RedPointConst.HERO_HEARTLINK_ID .. slot5, ArchiveRedPoint.ShowHeartLinkRedPoint(slot5) and 1 or 0)
		end
	end,
	ReadStory = function (slot0, slot1)
		ArchiveData:SetStoryRead(slot0, slot1)
		uv0.UpdateStoryRedPoint()
		manager.net:SendWithLoadingNew(14104, {
			archive_id = slot0,
			video_list = {
				slot1
			}
		}, 14105, uv0.OnReadStory)
	end,
	OnReadStory = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	ReadHeartLink = function (slot0, slot1)
		ArchiveData:SetHeartRead(slot0, slot1)
		manager.net:SendWithLoadingNew(14102, {
			archive_id = slot0,
			text_list = {
				slot1
			}
		}, 14103, uv0.OnReadHeartLink)
	end,
	OnReadHeartLink = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	SetFavoriteHeroOn = function (slot0)
		manager.net:SendWithLoadingNew(14106, {
			hero_id = slot0
		}, 14107, uv0.OnSetFavoriteHeroOn)
	end,
	OnSetFavoriteHeroOn = function (slot0, slot1)
		if isSuccess(slot0.result) then
			HeroData:SetFavoriteHeroOn(slot1.hero_id)
			manager.notify:Invoke(FAVORITE_HERO)
		else
			ShowTips(slot0.result)
		end
	end,
	SetFavoriteHeroOff = function (slot0)
		manager.net:SendWithLoadingNew(14108, {
			hero_id = slot0
		}, 14109, uv0.OnSetFavoriteHeroOff)
	end,
	OnSetFavoriteHeroOff = function (slot0, slot1)
		if isSuccess(slot0.result) then
			HeroData:SetFavoriteHeroOff(slot1.hero_id)
			manager.notify:Invoke(FAVORITE_HERO)
		else
			ShowTips(slot0.result)
		end
	end,
	UnLockSkin = function (slot0)
		manager.net:SendWithLoadingNew(14110, {
			skin_id = slot0
		}, 14111, uv0.OnUnLockSkin)
	end,
	OnUnLockSkin = function (slot0, slot1)
		if isSuccess(slot0.result) then
			HeroAction.GetSkinAni(slot1.skin_id)
		else
			ShowTips(slot0.result)
		end
	end,
	TryToImproveTransitionGiftPt = function (slot0, slot1, slot2, slot3)
		slot5 = manager.net

		slot5:SendWithLoadingNew(14112, {
			hero_id = slot0,
			slot_id = slot1,
			lv_up_num = slot2
		}, 14113, function (slot0)
			if isSuccess(slot0.result) then
				slot4 = uv0

				HeroData:ImproveTransitionGiftPt(slot4)

				for slot4, slot5 in ipairs(uv1) do
					slot7 = slot5.num

					if ItemCfg[slot5.id].type == ItemConst.ITEM_TYPE.CURRENCY then
						CurrencyData:CurrencyModify(slot6, -1 * slot7)
					else
						MaterialData:ModifyNum(slot6, -1 * slot7)
					end
				end

				manager.notify:Invoke(IMPROVE_TRANSITION_GIFT_PT)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	TryToSaveTransitionSkill = function (slot0, slot1, slot2, slot3)
		slot5 = manager.net

		slot5:SendWithLoadingNew(14114, {
			hero_id = slot0,
			slot_id = slot1,
			skill_list = slot2
		}, 14115, function (slot0)
			if isSuccess(slot0.result) then
				HeroData:ModifyTransitionSkill(uv0)

				if uv1 then
					uv1()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	TryToLevelUpModule = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(14116, {
			hero_id = slot0
		}, 14117, function (slot0)
			if isSuccess(slot0.result) then
				if WeaponModuleCfg[uv0].cost[HeroData:GetCurModuleLevel(uv0) + 1] and slot2[1] then
					for slot6, slot7 in pairs(slot2) do
						if slot7[1] == CurrencyConst.CURRENCY_TYPE_GOLD then
							CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_GOLD, -slot7[2])
						else
							MaterialAction.MaterialModify(slot7[1], -slot7[2])
						end
					end
				end

				HeroData:ModuleLevelUp(uv0)
				HeroAction.UpdateModuleRedPointByHeroID(uv0)

				if HeroData:GetCurModuleLevel(uv0) > 1 then
					JumpTools.OpenPageByJump("weaponModuleLevelUpPopView", {
						heroID = uv0
					})
				else
					JumpTools.OpenPageByJump("/weaponModuleUnlockPopView", {
						heroID = uv0
					})
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ResolveModuleItem = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(14118, {
			item_list = slot0
		}, 14119, function (slot0, slot1)
			if isSuccess(slot0.result) then
				manager.notify:CallUpdateFunc(ON_RESOLVE_MODULE_ITEM, slot0, slot1.item_list)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	GetSkinAni = function (slot0)
		getReward({
			{
				slot0,
				1
			}
		}, {
			ItemConst.ITEM_TYPE.HERO_SKIN
		})
		HeroAction.SkinAdd(slot0)
		HeroAction.UpdateHeroSkinRedPoint(SkinCfg[slot0].hero)
	end,
	UpdateAllSkinRedPoint = function ()
		for slot4, slot5 in pairs(HeroData:GetHeroList()) do
			slot6 = slot5.unlocked_skin
			slot7 = slot5.unlock > 0
			slot11 = slot5.id

			for slot11, slot12 in pairs(SkinCfg.get_id_list_by_hero[slot11]) do
				slot13 = RedPointConst.HERO_SKIN_ID_EXTEND .. slot12

				if slot7 and not table.indexof(slot6, slot12) and HeroTools.GetSkinIsCanUnlockAndGet(slot12) then
					manager.redPoint:setTip(slot13, 1)
				else
					manager.redPoint:setTip(slot13, 0)
				end
			end
		end
	end,
	UpdateHeroSkinRedPoint = function (slot0)
		slot1 = HeroData:GetHeroList()
		slot2 = slot1[slot0].unlocked_skin
		slot3 = slot1[slot0].unlock > 0

		for slot7, slot8 in pairs(SkinCfg.get_id_list_by_hero[slot0]) do
			slot9 = RedPointConst.HERO_SKIN_ID_EXTEND .. slot8

			if slot3 and not table.indexof(slot2, slot8) and HeroTools.GetSkinIsCanUnlockAndGet(slot8) then
				manager.redPoint:setTip(slot9, 1)
			else
				manager.redPoint:setTip(slot9, 0)
			end
		end
	end,
	RefreshHeroRedPointAfterSeverSendData = function ()
		uv0.UpdateAllSkinRedPoint()
	end,
	UpdateModuleRedPointByHeroID = function (slot0)
		if WeaponModuleCfg[slot0] == nil then
			return
		end

		slot4 = RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. slot0

		if HeroData:GetModuleMaxLevel(slot0) <= HeroData:GetCurModuleLevel(slot0) then
			manager.redPoint:setTip(slot4, 0)

			return
		end

		slot5 = slot1.condition[slot2 + 1]
		slot7 = {}
		slot8 = 0

		for slot12, slot13 in pairs(slot1.cost[slot2 + 1]) do
			if slot13[1] == 2 then
				slot8 = slot13[2]
			else
				table.insert(slot7, slot13)
			end
		end

		if not checkGold(slot8, false) then
			manager.redPoint:setTip(slot4, 0)

			return
		end

		if not HeroData:GetModuleAssignmentIsFinish(slot0) then
			manager.redPoint:setTip(slot4, 0)

			return
		end

		if slot5 and slot5[1] then
			for slot12, slot13 in pairs(slot5) do
				if not IsConditionAchieved(slot13, {
					heroId = slot0
				}) then
					manager.redPoint:setTip(slot4, 0)

					return
				end
			end
		end

		for slot12, slot13 in pairs(slot7) do
			if MaterialData:GetMaterial(slot13[1]).num < slot13[2] then
				manager.redPoint:setTip(slot4, 0)

				return
			end
		end

		manager.redPoint:setTip(slot4, 1)
	end
}
