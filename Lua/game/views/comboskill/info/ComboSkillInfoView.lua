slot0 = class("ComboSkillInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroSkill/SkillMeaningUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.comboSkillUIList_ = LuaList.New(handler(slot0, slot0.RefreshComboSkillItem), slot0.uiList_, ComboSkillItem)
end

function slot0.AddListeners(slot0)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.comboSkillList_ = ComboSkillTools.GetHeroComboSkill(slot0.params_.heroID)

	slot0.comboSkillUIList_:StartScroll(#slot0.comboSkillList_, 1)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
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
