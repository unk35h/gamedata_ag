slot0 = class("MatrixProcessAstrolabeReplaceView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/Process/MatrixProcessAstrolabeReplaceUI"
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
	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, MatrixProcessAstrolabeRewardItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_okBtn, nil, function ()
		if uv0.params_.callback then
			uv0.params_.callback(uv0.astrolabeList[uv0.selectItemIndex])
		end

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_cancelBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.heroId = slot0.params_.heroId
	slot0.astrolabeId = slot0.params_.astrolabeId
	slot2 = MatrixItemCfg[slot0.astrolabeId].params[1]
	slot4 = {}

	for slot8, slot9 in ipairs(slot0:GetHeroData(slot0.heroId):GetAstrolabeList()) do
		if MatrixItemCfg[slot9].params[1] ~= slot2 then
			slot4[slot11] = slot9
		end
	end

	slot0.astrolabeList = {}

	for slot8, slot9 in pairs(slot4) do
		table.insert(slot0.astrolabeList, slot9)
	end

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

	slot0.item_:Refresh(slot0.astrolabeId)
	slot0.list_:StartScroll(#slot0.astrolabeList)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RegistCallBack(handler(slot0, slot0.OnItemClick))
	slot2:Refresh(slot0.astrolabeList[slot1], slot1, slot0.astrolabeId)
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
