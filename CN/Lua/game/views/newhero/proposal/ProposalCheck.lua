slot0 = class("ProposalCheck", ReduxView)

function slot0.UIName(slot0)
	return "UI/Equip/NewEquipmentUseUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0.equipS_ = {}
	slot0.itemS_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.InitItem(slot0, slot1)
	slot2 = {}
	slot3 = ComponentBinder.GetInstance()

	slot3:BindCfgUI(slot2, slot1)

	slot2.raceStateController_ = ControllerUtil.GetController(slot2.racePanelGo_.transform, "race")
	slot2.gameObject_ = slot1

	function slot2.RefreshUI(slot0, slot1)
		slot0.bgTrs_.localEulerAngles = Vector3.New(0, 0, 60 * (EquipCfg[slot1.prefab_id].pos - 1))

		SetSpriteWithoutAtlasAsync(slot0.iconImg_, SpritePathCfg.EquipIcon.path .. ItemCfg[slot1.prefab_id].icon)

		slot0.lvText_.text = string.format("%d", EquipTools.CountEquipLevel(slot1))

		if (slot1.race or 0) ~= 0 then
			if table.keyof(RaceEffectCfg.all, slot4) ~= nil then
				slot0.raceImg_.sprite = getSprite("Atlas/CampItem", "btn_roledetails_race_" .. slot1.race)
			else
				slot0.raceImg_.sprite = HeroTools.GetSmallHeadSprite(slot4)
			end

			slot0.raceStateController_:SetSelectedState("1")
		else
			slot0.raceStateController_:SetSelectedState("0")
		end

		slot8 = slot1.equiping
		slot0.headiconImg_.sprite = HeroTools.GetSmallHeadSprite(slot8)

		for slot8 = 1, 6 do
			SetActive(slot0["star" .. slot8 .. "Go_"], slot8 <= slot2.starlevel)
		end
	end

	return slot2
end

function slot0.RefreshItems(slot0)
	for slot4 = 1, #slot0.list_ do
		if not slot0.itemS_[slot4] then
			slot5 = Object.Instantiate(slot0.itemGo_, slot0.equipTrs_)
			slot0.itemS_[slot4] = slot0:InitItem(slot5)

			SetActive(slot5, true)
			slot0.itemS_[slot4]:RefreshUI(slot0.list_[slot4])
		else
			SetActive(slot0.itemS_[slot4].gameObject_, true)
			slot0.itemS_[slot4]:RefreshUI(slot0.list_[slot4])
		end
	end

	for slot4 = #slot0.list_ + 1, #slot0.itemS_ do
		SetActive(slot0.itemS_[slot4].gameObject_, false)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_okBtn_, nil, function ()
		slot0 = {}

		for slot4 = 1, #uv0.equipS_ do
			slot0[slot4] = {
				pos = uv0.equipS_[slot4].pos,
				equip_id = uv0.equipS_[slot4].equip_id
			}
		end

		EquipAction.EquipQuickDressOn(uv0.heroID_, slot0)
	end)
	slot0:AddBtnListener(slot0.btn_cancelBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEquipQuickDressOn(slot0, slot1, slot2)
	for slot6 = 1, 6 do
		HeroAction.HeroChangeEquip(slot2.hero_id, slot2.use_equip_list[slot6].equip_id, slot2.use_equip_list[slot6].pos)
	end

	slot0:Back()
end

function slot0.OnEnter(slot0)
	slot0.equipS_ = slot0.params_.equipS
	slot0.heroID_ = slot0.params_.heroID

	slot0:UpdateData()
	slot0:RefreshItems()
end

function slot0.OnExit(slot0)
end

function slot0.UpdateData(slot0)
	slot0.list_ = {}

	for slot4, slot5 in pairs(slot0.equipS_) do
		if slot5.equip_id ~= 0 and slot5.equiping then
			slot7 = deepClone(EquipData:GetEquipData(slot6))
			slot7.equiping = slot5.equiping

			table.insert(slot0.list_, slot7)
		end
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
