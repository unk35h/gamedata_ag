slot0 = class("IlluEquipManual", ReduxView)

function slot0.UIName(slot0)
	return "UI/IllustratedHandbook/IlluEquipUI"
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

	slot0.itemScroll_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, IlluEquipManualItem)
end

function slot0.AddUIListener(slot0)
end

function slot0.UpdateDate(slot0)
	slot0.itemList_ = {}
	slot1 = HideInfoData:GetEquipSuitHideList()
	slot2 = 1

	for slot6, slot7 in ipairs(EquipSuitCfg.all) do
		if not slot1[slot7] then
			slot0.itemList_[slot2] = {
				id = slot7
			}
			slot2 = slot2 + 1
		end
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.itemList_[slot1])
end

function slot0.OnEnter(slot0)
	slot0:ShowDefaultBar()
	slot0:UpdateDate()

	if slot0.params_.scrollPos_ then
		slot0.itemScroll_:StartScrollByPosition(#slot0.itemList_, slot0.params_.scrollPos_)
	else
		slot0.itemScroll_:StartScroll(#slot0.itemList_)
	end

	slot0.numText_.text = IlluTools.GetEquipAll() .. "/" .. EquipTools.GetSuitTotalNum() * 6
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.params_.scrollPos_ = slot0.itemScroll_:GetScrolledPosition()
end

function slot0.Dispose(slot0)
	slot0.itemScroll_:Dispose()

	slot0.itemScroll_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
