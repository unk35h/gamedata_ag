slot0 = class("TowerGameSectionInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/ChapterSectionInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	SetActive(slot0.rewardPanel_, false)
	SetActive(slot0.multiplePanel_, false)
	SetActive(slot0.resourcePanel_, false)
	SetActive(slot0.stageTitleGo_, false)

	slot0.levelid_ = 0
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		if ActivityData:GetActivityIsOpen(uv0.levelid_) then
			BattleController.GetInstance():LaunchBattle(BattleMardukeTowerGameTemplate.New(uv0.stageid_, uv0.levelid_))
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
end

function slot0.OnEnter(slot0)
	if slot0.levelid_ ~= slot0.params_.levelid then
		slot0.levelid_ = slot0.params_.levelid
		slot0.stageid_ = TowerGameCfg[slot0.levelid_].stage_id

		slot0:RefreshUI()
	end
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		manager.notify:CallUpdateFunc(TOWERGAME_BACK)
		JumpTools.Back()
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = BattleTowerGameCfg[slot0.stageid_]
	slot0.sectionName_.text = slot1.name
	slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
	slot0.tipsText_.text = slot1.tips

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.tipsTextContentTrans_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

return slot0
