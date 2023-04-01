slot0 = class("RegressionSignPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("UI/ReturnUI/RegressionSignUI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, RegressionSignItem)
end

function slot0.AddUIListener(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0, slot1)
	slot0.index = RegressionData:GetSignIndex()
	slot0.rewards = RegressionCfg[RegressionData:GetRegressionVersion()] and RegressionCfg[slot2].sign_reward or {}

	slot0.list:StartScroll(#slot0.rewards)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.rewards[slot1])
	slot2:RegistCallBack(handler(slot0, slot0.OnItemClick))
end

function slot0.OnItemClick(slot0, slot1)
	RegressionAction.QuerySign(slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.RefreshTime(slot0)
	if slot0.indx ~= RegressionData:GetSignIndex() then
		for slot5, slot6 in ipairs(slot0.list:GetItemList()) do
			slot6:Refresh()
		end
	end
end

function slot0.OnRegressionSign(slot0)
	for slot5, slot6 in ipairs(slot0.list:GetItemList()) do
		slot6:Refresh()
	end
end

return slot0
