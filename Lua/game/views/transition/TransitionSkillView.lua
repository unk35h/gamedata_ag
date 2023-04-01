slot0 = class("TransitionSkillView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Equip/TransitionSkillUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.btn_ = {}
	slot0.btnCon_ = {}

	for slot4 = 1, 6 do
		slot0.btn_[slot4] = slot0["btn_" .. slot4]
		slot0.btnCon_[slot4] = ControllerUtil.GetController(slot0.btn_[slot4].transform, "state")
	end

	slot0.tryToImproveTransitionGiftPtHandler_ = handler(slot0, slot0.OnTryToImproveTransitionGiftPt)
	slot0.upCon_ = ControllerUtil.GetController(slot0.transform_, "up")
	slot0.grayCon_ = ControllerUtil.GetController(slot0.transform_, "btn")
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.emptyCon_ = ControllerUtil.GetController(slot0.transform_, "empty")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, TransitionSkillItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot3, slot0.curUseList_[slot0.list_[slot1]] or 1)
	slot2:SetUsed(slot0:IsUsed(slot3))
	slot2:SetSelect(slot0.curSelectID_ == slot3)
	slot2:RegistCallBack(function ()
		uv0.curSelectID_ = uv1

		uv0.scrollHelper_:Refresh()
		uv0:RefreshRight()
	end)
end

function slot0.AddUIListeners(slot0)
	for slot4, slot5 in ipairs(slot0.btn_) do
		slot0:AddBtnListener(slot5, nil, function ()
			if uv0.index_ == uv1 then
				return
			end

			uv0:SaveData()

			uv0.index_ = uv1

			uv0:GetData()
			uv0:RefreshUI()
			uv0:RefreshIndex()
		end)
	end

	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		uv0.curUseList_ = {
			all = {}
		}

		uv0.scrollHelper_:Refresh()
		uv0:RefreshType()
	end)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		JumpTools.OpenPageByJump("transitionGiftPt", {
			isEnter = true,
			giftPt = uv0.curGiftPt_,
			heroID = uv0.heroID_,
			index = uv0.index_
		})
	end)
	slot0:AddBtnListener(slot0.activeBtn_, nil, function ()
		if GameSetting.exclusive_skill_use_num_max.value[1] <= #uv0.curUseList_.all then
			ShowTips("EXCLUSIVE_SKILL_MAX")

			return
		end

		if uv0.leftPt_ <= 0 then
			JumpTools.OpenPageByJump("transitionGiftPt", {
				isEnter = true,
				giftPt = uv0.curGiftPt_,
				heroID = uv0.heroID_,
				index = uv0.index_
			})

			return
		end

		uv0.curUseList_[uv0.curSelectID_] = 1

		table.insert(uv0.curUseList_.all, uv0.curSelectID_)
		uv0.scrollHelper_:Refresh()
		uv0:RefreshType()
		ShowTips("EXCLUSIVE_SKILL_LOAD")
	end)
	slot0:AddBtnListener(slot0.upBtn_, nil, function ()
		if uv0.leftPt_ <= 0 then
			JumpTools.OpenPageByJump("transitionGiftPt", {
				isEnter = true,
				giftPt = uv0.curGiftPt_,
				heroID = uv0.heroID_,
				index = uv0.index_
			})

			return
		end

		uv0.curUseList_[uv0.curSelectID_] = uv0.curUseList_[uv0.curSelectID_] + 1

		uv0.scrollHelper_:Refresh()
		uv0:RefreshType()
		ShowTips("EXCLUSIVE_SKILL_LEVEL_UP")
	end)
	slot0:AddBtnListener(slot0.removeBtn_, nil, function ()
		table.remove(uv0.curUseList_.all, table.indexof(uv0.curUseList_.all, uv0.curSelectID_))

		uv0.curUseList_[uv0.curSelectID_] = nil

		uv0.scrollHelper_:Refresh()
		uv0:RefreshType()
		ShowTips("EXCLUSIVE_SKILL_UNLOAD")
	end)
end

function slot0.OnEnter(slot0)
	slot0.index_ = slot0.params_.index
	slot0.heroID_ = slot0.params_.heroID
	slot0.heroInfo_ = HeroData:GetHeroData(slot0.heroID_)

	slot0:GetData()
	slot0:RefreshUI()
	slot0:RefreshIndex()
	manager.notify:RegistListener(IMPROVE_TRANSITION_GIFT_PT, slot0.tryToImproveTransitionGiftPtHandler_)
end

function slot0.GetData(slot0)
	slot0:GetUseList()
	slot0:GetCurUseList()
end

function slot0.GetUseList(slot0)
	slot0.useList_ = {}
	slot1 = slot0.heroInfo_.transition or {}
	slot0.curGiftPt_ = 0

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot6.slot_id
		slot0.useList_[slot7] = deepClone(slot6.skill_list)

		if slot7 == slot0.index_ then
			slot0.curGiftPt_ = slot6.talent_points

			break
		end
	end
end

function slot0.GetCurUseList(slot0)
	slot0.curUseList_ = {
		all = {}
	}
	slot1 = ipairs
	slot3 = slot0.useList_[slot0.index_] or {}

	for slot4, slot5 in slot1(slot3) do
		slot6 = slot5.skill_id
		slot0.curUseList_[slot6] = slot5.skill_level

		table.insert(slot0.curUseList_.all, slot6)
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshList()
	slot0:RefreshType()
end

function slot0.RefreshList(slot0)
	slot0.list_ = HeroCfg[slot0.heroID_].hero_equip_skill[slot0.index_] or {}

	table.sort(slot0.list_, function (slot0, slot1)
		if uv0:IsUsed(slot0) ~= uv0:IsUsed(slot1) then
			return uv0:IsUsed(slot0)
		end

		if uv0:IsUsed(slot0) and uv0:IsUsed(slot1) and uv0.curUseList_[slot0] ~= uv0.curUseList_[slot1] then
			return slot3 < slot2
		end

		return slot0 < slot1
	end)

	slot0.curSelectID_ = slot0.list_[1]

	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.RefreshType(slot0)
	slot5 = GameSetting.exclusive_skill_use_num_max.value[1]
	slot0.activeSkill_.text = #slot0.curUseList_.all .. "/" .. slot5
	slot0.leftPt_ = slot0.curGiftPt_

	for slot5, slot6 in ipairs(slot0.curUseList_.all) do
		slot0.leftPt_ = slot0.leftPt_ - slot0.curUseList_[slot6]
	end

	slot0.leftGiftPt_.text = slot0.leftPt_ .. "/" .. slot0.curGiftPt_

	slot0.emptyCon_:SetSelectedState(slot0.leftPt_ <= 0 and "true" or "false")
	slot0.upCon_:SetSelectedState(GameSetting.exclusive_skill_talent_num_max.value[1] <= slot0.curGiftPt_ and "off" or "on")
	slot0:RefreshRight()
end

function slot0.RefreshRight(slot0)
	slot0.name_.text = EquipSkillCfg[slot0.curSelectID_].name
	slot0.icon_.sprite = getEquipSkillSprite(slot0.curSelectID_)
	slot2 = 0

	if slot0:IsUsed(slot0.curSelectID_) then
		if slot0.curUseList_[slot0.curSelectID_] < slot1.lvmax then
			slot0.typeCon_:SetSelectedState("up")

			slot0.nextDesc_.text = EquipTools.GetSkillDescWithoutNext(slot0.curSelectID_, slot2 + 1, slot0.heroID_)
		else
			slot0.typeCon_:SetSelectedState("max")
		end
	else
		slot2 = 1

		slot0.typeCon_:SetSelectedState("on")
	end

	slot0.grayCon_:SetSelectedState(slot0.leftPt_ <= 0 and "gray" or "normal")

	slot0.level_.text = GetTips("LEVEL") .. slot2
	slot0.desc_.text = EquipTools.GetSkillDescWithoutNext(slot0.curSelectID_, slot2, slot0.heroID_)
end

function slot0.RefreshIndex(slot0)
	for slot4 = 1, 6 do
		if slot4 == slot0.index_ then
			slot0.btnCon_[slot4]:SetSelectedState("select")
		else
			slot0.btnCon_[slot4]:SetSelectedState("have")
		end
	end
end

function slot0.IsUsed(slot0, slot1)
	return slot0.curUseList_[slot1] ~= nil
end

function slot0.IsSelected(slot0, slot1)
	return slot1 == slot0.curSelectID_
end

function slot0.SaveData(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.curUseList_.all) do
		slot2[slot6] = {
			skill_id = slot7,
			skill_level = slot0.curUseList_[slot7]
		}
	end

	HeroAction.TryToSaveTransitionSkill(slot0.heroID_, slot0.index_, slot2, slot1)
end

function slot0.OnTryToImproveTransitionGiftPt(slot0)
	slot0.heroInfo_ = HeroData:GetHeroData(slot0.heroID_)

	ShowTips("EXCLUSIVE_SKILL_POINT_UP")
	slot0:GetUseList()
	slot0.scrollHelper_:Refresh()
	slot0:RefreshType()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EXCLUSIVE_DESCRIPE")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:SaveData()
	manager.notify:RemoveListener(IMPROVE_TRANSITION_GIFT_PT, slot0.tryToImproveTransitionGiftPtHandler_)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
