slot0 = class("BossStarExchangeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BossChallenge/BossStarExchangeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.itemList_ = {}
	slot0.refreshHandler_ = handler(slot0, slot0.RefreshItem)
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, slot0.refreshHandler_)
	slot0:RefreshItem()
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, slot0.refreshHandler_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RefreshItem(slot0)
	slot2 = StageTools.CalcBossChallengeStar()
	slot3 = BattleBossChallengeNormalData:GetReceiveStarList()
	slot4 = {}
	slot5 = {}

	for slot9 = 1, #BattleBossChallengeNormalData:GetBossChallengeCfg().reward do
		if table.keyof(slot3, slot1.reward[slot9][1]) then
			table.insert(slot4, slot9)
		else
			table.insert(slot5, slot9)
		end
	end

	slot9 = slot4

	table.insertto(slot5, slot9)

	for slot9, slot10 in pairs(slot5) do
		if slot0.itemList_[slot9] == nil then
			slot0.itemList_[slot9] = BossStarExchangeItem.New(slot0.goItem_, slot0.goParent_, slot10)
		end

		slot0.itemList_[slot9]:SetData(slot1.reward[slot10], slot2, slot10, slot9 == #slot5)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.refreshHandler_ = nil

	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil
end

return slot0
