slot0 = class("DrawTenTimesRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Draw/DrawTenTimesUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, DrawTenTimesRewardItem)

	SetActive(slot0.goShare_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:Back()

		if uv0.params_.callBack_afterTen then
			uv0.params_.callBack_afterTen()
		end
	end)
	slot0:AddBtnListener(slot0.buttonShare_, nil, function ()
		slot0 = manager.share

		slot0:Share(function ()
			SetActive(uv0.goShare_, false)
			SetActive(uv0.goTips_, false)
			manager.notify:Invoke(SHAER_DAW_TEN_TIMES_START)
		end, function ()
			SetActive(uv0.goShare_, true)
			SetActive(uv0.goTips_, true)
			manager.notify:Invoke(SHAER_DAW_TEN_TIMES_END)
		end, function ()
		end)
	end)
end

function slot0.OnEnter(slot0)
	slot0.rewards = slot0.params_.reward

	table.sort(slot0.rewards, function (slot0, slot1)
		slot4 = slot0.index or 0
		slot5 = slot1.index or 0

		if ItemCfg[slot0.id].type ~= ItemCfg[slot1.id].type then
			return slot2.type < slot3.type
		elseif slot2.display_rare ~= slot3.display_rare then
			return slot3.display_rare < slot2.display_rare
		else
			return slot4 < slot5
		end
	end)
	slot0.list:StartScroll(#slot0.rewards)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	for slot4 = 1, #slot0.rewards do
		slot0.list:GetItemByIndex(slot4):OnExit()
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.rewards[slot1])
end

function slot0.Dispose(slot0)
	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
