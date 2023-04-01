slot0 = class("ActivityInfinityPoolBaseItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.poolID_ = slot1
	slot0.index_ = slot2

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if OsirisInfinityPoolData:GetPoolData(slot0.poolID_).openBoxList[slot0.index_] then
		slot5 = slot3.openBoxList[slot2]

		if slot0.rewardItem_ then
			slot0.rewardItem_:SetData(slot5)
		else
			slot0.rewardItem_ = slot0:GetRewardItem(slot5)
		end
	elseif slot0.rewardItem_ then
		slot0.rewardItem_:Show(false)
	end

	slot0:Show(true)
end

function slot0.GetRewardItem(slot0, slot1)
	return RewardPoolItem.New(slot0.goItemParent_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.rewardItem_ then
		slot0.rewardItem_:Dispose()

		slot0.rewardItem_ = nil
	end

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if OsirisInfinityPoolData:GetPoolData(uv0.poolID_).openBoxList[uv0.index_] then
			return
		end

		slot1 = ActivityInfinityPoolCfg[uv0.poolID_].cost_item

		if MaterialData:GetMaterial(slot1[1]).num < slot1[2] then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemCfg[slot1[1]].name))

			return
		end

		slot3 = slot0.isOpenCoreItem

		OsirisAction.OpenPoolBox(uv0.poolID_, uv0.index_, function (slot0)
			if isSuccess(slot0.result) then
				uv0:RefreshUI()
				MaterialAction.MaterialModify(uv1[1], uv1[2] * -1)
				getReward({
					{
						slot0.box.item.id,
						slot0.box.item.num
					}
				})

				if uv2 == false and uv3.isOpenCoreItem == true then
					slot1 = ActivityInfinityPoolCfg[uv0.poolID_].activity_id

					ShowTips(string.format(GetTips("UNLOCK_INFINITY"), OsirisInfinityPoolData:GetOpenPhase(slot1), ActivityCfg[slot1].name))
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
