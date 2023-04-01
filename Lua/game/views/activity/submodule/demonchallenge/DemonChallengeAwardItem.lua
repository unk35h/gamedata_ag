slot0 = class("DemonChallengeAwardItem", ReduxView)
slot1 = import("game.tools.JumpTools")

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.itemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.itemListGo_, CommonItem)
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
end

function slot0.RefreshData(slot0, slot1)
	slot0.itemInfo_ = slot1

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		SubDemonChallengeAction.GetChallengeReward(uv0.itemInfo_.id, uv0.itemInfo_.activityId)
	end)
end

function slot0.RefreshUI(slot0)
	slot0.levelIndex_ = table.indexof(DemonChallengeCfg.get_id_list_by_activity_id[slot0.itemInfo_.activityId], slot0.itemInfo_.id)
	slot2 = ""
	slot0.Desctext_.text = (slot0.levelIndex_ ~= 1 or GetTips("CLEAR_NORMAL_DIFFICULTY")) and (slot0.levelIndex_ ~= 2 or GetTips("CLEAR_DIFFICULTY")) and GetTips("CLEAR_EXTREME_DIFFICULTY")

	slot0:RefreshState()
	slot0:RefreshItem()
end

function slot0.RefreshState(slot0)
	slot1 = SubDemonChallengeData:GetChallengeInfo(slot0.itemInfo_.activityId).challengeInfo
	slot3 = slot1[slot0.levelIndex_].reward_state
	slot4 = nil

	if slot1[slot0.levelIndex_].challenge_state == ActivityConst.DEMON_CHALLENGE_STATE.UNFINISHED then
		slot4 = 0
	elseif slot3 == ActivityConst.DEMON_CHALLENGE_REWARD_STATE.UNRECEIVE then
		slot4 = 1
	elseif slot3 == ActivityConst.DEMON_CHALLENGE_REWARD_STATE.RECEIVED then
		slot4 = 2
	end

	slot0.controller_:SetSelectedState(tostring(slot4))
end

function slot0.RefreshItem(slot0)
	slot0.rewardCfg_ = getRewardFromDropCfg(BattleHeartDemonStageCfg[DemonChallengeCfg[slot0.itemInfo_.id].stage_id].drop_lib_id, true)

	slot0.itemList_:StartScroll(#slot0.rewardCfg_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewardCfg_[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
	slot2:Show(true)
end

function slot0.GetItemInfo(slot0)
	return slot0.itemInfo_
end

function slot0.Dispose(slot0)
	if slot0.itemList_ then
		slot0.itemList_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
