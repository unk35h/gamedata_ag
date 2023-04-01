slot0 = class("HeroArchiveStoryItem", ReduxView)

function slot1(slot0)
	return math.ceil(slot0 / math.round(HeroConst.HERO_LOVE_LV_MAX / 5))
end

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")
	slot0.colorController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "colorChange")
end

function slot0.RefreshLoveCircle(slot0, slot1)
	slot1 = slot1 or ArchiveData:GetArchive(slot0.archiveID_).lv

	slot0.colorController_:SetSelectedIndex(uv0(slot1) - 1)

	slot0.lovelevelText_.text = slot1
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.archiveID_ = slot2
	slot0.ID_ = slot1
	slot0.storyLinId_ = HeroRecordCfg[slot2].plot_id[slot1]
	slot3 = GameSetting.hero_plot_unlock_condition.value[slot1]
	slot4 = ConditionCfg[slot3]
	slot5, slot6, slot7 = IsConditionAchieved(slot3, {
		heroId = slot0.archiveID_
	})

	slot0:RefreshLoveCircle(ConditionCfg[slot3].params[1])

	if slot5 then
		slot0.controller_:SetSelectedState("unLock")
	else
		slot0.controller_:SetSelectedState("lock")
	end

	slot0.titleText_.text = HeroRecordCfg[slot2].plot_title[slot1]

	manager.redPoint:SetRedPointIndependent(slot0.playbtnBtn_.transform, not ArchiveData:IsStoryRead(slot0.archiveID_, slot0.storyLinId_) and slot5)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.playbtnBtn_, nil, function ()
		slot0 = manager.redPoint

		slot0:SetRedPointIndependent(uv0.playbtnBtn_.transform, false)

		slot0 = manager.story

		slot0:StartStoryById(uv0.storyLinId_, function (slot0)
			HeroAction.ReadStory(uv0.archiveID_, uv0.storyLinId_)
		end)
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
