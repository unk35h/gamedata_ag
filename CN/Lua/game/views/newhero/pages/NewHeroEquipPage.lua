slot0 = class("NewHeroEquipPage", NewHeroPageBase)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.equipInfoView_ = HeroEquipInfoView.New(slot0, slot0.infoGo_)
	slot0.equipSkillView_ = EquipNewSkillInfoView.New(slot0.equipSkillGo_)
	slot0.equipOverrall_ = EquipOverall.New(slot0.rightGo_)

	slot0.equipOverrall_:RegistSkillClick(handler(slot0, slot0.SkillClick))

	slot0.foreignEquipInfoView_ = ForeignEquipInfoView.New(slot0.foreignEquipInfoGo_)
	slot0.infoViewCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "info")

	if slot0.popPanelTrs_ ~= nil and slot0.handler_ and slot0.handler_.GetPopContainer then
		slot0.popPanelTrs_.parent = slot0.handler_:GetPopContainer()
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:HideMaskMessage()
	end)

	slot1 = slot0.equipInfoView_

	slot1:RegistCallBack(function (slot0)
		slot1 = 0

		if slot0.prefab_id or uv0.extra_ then
			uv0:EquipClick(slot0)
		else
			uv0:Go("/heroEquipBag", {
				isClearPos = true,
				isOpenInfo = true,
				heroId = uv0.heroInfo_.id,
				suitPos = slot0.pos
			})
			OperationRecorder.Record("equip", "equipInfoView")
		end
	end)
end

function slot0.SetHeroInfo(slot0, slot1)
	if slot0.extra_ then
		if slot0.isForeign_ then
			slot0.heroInfo_ = ForeignInfoData:GetHeroInfo(slot1.id)
		elseif slot0.isTemp_ then
			slot0.heroInfo_ = TempHeroData:GetHeroDataByHeroID(slot0.extra_.tempHeroList, slot1.id)
		elseif slot0.isPolyhedron_ then
			slot0.heroInfo_ = PolyhedronData:GetPolyhedronHeroData(slot1.id)
		end
	else
		slot0.heroInfo_ = HeroData:GetHeroData(slot1.id)
	end

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0:RefreshEquipInfo()
	slot0.equipOverrall_:RefreshHeroInfo(slot0.heroInfo_, nil, slot0.extra_)
end

function slot0.RefreshEquipInfo(slot0)
	if slot0.heroInfo_ then
		slot0.equipInfoView_:RefreshData(slot0, slot0.heroInfo_, slot0.extra_)
	end
end

function slot0.SkillClick(slot0, slot1)
	SetActive(slot0.maskGo_, true)
	SetActive(slot0.equipSkillGo_, true)
	slot0.equipSkillView_:RefreshData(slot0, slot1)
end

function slot0.EquipClick(slot0, slot1)
	if slot1.prefab_id == nil then
		return
	end

	if slot0.extra_ then
		slot0.foreignEquipInfoView_:SetState("equipped")
	else
		slot0.foreignEquipInfoView_:SetState("unequipped")
	end

	if EquipCfg[slot1.prefab_id].pos == 1 or slot2 == 2 or slot2 == 3 then
		slot0.infoViewCon_:SetSelectedState("right")
	else
		slot0.infoViewCon_:SetSelectedState("left")
	end

	for slot6 = 1, 6 do
		slot0.equipInfoView_:GetItem(slot6):ShowSelect(slot6 == slot2)
	end

	SetActive(slot0.maskGo_, true)
	SetActive(slot0.foreignEquipInfoGo_, true)
	slot0.foreignEquipInfoView_:RefreshData(slot0, slot1, nil, slot0.heroInfo_.id, slot0.extra_)
	slot0.foreignEquipInfoView_:ShowRaceAdd(HeroCfg[slot0.heroInfo_.id].race == slot1.race or slot0.heroInfo_.id == slot1.race)
end

function slot0.HideMaskMessage(slot0)
	SetActive(slot0.maskGo_, false)
	SetActive(slot0.equipSkillGo_, false)
	SetActive(slot0.equipHeroSkillGo_, false)
	SetActive(slot0.foreignEquipInfoGo_, false)
	slot0.equipOverrall_:Deselect()
	slot0.equipInfoView_:HideSelect()
end

function slot0.OnEnter(slot0, slot1)
	slot0.extra_ = slot1
	slot0.isForeign_ = slot1 and slot1.isForeign
	slot0.isTemp_ = slot1 and slot1.isTemp
	slot0.isPolyhedron_ = slot1 and slot1.isPolyhedron

	slot0:HideMaskMessage()
	slot0.equipOverrall_:OnEnter()
	slot0.equipInfoView_:OnEnter()
	slot0.equipSkillView_:OnEnter()
	slot0.foreignEquipInfoView_:OnEnter()
end

function slot0.OnExit(slot0)
	slot0.equipOverrall_:OnExit()
	slot0.equipInfoView_:OnExit()
	slot0.equipSkillView_:OnExit()
	slot0.foreignEquipInfoView_:OnExit()
end

function slot0.Dispose(slot0)
	slot0.equipInfoView_:Dispose()
	slot0.equipSkillView_:Dispose()
	slot0.equipOverrall_:Dispose()

	if slot0.foreignEquipInfoView_ then
		slot0.foreignEquipInfoView_:Dispose()

		slot0.foreignEquipInfoView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
