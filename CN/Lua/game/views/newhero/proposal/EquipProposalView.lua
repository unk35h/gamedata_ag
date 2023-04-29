slot0 = class("EquipProposalView", ReduxView)
slot1 = {
	"存为新方案",
	"装备",
	"已装备"
}
slot2 = {
	"detail",
	"rough"
}

function slot0.UIName(slot0)
	return "UI/Equip/EquipProposal"
end

function slot0.Convert2SamePosition(slot0, slot1, slot2)
	slot1.position = slot2.position
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.selectItem_ = nil
	slot0.heroEquipProposal_ = 0
	slot0.proposalState_ = 1
	slot0.panelState_ = 1

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.inputHandler_ = handler(slot0, slot0.OnInput)
	slot0.inputCancelHandler_ = handler(slot0, slot0.OnInputCancel)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.gridScroll_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.itemsgroupGo_, ProposalItem)
	slot0.equipOverrall_ = EquipOverall.New(slot0.equipoverrallGo_)

	slot0.equipOverrall_:RegistSkillClick(handler(slot0, slot0.SkillClick2))

	slot0.equipInfoView_ = HeroEquipInfoView.New(slot0, slot0.infoGo_)

	slot0.equipInfoView_:IgnoreAdd()

	slot0.equipSkillView_ = EquipNewSkillInfoView.New(slot0.newequipskillinfouiGo_)
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "btnGroup")

	slot0:Convert2SamePosition(slot0.newequipskillinfouiGo_.transform, slot0.skillpositionTrs_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.saveBtn_, nil, function ()
		if uv0.proposalState_ == "notSave" then
			if GameSetting.equip_proposal_num_max.value[1] < #uv0.sortedList_ then
				ShowTips("ERROR_EQUIP_PROPOSAL_NUM_LIMIT")

				return
			end

			uv0.saveFlag_ = true

			JumpTools.OpenPageByJump("ProposalPopup")
		elseif uv0.proposalState_ == "notEquip" then
			slot1 = {}
			slot2 = HeroData:GetEquipMap()
			slot3 = 0

			for slot7, slot8 in ipairs(uv0.sortedList_[uv0.selectItem_].equip_list) do
				slot1[slot7] = {
					equip_id = slot8.equip_id,
					pos = slot8.pos
				}

				if slot2[slot8.equip_id] and slot9 ~= uv0.heroID_ then
					slot3 = slot3 + 1
					slot1[slot7].equiping = slot9
				end
			end

			if slot3 ~= 0 then
				uv0:Go("ProposalCheck", {
					equipS = slot1
				})
			else
				slot4 = {}

				for slot8 = 1, #slot1 do
					slot4[slot8] = {
						pos = slot1[slot8].pos,
						equip_id = slot1[slot8].equip_id
					}
				end

				EquipAction.EquipQuickDressOn(uv0.heroID_, slot4)
			end
		end
	end)
	slot0:AddBtnListener(slot0.deleteBtn_, nil, function ()
		ProposalAction.DeleteProposal(uv0.sortedList_[uv0.selectItem_].proposal_id)
	end)
	slot0:AddBtnListener(slot0.editBtn_, nil, function ()
		uv0.renameFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:HideMaskMessage()
	end)
end

function slot0.OnEquipQuickDressOn(slot0, slot1, slot2)
	for slot6 = 1, 6 do
		HeroAction.HeroChangeEquip(slot2.hero_id, slot2.use_equip_list[slot6].equip_id, slot2.use_equip_list[slot6].pos)
	end

	slot0:RefreshUI()
	ShowTips("SUCCESS_EQUIP_PROPOSAL")
end

function slot0.OnAddProposal(slot0)
	slot0:RefreshUI()
	ShowTips("SUCCESS_SAVE_EQUIP_PROPOSAL")
end

function slot0.OnModifyProposal(slot0)
	slot1, slot2 = slot0.gridScroll_:GetHeadAndTail()

	if slot0.selectItem_ and slot1 <= slot0.selectItem_ and slot0.selectItem_ <= slot2 then
		slot0.gridScroll_:GetItemByIndex(slot0.selectItem_):RefreshUI(slot0.sortedList_[slot0.selectItem_])
	end

	ShowTips("SUCCESS_SAVE_EQUIP_PROPOSAL")
end

function slot0.OnDeleteProposal(slot0)
	slot0:RefreshUI()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.heroID_ = slot0.params_.heroID
	slot0.proposalList_ = ProposalData:GetProposalData()
	slot0.heroInfo_ = HeroData:GetHeroData(slot0.heroID_)

	slot0:RefreshUI()
	slot0.equipOverrall_:OnEnter()
	slot0.equipInfoView_:OnEnter()
	slot0:HideMaskMessage()
	manager.notify:RegistListener(INPUT_POP_CLICK_OK, slot0.inputHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CLOSE, slot0.inputCancelHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CANCEL, slot0.inputCancelHandler_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0.equipOverrall_:OnExit()
	slot0.equipInfoView_:OnExit()
	slot0:OnInputCancel()
	manager.notify:RemoveListener(INPUT_POP_CLICK_OK, slot0.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CLOSE, slot0.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CANCEL, slot0.inputCancelHandler_)
end

function slot0.RefreshUI(slot0)
	slot0:UpdateData()

	slot0.selectItem_ = 1

	slot0.gridScroll_:StartScroll(#slot0.sortedList_)
	slot0:RefreshRight(1)

	slot0.curproposalText_.text = #slot0.sortedList_ - (slot0.heroEquipProposal_ == 0 and 1 or 0) .. "<color=#686868>/" .. GameSetting.equip_proposal_num_max.value[1] .. "</color>"
end

function slot0.UpdateData(slot0)
	slot0.sortedList_ = {}
	slot1 = HeroTools.GetHeroEquipS(slot0.heroID_)
	slot2 = nil

	for slot6, slot7 in pairs(slot0.proposalList_) do
		if table.equal(slot7.equip_list, slot1, "all") then
			slot2 = slot7
			slot0.sortedList_[1] = slot7
		end
	end

	if slot2 then
		slot0.sortedList_[1] = slot2
	else
		slot0.sortedList_[1] = {
			proposal_id = 0,
			proposal_name = GetTips("CURRENT_SCHEME"),
			equip_list = slot1
		}
	end

	slot3 = 2

	for slot7, slot8 in pairs(slot0.proposalList_) do
		if slot2 then
			if slot8.proposal_id ~= slot2.proposal_id then
				slot0.sortedList_[slot3] = slot8
				slot3 = slot3 + 1
			end
		else
			slot0.sortedList_[slot3] = slot8
			slot3 = slot3 + 1
		end
	end

	slot0.heroEquipProposal_ = slot2 and slot2.proposal_id or 0
end

function slot0.indexItem(slot0, slot1, slot2)
	if slot0.selectItem_ == slot1 then
		slot2:ShowSelect(true)
	else
		slot2:ShowSelect(false)
	end

	slot2:RefreshUI(slot0.sortedList_[slot1])
	slot2:RegistCallBack(function ()
		uv0:SelectItem(uv1)
	end)
end

function slot0.SelectItem(slot0, slot1)
	slot2, slot3 = slot0.gridScroll_:GetHeadAndTail()

	if slot0.selectItem_ and slot2 <= slot0.selectItem_ and slot0.selectItem_ <= slot3 then
		slot0.gridScroll_:GetItemByIndex(slot0.selectItem_):ShowSelect(false)
	end

	slot0.selectItem_ = slot1

	slot0.gridScroll_:GetItemByIndex(slot0.selectItem_):ShowSelect(true)
	slot0:RefreshRight(slot1)
end

function slot0.RefreshRight(slot0, slot1)
	slot0.equipOverrall_:RefreshHeroInfo(slot0.heroInfo_, slot0.sortedList_[slot1].equip_list)
	slot0.equipInfoView_:RefreshUI(slot0.sortedList_[slot1].equip_list)
	slot0:RefreshButtonState(slot0.sortedList_[slot1].proposal_id)
end

function slot0.SkillClick2(slot0, slot1)
	SetActive(slot0.maskGo_, true)
	SetActive(slot0.newequipskillinfouiGo_, true)
	slot0.equipSkillView_:RefreshData(slot0, slot1)
end

function slot0.HideMaskMessage(slot0)
	SetActive(slot0.maskGo_, false)
	SetActive(slot0.newequipskillinfouiGo_, false)
	slot0.equipOverrall_:Deselect()
end

function slot0.RefreshButtonState(slot0, slot1)
	slot2 = nil

	if slot1 == 0 then
		slot2 = "notSave"
		slot0.btnName_.text = GetTips("EQUIP_SAVE")
	else
		slot2 = slot1 ~= slot0.heroEquipProposal_ and "notEquip" or "equipping"
		slot0.btnName_.text = GetTips("EQUIP_ON")
	end

	slot0.proposalState_ = slot2

	slot0.controller_:SetSelectedState(slot2)
end

function slot0.OnInput(slot0, slot1, slot2)
	if not slot0.renameFlag_ and not slot0.saveFlag_ then
		return
	end

	if slot1 == "" then
		ShowTips("INPUT_EQUIP_PROPOSAL_NAME")

		return
	end

	if IsAllSpace(slot1) then
		ShowTips("INPUT_CHAT_CONTENT")

		slot2.text = ""

		return
	end

	slot3, slot4 = textLimit(slot1, GameSetting.user_name_max.value[1])
	slot2.text = slot3

	if not nameRule(slot3) then
		ShowTips("ERROR_USER_NAME_VER_WORD")

		slot2.text = ""

		return
	end

	WordVerifyBySDK(slot1, function (slot0)
		if not slot0 then
			ShowTips("SENSITIVE_WORD")

			uv0.text = ""

			return
		else
			if not uv1 then
				return
			end

			if uv2.renameFlag_ then
				ProposalAction.ModifyProposal(uv2.heroID_, uv3, uv2.sortedList_[uv2.selectItem_].proposal_id)
			else
				ProposalAction.AddProposal(uv2.heroID_, uv3, 0)
			end

			uv2.renameFlag_ = false
			uv2.saveFlag_ = false

			manager.notify:Invoke(INPUT_POP_BACK)
		end
	end)
end

function slot0.OnInputCancel(slot0)
	slot0.renameFlag_ = false
	slot0.saveFlag_ = false
end

function slot0.Dispose(slot0)
	slot0.equipSkillView_:Dispose()
	slot0.equipOverrall_:Dispose()
	slot0.equipInfoView_:Dispose()
	slot0:RemoveAllListeners()
	slot0.gridScroll_:Dispose()

	slot0.inputHandler_ = nil
	slot0.inputCancelHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
