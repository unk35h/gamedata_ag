slot0 = class("DormPopularReplace", ReduxView)

function slot0.UIName(slot0)
	return "UI/HouseUI/HousetwoeventUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.item1 = PopularEventItem.New(slot0.commonitemGo_1)
	slot0.item2 = PopularEventItem.New(slot0.commonitemGo_2)
	slot0.item3 = PopularEventItem.New(slot0.commonitemGo_3)
	slot0.item4 = PopularEventItem.New(slot0.commonitemGo_4)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.surebtnBtn_, nil, function ()
		if DormData:GetCurPopularEvent().id ~= 0 then
			ShowMessageBox({
				content = string.format(GetTips("DORM_POPULAR_EVENT_OPEN"), ItemCfg[slot0].name, ItemCfg[slot0].name),
				OkCallback = function ()
					DormAction.SolveOverPopularEvent(uv0.popPopularItem_, uv0.itemList_[uv0.selectItem_].id, 2)
				end
			})
		else
			DormAction.SolveOverPopularEvent(uv0.popPopularItem_, uv0.itemList_[uv0.selectItem_].id, 2)
		end
	end)
	slot0:AddBtnListener(slot0.clearbtnBtn_, nil, function ()
		DormAction.SolveOverPopularEvent(uv0.popPopularItem_, uv0.itemList_[uv0.selectItem_].id, 1)
	end)
end

function slot0.OnSolveOverPopularEvent(slot0, slot1, slot2)
	if slot0.itemList_[slot0.selectItem_].id ~= slot0.popPopularItem_ then
		if slot2.oper == 1 then
			DormData:DeletePopularEvents(slot3)
			DormData:AddPopularEvent(slot0.popPopularItem_)
		elseif slot2.oper == 2 then
			DormData:DeletePopularEvents(slot3)
			DormData:SetCurPopularEvent({
				id = slot3,
				start = manager.time:GetServerTime()
			})
			DormData:AddPopularEvent(slot0.popPopularItem_)
		end
	elseif slot2.oper == 2 then
		DormData:SetCurPopularEvent({
			id = slot3,
			start = manager.time:GetServerTime()
		})
	end

	slot0:Back()
end

function slot0.RefreshPopularCountdown(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.countdownText_.text = TimeMgr:DescCDTime(DormData:GetCurPopularEvent().start + manager.time:GetHourInType(GameSetting.dorm_special_event_continue.value[1], 2) - manager.time:GetServerTime())
	slot0.timer_ = Timer.New(function ()
		slot0 = uv0 + uv1 - manager.time:GetServerTime()
		uv2.countdownText_.text = TimeMgr:DescCDTime(slot0)

		if slot0 <= 0 then
			uv2.timer_:Stop()

			uv2.timer_ = nil
		end
	end, 0.5, -1)

	slot0.timer_:Start()
end

function slot0.OnEnter(slot0)
	slot0.popPopularItem_ = slot0.params_.popularID
	slot0.selectItem_ = 1

	slot0:RefreshItemS()
	slot0:RefreshContent()

	if DormData:GetCurPopularEvent().id ~= 0 then
		SetActive(slot0.eventGo_, true)
		slot0:RefreshPopularCountdown()
	else
		SetActive(slot0.eventGo_, false)
	end
end

function slot0.RefreshItemS(slot0)
	slot0.itemList_ = {
		{
			num = 1,
			id = slot0.popPopularItem_
		}
	}
	slot2 = 2

	for slot6, slot7 in pairs(DormData:GetPopularEvents()) do
		if slot7 >= 2 then
			for slot11 = 1, slot7 do
				slot0.itemList_[slot2] = {
					num = 1,
					id = slot6
				}
				slot2 = slot2 + 1
			end
		else
			slot0.itemList_[slot2] = {
				num = 1,
				id = slot6
			}
			slot2 = slot2 + 1
		end
	end

	for slot6, slot7 in ipairs(slot0.itemList_) do
		slot8 = slot0["item" .. slot6]

		slot8:RefreshData({
			id = slot7.id,
			number = slot7.num
		})
		slot8:ShowSelect(slot0.selectItem_ == slot6)
		slot8:RegistCallBack(function (slot0)
			uv0.selectItem_ = uv1

			uv0:RefreshItemS()
			uv0:RefreshContent()
		end)
	end
end

function slot0.RefreshContent(slot0)
	slot0.descText_.text = ItemCfg[slot0.itemList_[slot0.selectItem_].id].desc
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	slot0.item1:Dispose()
	slot0.item2:Dispose()
	slot0.item3:Dispose()
	slot0.item4:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
