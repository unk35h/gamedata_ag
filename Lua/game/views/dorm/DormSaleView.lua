slot0 = class("DormSaleView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HouseUI/HouseonsaleUI"
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

	slot0.saleList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, DormOnSaleItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = DormData:GetCurrectSceneID()

	slot2:SetData(slot1, not DormData:IsGoodPosOpen(slot1), DormData:GetDormSceneData(DormData:GetCurrectSceneID()).sales[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.saleList_:StartScroll(#DormData:GetDormSceneData(DormData:GetCurrectSceneID()).sales)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.saleList_ then
		slot0.saleList_:Dispose()

		slot0.saleList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
