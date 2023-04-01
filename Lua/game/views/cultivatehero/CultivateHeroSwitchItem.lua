slot0 = class("CultivateHeroSwitchItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.clickHandler_ then
			uv0.clickHandler_(uv0.groupID_)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	if slot0.groupID_ == nil then
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, slot1, slot2))
	elseif slot0.groupID_ ~= slot2 then
		manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, slot1, slot0.groupID_))
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, slot1, slot2))
	end

	slot0.groupID_ = slot2
	slot0.activityID_ = slot1

	slot0:RefreshUI()
end

function slot0.SetClickCallBack(slot0, slot1)
	slot0.clickHandler_ = slot1
end

function slot0.Dispose(slot0)
	slot0.clickHandler_ = nil

	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, slot0.activityID_, slot0.groupID_))
	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshImage()
end

function slot0.RefreshImage(slot0)
	slot0.icon_.sprite = getSpriteViaConfig("HeroLittleIcon", CultivateHeroTaskCfg[CultivateHeroTaskCfg.get_id_list_by_group_id[slot0.groupID_][1]].hero)
end

function slot0.RefreshSelect(slot0, slot1)
	SetActive(slot0.selectGo_, slot0.groupID_ == slot1)
end

return slot0
