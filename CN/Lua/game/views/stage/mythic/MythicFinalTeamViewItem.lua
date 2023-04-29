slot0 = class("MythicFinalTeamViewItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.teamSwapController_ = ControllerUtil.GetController(slot0.transform_, "place")
	slot0.teamChangeController_ = ControllerUtil.GetController(slot0.transform_, "change")
	slot0.chipController_ = ControllerUtil.GetController(slot0.chipbtnBtn_.transform, "name")
	slot0.godUpController_ = ControllerUtil.GetController(slot0.godupBtn_.transform, "name")
	slot4 = "name"
	slot0.aoyiController_ = ControllerUtil.GetController(slot0.aoyiBtn_.transform, slot4)
	slot0.heroHead_ = {}
	slot0.heroHeadCon_ = {}

	for slot4 = 1, 3 do
		slot0.heroHead_[slot4] = NewHeroHead.New(slot0["newherohead" .. slot4 .. "Btn_"].gameObject)

		slot0.heroHead_[slot4]:SetRedPointEnable(false)

		slot0.heroHeadCon_[slot4] = ControllerUtil.GetController(slot0["newherohead" .. slot4 .. "Btn_"].transform, "switch")
	end
end

function slot0.AddListeners(slot0)
	slot4 = slot0.chipbtnBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		if not MythicData:GetIsBattleIng() then
			JumpTools.GoToSystem("/mythicChipManagerView", {
				chessTeamID = uv0.teamID_
			}, ViewConst.SYSTEM_ID.CHIP_MANAGER)
		end
	end)

	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["newherohead" .. slot4 .. "Btn_"], nil, function ()
			if not MythicData:GetIsBattleIng() then
				uv0:Go("/mythicHeroTeamInfoView", {
					isEnter = false,
					selectHeroPos = uv1,
					stageID = uv0.stageID_,
					stageType = uv0.stageType_,
					teamID = uv0.teamID_,
					teamLength = uv0.teamLength_
				})
			end
		end)
	end

	slot0:AddBtnListener(slot0.godupBtn_, nil, function ()
		JumpTools.OpenPageByJump("mythicCampAddPopView", {
			teamID = uv0.teamID_
		})
	end)
	slot0:AddBtnListener(slot0.aoyiBtn_, nil, function ()
		JumpTools.OpenPageByJump("mythicComboSkillSelectView", {
			stageType = uv0.stageType_,
			stageID = uv0.stageID_,
			heroList = BattleTeamData:GetSingleTeam(uv0.stageType_, nil, , uv0.teamID_),
			trialList = {},
			comboSkillID = BattleTeamData:GetComboInfo(uv0.stageType_, nil, , uv0.teamID_),
			teamID = uv0.teamID_
		})
	end)
	slot0:AddBtnListener(slot0.changebtn_, nil, function ()
		if not MythicData:GetIsBattleIng() and uv0.changefunc_ then
			uv0.changefunc_(uv0.teamID_)
		end
	end)
	slot0:AddBtnListener(slot0.confirmbtn_, nil, function ()
		if not MythicData:GetIsBattleIng() and uv0.confirmfunc_ then
			uv0.confirmfunc_(uv0.teamID_)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.teamLength_ = slot3
	slot0.teamID_ = slot1
	slot0.stageID_ = slot2
	slot0.stageType_ = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
	slot4 = BattleTeamData:GetSingleTeam(slot0.stageType_, nil, , slot1)
	slot5, slot6 = BattleTeamData:GetMimirInfo(slot0.stageType_, nil, , slot1)
	slot7 = BattleTeamData:GetComboInfo(slot0.stageType_, nil, slot12, slot1)
	slot8 = slot0:GetRaceEffect()

	for slot12 = 1, 3 do
		if slot4[slot12] and slot4[slot12] ~= 0 then
			slot0.heroHead_[slot12]:SetHeroId(slot4[slot12])
			slot0.heroHeadCon_[slot12]:SetSelectedState("1")
		else
			slot0.heroHeadCon_[slot12]:SetSelectedState("0")
		end
	end

	if slot5 == 0 then
		slot0.chipController_:SetSelectedState("false")
		SetActive(slot0.subchip1Img_.gameObject, false)
		SetActive(slot0.subchip2Img_.gameObject, false)
	else
		slot0.chipController_:SetSelectedState("true")

		slot14 = "ChipIcon"
		slot0.chipiconImg_.sprite = getSpriteViaConfig(slot14, ChipCfg[slot9].picture_id)

		for slot14 = 1, 2 do
			if slot6[slot14] then
				SetActive(slot0["subchip" .. slot14 .. "Img_"].gameObject, true)

				slot0["subchip" .. slot14 .. "Img_"].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[slot6[slot14]].picture_id)
			else
				SetActive(slot0["subchip" .. slot14 .. "Img_"].gameObject, false)
			end
		end
	end

	slot0.godUpController_:SetSelectedState(slot8 == 0 and "off" or "on")
	slot0.aoyiController_:SetSelectedState(slot7 == 0 and "off" or "on")

	slot0.bianduiText_.text = GetTips("TEAM_" .. slot1)

	if MythicData:GetIsBattleIng() then
		slot0.teamChangeController_:SetSelectedState("false")
	else
		slot0.teamChangeController_:SetSelectedState("true")
	end
end

function slot0.GetRaceEffect(slot0)
	slot1 = {}
	slot2 = 0
	slot3 = false
	slot8, slot9 = nil

	for slot8, slot9 in pairs(BattleTeamData:GetSingleTeam(slot0.stageType_, slot8, slot9, slot0.teamID_)) do
		if slot9 ~= 0 then
			slot1[slot10] = (slot1[HeroCfg[slot9].race] or 0) + 1

			if slot1[slot10] == 2 then
				slot2 = slot10
			elseif slot1[slot10] == 3 then
				slot3 = true
			end
		end
	end

	return slot2, slot3, slot1[slot2] or 1
end

function slot0.OnChangeRefreshStatus(slot0, slot1)
	if slot1 == slot0.teamID_ then
		slot0.teamSwapController_:SetSelectedState("select")
	else
		slot0.teamSwapController_:SetSelectedState("change")
	end
end

function slot0.ResetState(slot0)
	slot0.teamSwapController_:SetSelectedState("off")
end

function slot0.RegionHandler(slot0, slot1, slot2)
	slot0.changefunc_ = slot1
	slot0.confirmfunc_ = slot2
end

function slot0.Dispose(slot0)
	for slot4 = 1, 3 do
		slot0.heroHead_[slot4]:Dispose()
	end

	slot0.changefunc_ = nil
	slot0.confirmfunc_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
