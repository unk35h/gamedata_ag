slot0 = class("ComboSkillSelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroSkill/MeaningUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.comboSkillUIList_ = LuaList.New(handler(slot0, slot0.RefreshItemSelect), slot0.uiList_, slot0:GetComboSkillItemView())
end

function slot0.GetComboSkillItemView(slot0)
	return ComboSkillSelectItem
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)

	slot1 = slot0.eventTriggerListener_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if slot0 == slot1.pointerEnter and not slot1.dragging then
			uv0:Back()
		end
	end))
end

function slot0.RemoveListeners(slot0)
	slot0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
end

function slot0.OnEnter(slot0)
	slot0.heroList_ = slot0.params_.heroList
	slot0.trialHeroList_ = slot0.params_.trailList
	slot0.stageType_ = slot0.params_.stageType
	slot0.stageID_ = slot0.params_.stageID
	slot0.activityID_ = slot0.params_.activityID
	slot0.cont_id_ = slot0.params_.cont_id
	slot0.team_id_ = slot0.params_.team_id
	slot0.comboSkillID_ = slot0.params_.comboSkillID
	slot0.comboSkillIDList_ = slot0:GetComboSkillList()

	slot0.comboSkillUIList_:StartScroll(#slot0.comboSkillIDList_, 1)
end

function slot0.GetComboSkillList(slot0)
	return ComboSkillTools.GetComboSkillList(slot0.heroList_, true)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:RemoveListeners()
	slot0.comboSkillUIList_:Dispose()

	slot0.comboSkillUIList_ = nil
end

function slot0.RefreshItemSelect(slot0, slot1, slot2)
	slot3 = slot0.comboSkillIDList_[slot1]

	slot2:RefreshUI(slot0.stageType_, slot0.stageID_, slot0.activityID_, slot3, slot0.comboSkillID_ == slot3, slot0.heroList_, slot0.cont_id_, slot0.team_id_)
end

return slot0
