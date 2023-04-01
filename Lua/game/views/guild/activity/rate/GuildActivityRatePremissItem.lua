slot0 = class("GuildActivityRatePremissItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.ID_ = slot1
	slot0.activityID_ = slot2
	slot3, slot0.curNum_, slot5 = GuildActivityTools.IsConditionAchieved(slot0.ID_)
	slot0.needNum_ = slot5
	slot0.currentText_.text = slot0.curNum_
	slot0.targetText_.text = string.format("/%d", slot5)

	SetActive(slot0.completeFlagGo_, slot3)

	slot0.descText_.text = ConditionCfg[slot0.ID_].desc
end

return slot0
