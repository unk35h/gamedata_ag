slot0 = class("WarChessReviveView", ReduxView)

function slot0.UIName(slot0)
	return "UI/WarChess/WarChessReviveUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0.selectItem_ = 1

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.panelitemGo_, ChessReviveItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		if uv0.selectItem_ ~= 0 then
			WarChessAction.ReviveHero(uv0.pos_, uv0.itemList_[uv0.selectItem_])
		end
	end)
end

function slot0.UpdateData(slot0)
	slot0.itemList_ = {}

	for slot5, slot6 in pairs(WarChessData:GetHeroList()) do
		if slot6 <= 0 then
			table.insert(slot0.itemList_, slot5)
		end
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.itemList_[slot1], slot1)
	slot2:ShowSelect(slot1 == slot0.selectItem_)
	slot2:RegisterListener(function (slot0)
		for slot5, slot6 in pairs(uv0.scrollHelper_:GetItemList()) do
			slot6:ShowSelect(slot0 == slot5)

			uv0.selectItem_ = slot0
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.selectItem_ = 1
	slot0.pos_ = {
		x = slot0.params_.x,
		z = slot0.params_.z
	}
	slot0.callback_ = slot0.params_.callback

	slot0:UpdateData()
	slot0.scrollHelper_:StartScroll(#slot0.itemList_)
end

function slot0.OnExit(slot0)
end

function slot0.OnReviveHero(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		WarChessData:ModifyHp(slot2.param, 10000)
		slot0:Back()
		slot0.callback_()
	else
		manager.ChessManager:EventsEnd()
		ShowTips(slot1.result)
	end
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
