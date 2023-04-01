slot0 = class("SkinTrialMainView_2_0", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:UIName()), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.activityID_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListener()

	slot0.scrollList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, slot0:GetItemClass())
	slot0.outOfDataHandler_ = handler(slot0, slot0.OnOutOfData)
end

function slot0.UIName(slot0)
	return SkinTrialTools.GetMainViewUIName(slot0.activiteID_)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SKIN_TRIAL_DESCRIPE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_HERO_TRIAL_DESCRIPE")
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:StopTimer()

	slot0.outOfDataHandler_ = nil

	slot0.scrollList_:Dispose()

	slot0.scrollList_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.RefreshUI(slot0)
	slot0.skinTrialIDList_ = slot0:GetskinTrialIDList()

	slot0:RefreshSkinItem()
end

function slot0.GetskinTrialIDList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(ActivityData:GetActivityData(slot0.activityID_).subActivityIdList) do
		if ActivityData:GetActivityIsOpen(slot7) then
			for slot12, slot13 in ipairs(ActivitySkinTrialCfg.get_id_list_by_activity_id[slot7]) do
				table.insert(slot1, slot13)
			end
		end
	end

	return slot1
end

function slot0.RefreshSkinItem(slot0)
	slot0.scrollList_:StartScroll(#slot0.skinTrialIDList_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetSkinTrialID(slot0.skinTrialIDList_[slot1])
	slot2:SetOutOfDataHandler(slot0.outOfDataHandler_)
end

function slot0.GetItemClass(slot0)
	return SkinTrialSelectItem_2_0
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		return
	end

	slot3 = slot0.scrollList_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:RefreshTime()
	end

	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			return
		end

		slot2 = uv0.scrollList_
		slot4 = slot2

		for slot3, slot4 in ipairs(slot2.GetItemList(slot4)) do
			slot4:RefreshTime()
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 == true then
		slot0:AddTimer()
		slot0:RefreshUI()
	else
		slot0:StopTimer()
	end
end

function slot0.OnOutOfData(slot0)
	slot0:RefreshUI()
	slot0:AddTimer()
end

return slot0
