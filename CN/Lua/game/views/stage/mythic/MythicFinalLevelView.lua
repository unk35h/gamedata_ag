slot0 = class("MythicFinalLevelView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Mythic/MythicChooseDifficlutPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.controllertrans_, "statu")

	slot0:AddUIListeners()
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.nextbtn_, nil, function ()
		MythicData:SubLevel(1)
	end)
	slot0:AddBtnListener(slot0.exnextbtn_, nil, function ()
		MythicData:SetCurHotLevelIdMax()
	end)
	slot0:AddBtnListener(slot0.frontbtn_, nil, function ()
		MythicData:SubLevel(-1)
	end)
	slot0:AddBtnListener(slot0.exfrontbtn_, nil, function ()
		MythicAction:SelectLevel(1)
	end)
	slot0:AddBtnListener(slot0.battlebtn_, nil, function ()
		if #MythicData:GetCurLevelIdList() > 1 then
			gameContext:Go("/mythicFinalTeamView")
		else
			uv0:Go("/sectionSelectHeroMythicFinalView", {
				section = slot0[1],
				sectionType = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
			})
		end
	end)
	slot0:AddBtnListener(slot0.backbtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnMythicFinalHotItemClick(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.curleveltext_.text = MythicData:GetCurHotLevelId()
	slot0.leveltext_.text = string.format("<color=#FF9500>%s</color>/%s", MythicData:GetLevelMax(), #MythicFinalCfg.all)
	slot0.teamtext_.text = MythicFinalCfg[MythicData:GetCurHotLevelId()].team_num

	slot0.controller_:SetSelectedState(MythicData:GetevelStatu())
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
