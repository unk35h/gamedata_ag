slot0 = class("NewHeroTransitionPage", NewHeroPageBase)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:InitItemPool()

	slot0.item_ = {}

	for slot4 = 1, 6 do
		slot0.item_[slot4] = NewHeroTransitionItem.New(slot0["item_" .. slot4], slot4)
	end

	slot0.infoView_ = NewHeroTransitionInfoView.New(slot0.infoViewGo_)
	slot0.emptyCon_ = ControllerUtil.GetController(slot0.transform_, "empty")
	slot0.infoViewCon_ = ControllerUtil.GetController(slot0.transform_, "infoView")
	slot0.loopScrollView_ = LoopScrollView.New(slot0, slot0.scrollView_, slot0.content_.transform, slot0.viewPort_.rect.height, slot0.content_:GetComponent("VerticalLayoutGroup").spacing, true)
end

function slot0.AddUIListeners(slot0)
	for slot4, slot5 in ipairs(slot0.item_) do
		slot5:RegistClickFunc(function (slot0)
			slot4 = uv1
			slot5 = slot0

			uv0:OpenInfoView(slot4, slot5)

			for slot4, slot5 in ipairs(uv0.item_) do
				slot5:SetSelected(uv1)
			end
		end)
	end

	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:CloseInfoView()
	end)
	slot0:AddBtnListener(slot0.changeBtn_, nil, function ()
		JumpTools.OpenPageByJump("/transitionSkill", {
			index = 1,
			heroID = uv0.heroID_
		})
	end)
end

function slot0.OnEnter(slot0, slot1)
	slot0.extra_ = slot1
	slot0.isForeign_ = slot1 and slot1.isForeign
	slot0.isTemp_ = slot1 and slot1.isTemp
	slot0.isPolyhedron_ = slot1 and slot1.isPolyhedron

	if slot1 and slot1.isPolyhedron then
		slot0.extra_ = nil
	end

	slot0:CloseInfoView()
	SetActive(slot0.changeBtn_.gameObject, slot1 == nil)
	slot0:RegistEventListener(HERO_TRANSITION_CHANGE, function (slot0)
		if slot0.heroId == uv0.heroInfo_.id then
			uv0:UpdateView()
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

	slot0.heroID_ = slot0.heroInfo_.id
	slot0.isAdd_ = HeroTools.GetHeroEquipSkillAddLevel(slot0.heroInfo_)

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0:GetUseList()
	slot0.loopScrollView_:NavigateIndex(1)
end

function slot0.GetUseList(slot0)
	slot0.useList_ = {}
	slot0.effectList_ = {
		all = {}
	}
	slot1 = slot0.heroInfo_.equip
	slot2 = slot0.heroInfo_.transition or {}

	for slot6, slot7 in ipairs(slot2) do
		slot0.useList_[slot7.slot_id] = deepClone(slot7.skill_list)
	end

	for slot6, slot7 in ipairs(slot1) do
		slot8 = slot0.useList_[slot6] or {}

		if slot7.equip_id ~= 0 then
			slot10 = 0
			slot11 = nil

			if slot0.extra_ then
				if slot0.isForeign_ then
					slot11 = ForeignInfoData:GetEquipInfo(slot0.heroInfo_.id, slot6)
				elseif slot0.isTemp_ then
					slot11 = TempHeroData:GetEquipInfo(slot0.extra_.tempHeroList, slot0.heroInfo_.id, slot6)
				elseif slot0.isPolyhedron_ then
					slot11 = EquipData:GetEquipData(slot9)
				end
			else
				slot11 = EquipData:GetEquipData(slot9)
			end

			if slot11 then
				slot10 = slot11:GetLevel()
			end

			if GameSetting.exclusive_open_need.value[1] <= slot10 then
				for slot15, slot16 in ipairs(slot8) do
					if not slot0.effectList_[slot16.skill_id] then
						slot0.effectList_[slot17] = {
							level = 0,
							id = slot17
						}

						table.insert(slot0.effectList_.all, slot17)
					end

					slot0.effectList_[slot17].level = slot0.effectList_[slot17].level + slot16.skill_level
				end

				slot0.item_[slot6]:SetData(slot8, true)
			else
				slot0.item_[slot6]:SetData(slot8, false)
			end
		else
			slot0.item_[slot6]:SetData(slot8, false)
		end
	end

	table.sort(slot0.effectList_.all, function (slot0, slot1)
		if uv0.effectList_[slot0].level ~= uv0.effectList_[slot1].level then
			return slot3 < slot2
		end

		return slot0 < slot1
	end)
	slot0.emptyCon_:SetSelectedState(#slot0.effectList_.all <= 0 and "true" or "false")
end

function slot0.OpenInfoView(slot0, slot1, slot2)
	slot3 = {}

	if slot0.useList_[slot1] then
		slot3 = slot0.useList_[slot1]
	end

	SetActive(slot0.infoViewGo_, true)
	slot0.infoView_:SetData(slot1, slot3, slot2, slot0.heroID_, slot0.isAdd_, slot0.extra_)

	if slot1 <= 3 then
		slot0.infoViewCon_:SetSelectedState("right")
	else
		slot0.infoViewCon_:SetSelectedState("left")
	end
end

function slot0.CloseInfoView(slot0)
	slot4 = false

	SetActive(slot0.infoViewGo_, slot4)

	for slot4, slot5 in ipairs(slot0.item_) do
		slot5:SetSelected(0)
	end
end

function slot0.InitItemPool(slot0)
	slot0.itemPool_ = {}
end

function slot0.LsGetItemData(slot0)
	return slot0.effectList_.all
end

function slot0.LsAddItem(slot0, slot1, slot2)
	slot3 = slot0:GetFreeItem(slot0.itemPool_, function ()
		return NewHeroTransitionSkillItem.New(uv0.tempItem_, uv0.content_)
	end)

	slot3.itemView:SetData(slot0.effectList_[slot1], slot2, slot0.heroID_, slot0.isAdd_)

	return slot3
end

function slot0.GetFreeItem(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot1) do
		if slot7.isFree == true then
			slot7.isFree = false

			return slot7
		end
	end

	slot3 = {
		isFree = false,
		itemView = slot2()
	}

	table.insert(slot1, slot3)

	return slot3
end

function slot0.LsRemoveItem(slot0, slot1)
	slot1.itemView:Show(false)

	slot1.isFree = true
end

function slot0.DisposeItemPool(slot0)
	for slot4, slot5 in ipairs(slot0.itemPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemPool_ = nil
end

function slot0.OnExit(slot0)
	slot0.infoView_:OnExit()

	for slot4, slot5 in ipairs(slot0.item_) do
		slot5:OnExit()
	end

	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.infoView_:Dispose()

	for slot4, slot5 in ipairs(slot0.item_) do
		slot5:Dispose()
	end

	slot0:DisposeItemPool()

	if slot0.loopScrollView_ then
		slot0.loopScrollView_:Dispose()

		slot0.loopScrollView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
