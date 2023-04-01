slot0 = class("IlluWorldView", ReduxView)
slot1 = {
	71500,
	71501,
	71502,
	71503,
	71504,
	71505,
	71506
}
slot2 = false

function slot0.UIName(slot0)
	return "UI/IllustratedHandbook/IlluWorldViewUI"
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

	slot0.itemScroll_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, IlluWorldIViewItem)
	slot0.tree_ = LuaTree.New(slot0.uitreeGo_)
	slot6 = slot0
	slot5 = nil

	slot0.tree_:SetSelectedHandler(handler(slot6, slot0.OnGroupSelect), slot5)

	slot1 = UITreeData.New()

	slot0:UpdateToggleData()

	for slot5, slot6 in ipairs(slot0.toggleList_) do
		slot7 = UITreeGroupData.New()
		slot7.id = slot5
		slot7.text = slot6

		slot1.groupDatas:Add(slot7)
	end

	slot0.tree_:SetData(slot1)

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	slot0.selectToggle_ = slot1

	slot0:UpdateItemData(slot0.selectToggle_, 1)

	if slot0.itemList_[1] then
		slot0.itemList_[1].isFirst = uv0
	end

	slot0.itemScroll_:StartScroll(#slot0.itemList_)
	slot0:SetSelectItem(1)
end

function slot0.SetSelectItem(slot0, slot1)
	if slot0.itemList_[slot0.selectItem_] then
		slot0.itemList_[slot0.selectItem_].select = false
	end

	slot0.selectItem_ = slot1

	if slot0.itemList_[slot0.selectItem_] then
		slot0.itemList_[slot0.selectItem_].select = true
	end

	for slot6, slot7 in pairs(slot0.itemScroll_:GetItemList()) do
		slot7:ShowSelect(slot1 == slot6)
	end

	slot0:RefreshInfo(slot0.itemList_[slot0.selectItem_])
end

function slot0.UpdateToggleData(slot0)
	slot0.toggleList_ = {}
	slot5 = uv0[1]
	slot4 = TipsCfg[slot5].desc

	table.insert(slot0.toggleList_, slot4)

	for slot4, slot5 in ipairs(CollectWordCfg.get_id_list_by_type) do
		table.insert(slot0.toggleList_, TipsCfg[uv0[slot4 + 1]].desc)
	end
end

function slot0.UpdateItemData(slot0, slot1, slot2)
	slot0.itemList_ = {}
	slot3 = IllustratedData:GetAffixInfo()
	slot4 = 1

	if slot1 == 1 then
		for slot8, slot9 in pairs(slot3) do
			table.insert(slot0.itemList_, {
				id = slot8,
				isRead = IllustratedData:GetInfoIsView(CollectConst.WORLDVIEW, slot8)
			})

			slot4 = slot4 + 1
		end
	else
		for slot8, slot9 in pairs(slot3) do
			if CollectWordCfg[slot8].type == slot1 - 1 then
				table.insert(slot0.itemList_, {
					id = slot8,
					isRead = IllustratedData:GetInfoIsView(CollectConst.WORLDVIEW, slot8)
				})

				slot4 = slot4 + 1
			end
		end
	end

	function slot8(slot0, slot1)
		if slot0.isRead ~= slot1.isRead then
			return slot0.isRead < slot1.isRead
		end

		return slot0.id < slot1.id
	end

	table.sort(slot0.itemList_, slot8)

	for slot8 = 1, #slot0.itemList_ do
		slot0.itemList_[slot8].select = slot8 == slot2
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RegisterBtnListener(handler(slot0, slot0.SetSelectItem))
	slot2:RefreshUI(slot1, slot0.itemList_[slot1])
end

function slot0.AddUIListener(slot0)
end

function slot0.RefreshInfo(slot0, slot1)
	if slot1 then
		slot0.controller_:SetSelectedState("1")

		slot0.describetextText_.text = CollectWordCfg[slot1.id].desc
		slot0.nameText_.text = CollectWordCfg[slot1.id].name
	else
		slot0.controller_:SetSelectedState("0")
	end
end

function slot0.OnEnter(slot0)
	slot0:ShowDefaultBar()

	slot0.selectToggle_ = 1
	slot0.selectItem_ = 1
	uv0 = true

	slot0.tree_:SelectGroup(slot0.selectToggle_)

	uv0 = false
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.itemScroll_:Dispose()
	slot0.tree_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
