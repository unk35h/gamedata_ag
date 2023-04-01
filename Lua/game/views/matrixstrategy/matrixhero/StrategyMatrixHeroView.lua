slot0 = class("StrategyMatrixHeroView", MatrixMiniHeroView)

function slot0.UIBackCount(slot0)
	return 1
end

function slot0.UIName(slot0)
	return "UI/StrategyMatrix/StrategyMatrixMiniHeroUI"
end

function slot0.OnCtor(slot0)
	slot0.dirty_ = true
	slot0.curPageIndex_ = -1
	slot0.pageIndexS_ = {
		weapon = 3,
		astrolabe = 5,
		skill = 2,
		treasure = 6,
		property = 1,
		equip = 4
	}
	slot0.prefabList_ = {
		"UI/StrategyMatrix/StrategyMatrixHeroAttributeMiniUI",
		"UI/Hero/HeroSkillPage",
		"UI/StrategyMatrix/StrategyMatrixHeroWeaponUI",
		"UI/StrategyMatrix/StrategyMatrixHeroEquipUI",
		"UI/StrategyMatrix/StrategyMatrixHeroAstrolabePage",
		"UI/StrategyMatrix/StrategyMatrixTreasureMiniUI"
	}
	slot0.ClassList_ = {
		StrategyMatrixHeroAttributePage,
		StrategyMatrixHeroSkillPage,
		StrategyMartixHeroWeaponPage,
		StrategyMatrixHeroEquipPage,
		StrategyMatrixHeroAstrolabePage,
		StrategyMatrixTreasurePage
	}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.pages_ = {}
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot1 = slot0.heroAvatarView_

	slot1:SetShowInteractive(true)

	slot0.toggles_ = {
		slot0.toggle1_,
		slot0.toggle2_,
		slot0.toggle3_,
		slot0.toggle4_,
		slot0.toggle5_,
		slot0.toggle6_
	}
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in pairs(slot0.toggles_) do
		slot6 = slot5.onValueChanged

		slot6:AddListener(function (slot0)
			if slot0 then
				uv0:SwitchPage(uv1)

				if uv0.pages_[uv1] then
					uv0.pages_[uv1]:SetMatirxHeroInfo(uv0.matrix_activity_id, uv0.curHeroId_)
				end
			end
		end)
	end

	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(slot0.matrix_activity_id))
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, slot0.matrix_activity_id)
end

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	uv0.super.OnEnter(slot0)

	if slot0:GetMatrixPhaseData():GetPhase() == 3 then
		SetActive(slot0.m_rewardBtn.gameObject, true)
	else
		SetActive(slot0.m_rewardBtn.gameObject, false)
	end
end

function slot0.UpdateHeroView(slot0)
	slot0:UpdateAvatarView()

	for slot4, slot5 in pairs(slot0.pages_) do
		slot5:SetMatirxHeroInfo(slot0.matrix_activity_id, slot0.curHeroId_)
	end
end

function slot0.UpdateAvatarView(slot0)
	uv0.super.UpdateAvatarView(slot0)

	if slot0.curPageIndex_ == slot0.pageIndexS_.treasure then
		slot0.heroAvatarView_:ShowHeroModel(false)
	end
end

function slot0.GetHeroData(slot0, slot1)
	return StrategyMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

function slot0.GetHeroSkin(slot0, slot1)
	return StrategyMatrixData:GetHeroSkin(slot0.matrix_activity_id, slot1)
end

function slot0.GetMatrixPhaseData(slot0)
	return StrategyMatrixData:GetMatrixPhaseData(slot0.matrix_activity_id)
end

return slot0
