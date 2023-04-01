slot0 = class("MatrixProcessEquipReplaceView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/Process/MatrixProcessEquipReplaceUI"
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

	slot0.item_ = MatrixProcessRewardItem.New(slot0.m_item)
	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, MatrixProcessRewardItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_okBtn, nil, function ()
		if uv0.params_.callback then
			uv0.params_.callback(uv0.equipData[uv0.selectItemIndex])
		end

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_cancelBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.heroId = slot0.params_.heroId
	slot0.equipId = slot0.params_.equipId
	slot0.equipData = slot0:GetHeroData(slot0.heroId):GetEquipList()

	slot0:Refresh()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Refresh(slot0)
	slot0.selectItemIndex = 1

	slot0.item_:Refresh(slot0.equipId)
	slot0.list_:StartScroll(#slot0.equipData)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RegistCallBack(handler(slot0, slot0.OnItemClick))
	slot2:Refresh(slot0.equipData[slot1], slot1)
	slot2:SetSelected(slot1 == slot0.selectItemIndex)
end

function slot0.OnItemClick(slot0, slot1)
	if slot1 == slot0.selectItemIndex then
		return
	end

	slot0.selectItemIndex = slot1

	for slot6, slot7 in pairs(slot0.list_:GetItemList()) do
		slot7:SetSelected(slot7:GetIndex() == slot0.selectItemIndex)
	end
end

function slot0.Dispose(slot0)
	slot0.item_:Dispose()
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

return slot0
