slot0 = class("MardukSpecialRewardConditionItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:AddEventListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, FactorySoloChallengeRewardCommonItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.cfg_.reward_item_list[slot1], POP_ITEM)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		ActivityAction.GetBonus({
			uv0.rewardId_
		})
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(MARDUK_SPECIAL_REWARD_UPDATE, function (slot0)
		if table.indexof(slot0, uv0.rewardId_) then
			uv0:UpdateView()
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.activityId_ = slot3
	slot0.index_ = slot1
	slot0.rewardId_ = slot2
	slot0.cfg_ = ActivityPointRewardCfg[slot2]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.conditionLabel_.text = string.format(GetTips("FACTORY_ACTIVITY_POINT_REWARD"), slot0.cfg_.need)

	slot0.uiList_:StartScroll(#slot0.cfg_.reward_item_list)

	slot1 = MardukSpecialData:GetPoint(slot0.activityId_)

	if MardukSpecialData:HaveGotReward(slot0.activityId_, slot0.rewardId_) then
		slot0.statusController_:SetSelectedState("haveGet")
	elseif slot0.cfg_.need <= slot1 then
		slot0.statusController_:SetSelectedState("canGet")
	else
		slot0.statusController_:SetSelectedState("unFinish")
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	slot0.data_ = nil

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
