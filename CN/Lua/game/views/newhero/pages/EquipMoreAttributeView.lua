slot0 = class("EquipMoreAttributeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Equip/EquipMoreAttributesUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lvText_ = {}
	slot0.starCon_ = {}
	slot0.raceCon_ = {}
	slot0.activeGo_ = {}
	slot0.raceIcon_ = {}
	slot0.equipIcon_ = {}

	for slot4 = 1, 6 do
		slot0.lvText_[slot4] = slot0["lvText_" .. slot4]
		slot0.starCon_[slot4] = ControllerUtil.GetController(slot0["item_" .. slot4].transform, "star")
		slot0.raceCon_[slot4] = ControllerUtil.GetController(slot0["item_" .. slot4].transform, "race")
		slot0.activeGo_[slot4] = slot0["activeGo_" .. slot4]
		slot0.raceIcon_[slot4] = slot0["raceIcon_" .. slot4]
		slot0.equipIcon_[slot4] = slot0["equipIcon_" .. slot4]
	end

	slot0.attributeList_ = {}
	slot0.attributeInfo_ = {}
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, EquipAttributeItem)
	slot0.equipHeroSkillView_ = EquipNewSkillInfoView.New(slot0.equipHeroSkillGo_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.attributeList_[slot1]

	slot2:RefreshUI(slot3, slot0.attributeInfo_[slot3], slot0.isAdd_)
	slot2:RegistCallBack(function (slot0)
		SetActive(uv0.maskGo_, true)
		SetActive(uv0.equipHeroSkillGo_, true)
		uv0.equipHeroSkillView_:RefreshData(uv0, slot0)
	end)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:HideInfoView()
	end)
end

function slot0.OnEnter(slot0)
	slot0.equipList_ = slot0.params_.equipList
	slot0.heroID_ = slot0.params_.heroID
	slot0.isAdd_ = slot0.params_.isAdd
	slot0.attributeList_ = {}
	slot0.attributeInfo_ = {}

	slot0:HideInfoView()
	slot0:RefreshUI()
end

function slot0.HideInfoView(slot0)
	SetActive(slot0.maskGo_, false)
	SetActive(slot0.equipHeroSkillGo_, false)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshEquip()
	slot0:RefreshList()
end

function slot0.RefreshEquip(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.equipList_) do
		slot8 = EquipCfg[slot6.prefab_id]
		slot9 = slot8.pos

		table.insert(slot1, slot9)

		slot0.lvText_[slot9].text = slot6:GetLevel()

		slot0.starCon_[slot9]:SetSelectedState(slot8.starlevel)

		if slot6.race ~= 0 then
			if table.keyof(RaceEffectCfg.all, slot6.race) ~= nil then
				slot0.raceIcon_[slot9].sprite = getSprite("Atlas/Item", string.format("icon_group_%d_c", slot6.race))
			else
				slot0.raceIcon_[slot9].sprite = HeroTools.GetSmallHeadSprite(slot6.race)
			end

			slot0.raceCon_[slot9]:SetSelectedState("0")
		else
			slot0.raceCon_[slot9]:SetSelectedState("0")
		end

		slot15 = ItemCfg[slot7].icon
		slot14 = SpritePathCfg.EquipIcon.path .. slot15

		SetSpriteWithoutAtlasAsync(slot0.equipIcon_[slot9], slot14)

		for slot14, slot15 in ipairs(slot8.effect) do
			if slot15 and slot8.effect_unlock_level[slot14] <= slot10 then
				if not slot0.attributeInfo_[slot15[1]] then
					slot0.attributeInfo_[slot15[1]] = {}

					table.insert(slot0.attributeList_, slot15[1])
				end

				table.insert(slot0.attributeInfo_[slot15[1]], {
					pos = slot8.pos,
					level = slot15[2]
				})
			end
		end

		for slot14, slot15 in ipairs(slot6.enchant) do
			for slot19, slot20 in ipairs(slot15) do
				if slot20 and slot20.id then
					if not slot0.attributeInfo_[slot20.id] then
						slot0.attributeInfo_[slot20.id] = {}

						table.insert(slot0.attributeList_, slot20.id)
					end

					table.insert(slot0.attributeInfo_[slot20.id], {
						pos = slot8.pos,
						level = slot20.num
					})
				end
			end
		end
	end

	for slot5 = 1, 6 do
		SetActive(slot0.activeGo_[slot5], table.indexof(slot1, slot5) ~= false)
	end
end

function slot0.RefreshList(slot0)
	slot1 = HeroCfg[slot0.heroID_].equip_skill

	table.sort(slot0.attributeList_, function (slot0, slot1)
		slot3 = table.indexof(uv0, slot1)

		if table.indexof(uv0, slot0) and slot3 then
			return slot2 < slot3
		elseif slot2 or slot3 then
			return slot2 ~= false
		else
			return slot0 < slot1
		end
	end)
	slot0.scrollHelper_:StartScroll(#slot0.attributeList_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
