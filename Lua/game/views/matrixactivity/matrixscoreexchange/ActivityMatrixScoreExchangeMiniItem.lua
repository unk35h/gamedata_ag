slot0 = class("ActivityMatrixScoreExchangeItem", ReduxView)

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

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.lockController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "lock")
	slot0.itemList = LuaList.New(handler(slot0, slot0.indexItem), slot0.bonusListGo_, CommonItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.rewardId = slot1
	slot0.matrix_activity_id = slot2
	slot3 = ActivityPointRewardCfg[slot1]
	slot0.scoreText_.text = string.format("%d", slot3.need)
	slot0.items = slot3.reward_item_list

	slot0.itemList:StartScroll(#slot0.items)
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = ActivityMatrixData:GetMatrixScore(slot0.matrix_activity_id)
	slot2 = ActivityPointRewardCfg[slot0.rewardId]

	if ActivityMatrixData:GetMatrixPointRewardState(slot0.matrix_activity_id, slot0.rewardId) then
		slot0.statusController_:SetSelectedState("haveGet")
	elseif slot2.need <= slot1 then
		slot0.statusController_:SetSelectedState("canGet")
	else
		slot0.statusController_:SetSelectedState("cannotGet")
	end

	slot0.lockController_:SetSelectedIndex(0)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.items[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
