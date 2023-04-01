slot0 = class("PassportBuyLevelItemView", ReduxView)

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

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, CommonItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.rewards_[slot1][1],
		number = slot0.rewards_[slot1][2]
	})
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.SetIndex(slot0, slot1)
	slot0.index_ = slot1

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot2 = PassportData:GetLevel() + slot0.index_
	slot8 = "BATTLEPASS_LEVEL_UNLOCK_REWARD"
	slot0.levelLabel_.text = string.format(GetTips(slot8), slot2)
	slot0.rewards_ = {}

	for slot8, slot9 in ipairs(BattlePassCfg[BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type][slot2]].reward_free) do
		table.insert(slot0.rewards_, slot9)
	end

	if PassportData:GetPayLevel() > 0 then
		for slot8, slot9 in ipairs(BattlePassCfg[slot4].reward_pay) do
			table.insert(slot0.rewards_, slot9)
		end
	end

	slot0.rewards_ = mergeReward(slot0.rewards_)

	slot0.list_:StartScroll(#slot0.rewards_)
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
