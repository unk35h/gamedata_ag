slot0 = class("ReservesItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroGo_ = {}
	slot0.heroImg_ = {}
	slot0.heroBtn_ = {}
	slot0.campCon_ = {}

	for slot4 = 1, 3 do
		slot0.heroGo_[slot4] = slot0["heroGo_" .. slot4]
		slot0.heroImg_[slot4] = slot0["heroImg_" .. slot4]
		slot0.heroBtn_[slot4] = slot0["heroBtn_" .. slot4]
		slot0.campCon_[slot4] = ControllerUtil.GetController(slot0.heroBtn_[slot4].transform, "name")
	end

	slot0.curCon_ = ControllerUtil.GetController(slot0.transform_, "cur")
	slot0.btnCon_ = ControllerUtil.GetController(slot0.transform_, "btn")
	slot0.nameCon_ = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.chipCon_ = ControllerUtil.GetController(slot0.transform_, "chip")
	slot0.comboSkillCon_ = ControllerUtil.GetController(slot0.transform_, "combo")
	slot0.inputHandler_ = handler(slot0, slot0.OnInput)
	slot0.inputCancelHandler_ = handler(slot0, slot0.OnInputCancel)

	manager.notify:RegistListener(INPUT_POP_CLICK_OK, slot0.inputHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CLOSE, slot0.inputCancelHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CANCEL, slot0.inputCancelHandler_)

	slot0.handler_ = handler(slot0, slot0.OnComboSkillSelect)

	manager.notify:RegistListener(COMBO_SKILL_SELECT, slot0.handler_)
end

function slot0.AddUIListeners(slot0)
	for slot4, slot5 in ipairs(slot0.heroBtn_) do
		slot0:AddBtnListener(slot5, nil, function ()
			JumpTools.OpenPageByJump("/heroTeam", {
				index = uv0.info_.index,
				pos = uv1,
				hero_list = uv0.info_.hero_list,
				combo = uv0.info_.comboSkill
			})
		end)
	end

	slot0:AddBtnListener(slot0.saveBtn_, nil, function ()
		if uv0.info_.hero_list[1] == 0 then
			for slot3, slot4 in ipairs(uv0.info_.hero_list) do
				if slot4 ~= 0 then
					ShowTips("CAPTAIN_ROLE_MISSING")

					return
				end
			end

			ShowTips("TEAM_SET_NEEDED")
		elseif BattleTeamData:IsInList(uv0.info_.index, uv0.info_) then
			ShowTips("SAME_TEAM_PROHIBITED")
		elseif uv0.info_.name ~= "" then
			BattleFieldAction.SaveReservesTeam(uv0.info_.index, uv0.info_.name, uv0.info_.hero_list, uv0.info_.comboSkill, uv0.info_.chipInfo, "FORMATION_PLAN_SAVED")
		else
			uv0.saveFlag_ = true

			JumpTools.OpenPageByJump("ProposalPopup")
		end
	end)
	slot0:AddBtnListener(slot0.renameBtn_, nil, function ()
		uv0.inputPopFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		if uv0.changeFunc_ then
			uv0.changeFunc_(uv0.info_.index)
		end
	end)
	slot0:AddBtnListener(slot0.delBtn_, nil, function ()
		ShowMessageBox({
			content = string.format(GetTips("FORMATION_PLAN_DELETE_CONFIRM"), uv0.info_.name),
			OkCallback = function ()
				BattleFieldAction.DelectReservesTeam(uv0.info_.index)
			end
		})
	end)
	slot0:AddBtnListener(slot0.chipBtn_, nil, function ()
		JumpTools.GoToSystem("/reservesChipManager", {
			index = uv0.info_.index
		}, ViewConst.SYSTEM_ID.CHIP_MANAGER)
	end)
	slot0:AddBtnListener(slot0.comboBtn_, nil, function ()
		for slot4, slot5 in ipairs(uv0.info_.hero_list) do
			if slot5 and slot5 ~= 0 then
				JumpTools.OpenPageByJump("reservesComboSkillSelect", {
					heroList = uv0.info_.hero_list,
					comboSkillID = uv0.info_.comboSkill,
					index = uv0.info_.index
				})

				return
			end
		end

		ShowTips("SKILL_WITHOUT_MEMBER")
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3, slot4)
	slot0.info_ = slot1
	slot0.indexText_.text = slot1.index

	if slot3 and slot0.info_.hero_list[1] ~= 0 then
		if slot2 then
			slot0.btnCon_:SetSelectedState("cur")
		else
			slot0.btnCon_:SetSelectedState("change")
		end

		slot0.curCon_:SetSelectedState("false")
		SetActive(slot0.btnPanel_, true)
	else
		slot5 = true

		for slot9, slot10 in ipairs(slot0.info_.hero_list) do
			if slot10 ~= 0 then
				slot5 = false

				break
			end
		end

		if slot5 and slot0.info_.chipInfo.id == 0 then
			SetActive(slot0.btnPanel_, false)
		else
			slot0.btnCon_:SetSelectedState("save")
			SetActive(slot0.btnPanel_, true)
		end

		slot0.curCon_:SetSelectedState(slot2 and slot4 and "true" or "false")
	end

	if slot0.info_.name ~= "" then
		slot0.title_.text = slot0.info_.name

		slot0.nameCon_:SetSelectedState("true")
	else
		if slot2 then
			slot0.curTitle_.text = GetTips("CURRENT_SCHEME")
		else
			slot0.curTitle_.text = GetTips("NIL_NAME")
		end

		slot0.nameCon_:SetSelectedState("false")
	end

	for slot9, slot10 in ipairs(slot0.info_.hero_list) do
		if slot10 ~= 0 then
			slot0.heroImg_[slot9].sprite = ItemTools.getItemSprite(HeroTools.HeroUsingSkinInfo(slot10).id)

			SetActive(slot0.heroGo_[slot9], true)
			slot0.campCon_[slot9]:SetSelectedState(HeroCfg[slot10].race)
		else
			SetActive(slot0.heroGo_[slot9], false)
		end
	end

	slot0:RefreshChip()
	slot0:RefreshComSkill()
end

function slot0.RefreshChip(slot0)
	if slot0.info_.chipInfo.id == 0 then
		slot0.chipCon_:SetSelectedState(-1)
	else
		slot0.chipIcon_.sprite = getSpriteViaConfig("ChipIcon", ChipCfg[slot1].picture_id)

		slot0.chipCon_:SetSelectedState(#slot0.info_.chipInfo.list)
	end
end

function slot0.RefreshComSkill(slot0)
	if slot0.info_.comboSkill == 0 then
		slot0.comboSkillCon_:SetSelectedState(0)
	else
		slot2 = ComboSkillCfg[slot1]
		slot0.comboImg_.sprite = getSpriteViaConfig("ComboSkill", slot2.skill_id)

		if #slot2.cooperate_role_ids == 3 then
			slot0.comboSkillCon_:SetSelectedState("all")
		else
			slot3 = {}
			slot4 = slot0.info_.hero_list

			for slot8, slot9 in ipairs(slot2.cooperate_role_ids) do
				table.insert(slot3, table.indexof(slot4, slot9))
			end

			if not slot3[1] or not slot3[2] then
				return
			end

			if slot3[1] < slot3[2] then
				slot0.comboSkillCon_:SetSelectedState(slot3[1] .. "_" .. slot3[2])
			else
				slot0.comboSkillCon_:SetSelectedState(slot3[2] .. "_" .. slot3[1])
			end
		end
	end
end

function slot0.OnInput(slot0, slot1, slot2)
	if not slot0.inputPopFlag_ and not slot0.saveFlag_ then
		return
	end

	if not slot0.gameObject_.activeInHierarchy then
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

			if uv2.saveFlag_ then
				BattleFieldAction.SaveReservesTeam(uv2.info_.index, uv3, uv2.info_.hero_list, uv2.info_.comboSkill, uv2.info_.chipInfo, "FORMATION_PLAN_SAVED")
			else
				BattleFieldAction.SaveReservesTeam(uv2.info_.index, uv3, uv2.info_.hero_list, uv2.info_.comboSkill, uv2.info_.chipInfo, "FORMATION_PLAN_NAME_CHANGED")
			end

			uv2.inputPopFlag_ = false
			uv2.saveFlag_ = false

			manager.notify:Invoke(INPUT_POP_BACK)
		end
	end)
end

function slot0.RegistChangeBtn(slot0, slot1)
	slot0.changeFunc_ = slot1
end

function slot0.OnInputCancel(slot0)
	slot0.inputPopFlag_ = false
	slot0.saveFlag_ = false
end

function slot0.OnComboSkillSelect(slot0)
	slot0.curCon_:SetSelectedState("false")
	slot0:RefreshComSkill()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.inputPopFlag_ = false
	slot0.saveFlag_ = false

	manager.notify:RemoveListener(INPUT_POP_CLICK_OK, slot0.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CLOSE, slot0.inputCancelHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CANCEL, slot0.inputCancelHandler_)
	manager.notify:RemoveListener(COMBO_SKILL_SELECT, slot0.handler_)

	slot0.inputHandler_ = nil
	slot0.inputCancelHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
