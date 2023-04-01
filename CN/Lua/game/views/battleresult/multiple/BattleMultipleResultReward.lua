slot0 = class("BattleMultipleResultReward", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObejct_ = slot1
	slot0.transform_ = slot0.gameObejct_.transform

	slot0:BindCfgUI(slot0.gameObejct_)

	slot0.rewardUIList_ = LuaList.New(handler(slot0, slot0.RefreshRenderer), slot0.uiList_, CommonItem)
end

function slot0.Dispose(slot0)
	if slot0.rewardUIList_ then
		slot0.rewardUIList_:Dispose()

		slot0.rewardUIList_ = nil
	end

	uv0.super.Dispose(slot0)

	slot0.gameObejct_ = nil
end

function slot0.SetRewardList(slot0, slot1, slot2)
	if slot0.index_ ~= slot1 then
		slot0.index_ = slot1
		slot0.rewardList_ = slot2

		slot0:RefreshUI()
	end
end

function slot0.RefreshUI(slot0)
	slot0.indexText_.text = slot0.index_
	slot1 = {}

	for slot5, slot6 in pairs(slot0.rewardList_) do
		table.insert(slot1, slot6)
	end

	slot1 = sortReward(mergeReward(slot1))
	slot0.rewardList_ = slot1

	slot0.rewardUIList_:StartScroll(#slot1, 1)
end

function slot0.RefreshRenderer(slot0, slot1, slot2)
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_OTHER_ITEM, {
			slot0.id,
			slot0.number
		})
	end)

	if ItemCfg[formatReward(slot0.rewardList_[slot1]).id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[slot3.id].type then
		slot3.race = EquipCfg[slot3.id] and EquipCfg[slot3.id].race
	end

	slot2:RefreshData(slot3)
end

return slot0
