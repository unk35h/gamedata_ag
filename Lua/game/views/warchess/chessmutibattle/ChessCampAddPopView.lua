slot0 = class("ChessCampAddPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/WarChess/WarChessGodUpUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()
	end)

	slot0.heroController_ = ControllerUtil.GetController(slot0.heroGo_.transform, "name")
	slot0.fightController_ = ControllerUtil.GetController(slot0.fightingGo_.transform, "name")
end

function slot0.GetRaceEffect(slot0)
	slot1 = {}
	slot2 = 0
	slot3 = false
	slot8, slot9 = nil

	for slot8, slot9 in pairs(BattleTeamData:GetSingleTeam(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS, slot8, slot9, slot0.teamID_)) do
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

function slot0.RefreshRace(slot0)
	slot1, slot2, slot3 = slot0:GetRaceEffect()

	slot0.heroController_:SetSelectedState(slot1 ~= 0 and "on" or "off")
	slot0.fightController_:SetSelectedState(slot2 and "on" or "off")

	if slot1 ~= 0 then
		slot0.text1Text_.text = RaceEffectCfg[slot1].desc
	else
		slot0.text1Text_.text = GetTips("NO_CORRECTOR_BUFF")
	end

	if slot2 then
		slot0.text2Text_.text = RaceEffectCfg[slot1].battle_desc
	else
		slot0.text2Text_.text = GetTips("NO_BATTLE_BUFF")
	end
end

function slot0.OnEnter(slot0)
	slot0.teamID_ = slot0.params_.teamID

	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	slot0:RefreshRace()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
