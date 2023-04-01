slot0 = class("MatrixComboSkillInfoView", ReduxView)

function slot0.UIBackCount(slot0)
	return 3
end

function slot0.UIName(slot0)
	return "UI/MatrixHero/MatrixComboSkillInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.comboSkillUIList_ = LuaList.New(handler(slot0, slot0.RefreshComboSkillItem), slot0.uiList_, MatrixComboSkillItem)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		JumpTools.OpenPageByJump("matrixOrigin/matrixMiniHero")
	end)
end

function slot0.OnEnter(slot0)
	slot0.comboSkillList_ = ComboSkillTools.GetHeroComboSkill(slot0.params_.heroId)

	slot0.comboSkillUIList_:StartScroll(#slot0.comboSkillList_, 1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.comboSkillUIList_ then
		slot0.comboSkillUIList_:Dispose()

		slot0.comboSkillUIList_ = nil
	end
end

function slot0.RefreshComboSkillItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.comboSkillList_[slot1])
end

return slot0
