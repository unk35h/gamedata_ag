slot0 = class("FrameExpiredView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/AvatarExpirationUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, CommonItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.params_.materialList[slot1].id,
		number = slot0.params_.materialList[slot1].num,
		time_valid = slot0.params_.materialList[slot1].time_valid
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_OTHER_ITEM, {
			slot0.id,
			slot0.number,
			0,
			slot0.time_valid
		})
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	slot0.itemList_:StartScroll(#slot0.params_.materialList)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.itemList_ ~= nil then
		slot0.itemList_:Dispose()

		slot0.itemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
