slot0 = class("VolumeMusicRewardItem", ReduxView)

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

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, CommonItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		MusicAction.QueryReward(uv0.id)
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.id = slot1
	slot0.items = ActivityMusicCfg[slot1].reward

	slot0.list_:StartScroll(#slot0.items)

	slot0.m_des.text = slot0:GeDes(slot1)

	slot0.stateController_:SetSelectedIndex(MusicData:GetRewardState(slot1))
end

function slot0.GeDes(slot0, slot1)
	slot2 = ActivityMusicCfg[slot1]
	slot4 = MusicData:GetTargetAccuracyDes(slot2.target)

	if slot2.difficult == 1 then
		return string.format(GetTips("ACTIVITY_MUSIC_EASY_TASK"), slot4)
	else
		return string.format(GetTips("ACTIVITY_MUSIC_DIFFICULT_TASK"), slot4)
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.items[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
