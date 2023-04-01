slot0 = class("PolyhedronCampAddPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PolyhedronBattle/PolyhedronCampAddPopUI"
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

function slot0.OnEnter(slot0)
	slot0.heroList = slot0.params_.heroIdList
	slot1, slot2, slot3 = PolyhedronTools.GetRaceEffect(slot0.heroList)

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

return slot0
