slot0 = class("EquipCultureView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipCultureUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.selectIndex_ = -1

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.group = {
		slot0.btn_detail,
		slot0.btn_strength,
		slot0.btn_upgrade,
		slot0.btn_enchant,
		slot0.btn_race,
		slot0.btn_inherit
	}
	slot0.equipTgl_ = {}
	slot0.btnCon_ = {}

	for slot4 = 1, 6 do
		slot0.equipTgl_[slot4] = slot0["equipBtn_" .. slot4]
		slot0.btnCon_[slot4] = ControllerUtil.GetController(slot0.equipTgl_[slot4].transform, "state")
	end

	slot0.itemGo_ = {}
	slot0.itemImg_ = {}

	for slot4 = 1, 3 do
		slot0.itemGo_[slot4] = slot0["itemGo_" .. slot4]
		slot0.itemImg_[slot4] = slot0["itemImg_" .. slot4]
	end

	slot0.heroEquipCon_ = ControllerUtil.GetController(slot0.transform_, "heroEquip")
	slot0.heroCampCon_ = ControllerUtil.GetController(slot0.heroGo_.transform, "name")
end

function slot0.AddUIListener(slot0)
	slot0.toggleObject = {}

	for slot4, slot5 in pairs(slot0.group) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0:GoToTarget(uv1)

			if uv1 == 1 then
				OperationRecorder.Record("equip", "detailView")
			elseif uv1 == 2 then
				OperationRecorder.Record("equip", "strength")
			elseif uv1 == 4 then
				OperationRecorder.Record("equip", "enabled")
			elseif uv1 == 5 then
				OperationRecorder.Record("equip", "reconstruct")
			elseif uv1 == 3 then
				OperationRecorder.Record("equip", "break")
			elseif uv1 == 6 then
				OperationRecorder.Record("equip", "inherit")
			end
		end)
		table.insert(slot0.toggleObject, {
			select = slot0:FindGo("layout/select", slot5.transform),
			unselect = slot0:FindGo("layout/unselect", slot5.transform)
		})
	end

	for slot4 = 1, 6 do
		slot0:AddBtnListener(slot0.equipTgl_[slot4], nil, function ()
			if uv0.equipList_[uv1] and uv0.index_ ~= uv1 then
				uv0.index_ = uv1

				uv0:RefreshPage(uv0.equipList_[uv1])
				uv0:RefreshBtn()
			end
		end)
	end

	slot0:AddDragListener(slot0.listGo_, function ()
	end, function ()
	end, function (slot0, slot1)
		uv0:RemoveTween()

		if uv0.content_.localPosition.x < -1 * uv0.itemGo_[2].transform.sizeDelta.x / 2 then
			slot5 = LeanTween.moveLocal(uv0.content_.gameObject, Vector3(-slot3, 0, 0), 0.25)
			uv0.tween_ = slot5:setOnComplete(LuaHelper.VoidAction(function ()
				uv0.index_ = uv0.equipPos_[uv0:GetRealIndex(table.indexof(uv0.equipPos_, uv0.index_) + 1)]

				uv0:RefreshPage(uv0.equipList_[uv0.index_])
				uv0:RefreshBtn()
			end))
		elseif slot2 > slot3 / 2 then
			slot5 = LeanTween.moveLocal(uv0.content_.gameObject, Vector3(slot3, 0, 0), 0.25)
			uv0.tween_ = slot5:setOnComplete(LuaHelper.VoidAction(function ()
				uv0.index_ = uv0.equipPos_[uv0:GetRealIndex(table.indexof(uv0.equipPos_, uv0.index_) - 1)]

				uv0:RefreshPage(uv0.equipList_[uv0.index_])
				uv0:RefreshBtn()
			end))
		else
			uv0.tween_ = LeanTween.moveLocal(uv0.content_.gameObject, Vector3(0, 0, 0), 0.25)
		end
	end)
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnComplete(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end
end

function slot0.OnEnter(slot0)
	slot0.equipId = slot0.params_.equipId
	slot0.equip = EquipData:GetEquipData(slot0.equipId)

	if not slot0.equip then
		slot0:Go("/home")

		return
	end

	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/Equip/Portrait/" .. ItemCfg[slot0.equip.prefab_id].icon)
	slot0.index_ = EquipCfg[slot0.equip.prefab_id].pos

	slot0:RefreshEquipBar()
end

function slot0.RefreshEquipBar(slot0)
	slot0.equipPos_ = {}
	slot0.equipList_ = {}

	if not HeroTools.GetEquipMap(HeroData:GetHeroList())[slot0.equipId] or slot2 == 0 then
		slot0.heroEquipCon_:SetSelectedState("false")
		SetActive(slot0.itemGo_[1], false)
		SetActive(slot0.itemGo_[3], false)

		return
	end

	slot0.heroEquipCon_:SetSelectedState("true")

	for slot7, slot8 in ipairs(HeroTools.GetHeroEquipS(slot2)) do
		if slot8.equip_id ~= 0 then
			table.insert(slot0.equipPos_, slot8.pos)

			slot0.equipList_[slot8.pos] = slot8.equip_id
			slot0.equipTgl_[slot8.pos].interactable = true
		else
			slot0.equipTgl_[slot8.pos].interactable = false
		end
	end

	if #slot0.equipPos_ == 1 then
		SetActive(slot0.itemGo_[1], false)
		SetActive(slot0.itemGo_[3], false)
	else
		SetActive(slot0.itemGo_[1], true)
		SetActive(slot0.itemGo_[3], true)
	end

	slot0:Render()
	slot0:RefreshHero(slot2)
	slot0:RefreshBtn()
end

function slot0.Render(slot0)
	slot0.itemImg_[2].sprite = getSpriteWithoutAtlas("Textures/Equip/Portrait/" .. ItemCfg[slot0.equip.prefab_id].icon)
	slot2 = table.indexof(slot0.equipPos_, EquipCfg[slot0.equip.prefab_id].pos)
	slot0.itemImg_[1].sprite = getSpriteWithoutAtlas("Textures/Equip/Portrait/" .. ItemCfg[EquipData:GetEquipData(slot0.equipList_[slot0.equipPos_[slot0:GetRealIndex(slot2 - 1)]]).prefab_id].icon)
	slot0.itemImg_[3].sprite = getSpriteWithoutAtlas("Textures/Equip/Portrait/" .. ItemCfg[EquipData:GetEquipData(slot0.equipList_[slot0.equipPos_[slot0:GetRealIndex(slot2 + 1)]]).prefab_id].icon)
	slot0.content_.localPosition = Vector3(0, 0, 0)
end

function slot0.GetRealIndex(slot0, slot1)
	if slot1 > #slot0.equipPos_ then
		return 1
	elseif slot1 < 1 then
		return #slot0.equipPos_
	else
		return slot1
	end
end

function slot0.RefreshHero(slot0, slot1)
	slot0.heroIcon_.sprite = ItemTools.getItemSprite(HeroTools.HeroUsingSkinInfo(slot1).id)

	slot0.heroIcon_:SetNativeSize()
	slot0.heroCampCon_:SetSelectedState(HeroCfg[slot1].race)
end

function slot0.RefreshBtn(slot0)
	for slot4, slot5 in ipairs(slot0.btnCon_) do
		if slot4 == slot0.index_ then
			slot5:SetSelectedState("select")
		elseif slot0.equipList_[slot4] then
			slot5:SetSelectedState("have")
		else
			slot5:SetSelectedState("no")
		end
	end
end

function slot0.OnUpdate(slot0)
	slot0:NotifyToggleOn(slot0.params_.pageIndex or 1)

	slot0.equip = EquipData:GetEquipData(slot0.equipId)

	if not slot0.equip then
		return
	end

	slot2 = EquipCfg[slot0.equip.prefab_id]
	slot3 = slot0.equip.now_break_level + 1

	if slot0.equip:GetMaxLv() <= slot0.equip:GetLevel() and slot0.equip.now_break_level < slot2.break_times_max then
		SetActive(slot0.gameObject_strength, false)
		SetActive(slot0.gameObject_upgrade, true)
	else
		SetActive(slot0.gameObject_strength, true)
		SetActive(slot0.gameObject_upgrade, false)
	end

	SetActive(slot0.gameObject_race, slot2.starlevel >= 5 and true or false)

	if slot2.slot_num and slot2.slot_num > 0 then
		SetActive(slot0.gameObject_enchant, true)
	else
		SetActive(slot0.gameObject_enchant, false)
	end

	if slot2.starlevel >= 5 and slot0.equip.race ~= 0 and table.keyof(RaceEffectCfg.all, slot0.equip.race) == nil then
		SetActive(slot0.gameObject_inherit, true)
		SetActive(slot0.gameObject_race, false)

		if slot0.params_.pageIndex == 5 then
			slot0:GoToTarget(1, {
				skipLockTips = true
			})
		end
	else
		SetActive(slot0.gameObject_inherit, false)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveTween()
	uv0.super.Dispose(slot0)
end

function slot0.GoToTarget(slot0, slot1, slot2)
	if slot1 == slot0.params_.pageIndex then
		return
	end

	slot0.equip = EquipData:GetEquipData(slot0.equipId)
	slot3 = EquipCfg[slot0.equip.prefab_id]
	slot4 = {
		equipId = slot0.equipId,
		extra = slot2
	}

	if slot1 == 1 then
		slot0:Go("equipCultureView/equipDetail", slot4)
	elseif slot1 == 2 or slot1 == 3 then
		slot5 = slot0.equip.now_break_level + 1

		if slot0.equip:GetLevel() < slot0.equip:GetMaxLv() then
			slot0:Go("equipCultureView/equipStrengthView", slot4)
		elseif slot0.equip.now_break_level < slot3.break_times_max then
			slot0:Go("equipCultureView/equipUpgradeView", slot4)
		else
			ShowTips("ERROR_USER_MAX_LV")

			return
		end
	elseif slot1 == 4 then
		slot0:Go("equipCultureView/equipEnchantMainView", slot4)
	elseif slot1 == 5 then
		slot0:Go("equipCultureView/equipRaceView", slot4)

		if slot0.equip.race_preview ~= 0 then
			JumpTools.OpenPageByJump("/equipRaceConfirmView", slot4)
		end
	elseif slot1 == 6 then
		slot0:Go("equipCultureView/equipInherit", {
			isEnter = true,
			equipId = slot0.equipId,
			inheritHandler = handler(slot0, slot0.OnEquipInherit)
		})
	else
		print("EquipCultureView not realize" .. slot1)
	end

	slot0:NotifyToggleOn(slot1)
end

function slot0.RefreshPage(slot0, slot1)
	if slot0.equipId == slot1 then
		return
	end

	slot0.equipId = slot1
	slot0.equip = EquipData:GetEquipData(slot0.equipId)
	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/Equip/Portrait/" .. ItemCfg[slot0.equip.prefab_id].icon)
	slot2 = EquipCfg[slot0.equip.prefab_id]

	if slot0.params_.pageIndex == 1 then
		manager.notify:CallUpdateFunc(EQUIP_CHANGE, slot0.equipId)
	elseif slot0.params_.pageIndex == 2 or slot0.params_.pageIndex == 3 then
		slot3 = EquipCfg[slot0.equip.prefab_id]
		slot4 = slot0.equip.now_break_level + 1

		if slot0.equip:GetMaxLv() <= slot0.equip:GetLevel() and slot0.equip.now_break_level < slot3.break_times_max then
			if slot0.params_.pageIndex == 2 then
				slot0:GoToTarget(3)
			else
				manager.notify:CallUpdateFunc(EQUIP_CHANGE, slot0.equipId)
			end
		elseif slot0.equip.now_break_level < slot3.break_times_max then
			if slot0.params_.pageIndex == 3 then
				slot0:GoToTarget(2)
			else
				manager.notify:CallUpdateFunc(EQUIP_CHANGE, slot0.equipId)
			end
		else
			slot0:GoToTarget(1)
		end
	elseif slot2.starlevel < 5 then
		slot0:GoToTarget(1)
	elseif slot0.params_.pageIndex == 4 then
		manager.notify:CallUpdateFunc(EQUIP_CHANGE, slot0.equipId)
	elseif slot0.params_.pageIndex == 5 then
		manager.notify:CallUpdateFunc(EQUIP_CHANGE, slot0.equipId)

		if slot0.equip.race_preview ~= 0 then
			JumpTools.OpenPageByJump("/equipRaceConfirmView", {
				equipId = slot0.equipId
			})
		end
	elseif slot0.params_.pageIndex == 6 then
		if slot2.starlevel >= 5 and slot0.equip.race ~= 0 and table.keyof(RaceEffectCfg.all, slot0.equip.race) == nil then
			manager.notify:CallUpdateFunc(EQUIP_CHANGE, slot0.equipId)
		else
			slot0:GoToTarget(1)
		end
	end

	slot0:OnUpdate(EQUIP_CHANGE)
	slot0:Render()
end

function slot0.NotifyToggleOn(slot0, slot1)
	for slot5, slot6 in pairs(slot0.toggleObject) do
		if slot5 == slot1 then
			SetActive(slot6.select, true)
			SetActive(slot6.unselect, false)
		else
			SetActive(slot6.select, false)
			SetActive(slot6.unselect, true)
		end
	end

	slot0.params_.pageIndex = slot1
end

function slot0.OnEquipInherit(slot0)
	slot0.equip = EquipData:GetEquipData(slot0.equipId)
	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/Equip/Portrait/" .. ItemCfg[slot0.equip.prefab_id].icon)
end

return slot0
