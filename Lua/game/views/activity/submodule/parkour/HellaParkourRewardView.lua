slot0 = class("HellaParkourRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/HellaUI/Parkour/HellaParkourRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.rewardIndexs = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, HellaParkourRewardItem)
	slot0.singleController = ControllerUtil.GetController(slot0.transform_, "single")
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.list

	slot1:SetPageChangeHandler(handler(slot0, slot0.OnPageChange))
	slot0:AddBtnListener(slot0.m_preBtn, nil, function ()
		uv0.list:SwitchToPage(uv0.pageIndex_ - 1)
	end)
	slot0:AddBtnListener(slot0.m_nextBtn, nil, function ()
		uv0.list:SwitchToPage(uv0.pageIndex_ + 1)
	end)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnPageChange(slot0, slot1)
	slot0.pageIndex_ = slot1

	SetActive(slot0.m_preBtn.gameObject, slot1 > 1)
	SetActive(slot0.m_nextBtn.gameObject, slot1 < #slot0.pages)
	slot0:UpdateRedPoint()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.parkour_activity_id = slot0.params_.parkour_activity_id

	if slot0.params_.entrust_activity_id then
		slot0.pages = {
			slot0.params_.entrust_activity_id
		}
	else
		slot0.pages = {}

		for slot5, slot6 in ipairs(ActivityCfg[slot0.parkour_activity_id].sub_activity_list) do
			if ActivityData:GetActivityIsOpen(slot6) then
				table.insert(slot0.pages, slot6)
			end
		end
	end

	slot0.list:StartScroll(#slot0.pages, 1, true, false)
	slot0:OnPageChange(1)
	slot0.singleController:SetSelectedIndex(#slot0.pages > 1 and 0 or 1)
	slot0:UpdateRewardIndex()
end

function slot0.UpdateRewardIndex(slot0)
	slot0.rewardIndexs = {}

	for slot4, slot5 in ipairs(slot0.pages) do
		if ParkourData:GetParkourEntrustData(slot5) then
			for slot10, slot11 in ipairs(slot6.stars) do
				if not table.indexof(slot6.rewards, slot11) then
					table.insert(slot0.rewardIndexs, slot4)

					break
				end
			end
		end
	end

	slot0:UpdateRedPoint()
end

function slot0.UpdateRedPoint(slot0)
	slot1 = false
	slot2 = false

	for slot6, slot7 in ipairs(slot0.rewardIndexs) do
		if slot0.pageIndex_ < slot7 then
			slot2 = true
		elseif slot7 < slot0.pageIndex_ then
			slot1 = true
		end
	end

	manager.redPoint:SetRedPointIndependent(slot0.m_preBtn.transform, slot1)
	manager.redPoint:SetRedPointIndependent(slot0.m_nextBtn.transform, slot2)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.pages[slot1])
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnParkourReward(slot0)
	slot0.list:StartScroll(#slot0.pages, slot0.pageIndex_, true, false)
	slot0:UpdateRewardIndex()
end

return slot0
