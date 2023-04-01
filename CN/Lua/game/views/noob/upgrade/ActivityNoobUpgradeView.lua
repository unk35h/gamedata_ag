slot0 = class("ActivityNoobUpgradeView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot6 = slot1.transform
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Activity/NewbieUpgradeUI_new"), slot6)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.upgradeItemList_ = {}

	for slot6 = 1, #GameSetting.levelup_reward.value do
		slot0.upgradeItemList_[slot6] = ActivityNoobUpgradeItem.New(slot0[string.format("button%s_", slot6)], slot6)
	end

	slot3 = GameSetting.levelup_reward.value
	slot0.rewardHeroItem_ = RewardPoolItem.New(slot0.goHeroReward_, slot3[1][2], true)

	slot0.rewardHeroItem_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	slot0.rewardHeroItem_:HideNum()

	slot0.rewardServantItem_ = RewardPoolItem.New(slot0.goServantReward_, slot3[#slot3][2], true)

	slot0.rewardServantItem_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	slot0.rewardServantItem_:HideServantTxt()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.rewardHeroItem_:Dispose()
	slot0.rewardServantItem_:Dispose()

	for slot4, slot5 in pairs(slot0.upgradeItemList_) do
		slot5:Dispose()
	end

	slot0.upgradeItemList_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.SetData(slot0)
	slot2 = PlayerData
	slot4 = slot2
	slot0.textLevel_.text = slot2.GetPlayerInfo(slot4).userLevel

	for slot4, slot5 in pairs(slot0.upgradeItemList_) do
		slot5:RefreshUI()
	end
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
