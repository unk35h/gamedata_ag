slot0 = class("IlluServantManual", ReduxView)

function slot0.UIName(slot0)
	return "UI/IllustratedHandbook/IlluServantUI"
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

	slot0.itemScroll_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, IlluServantManualItem)
end

function slot0.OnGroupSelect(slot0, slot1)
	slot0.selectIndex_ = slot1
	slot0.params_.index = slot0.selectIndex_

	slot0:UpdateItemData(slot0.selectIndex_)
	slot0.itemScroll_:StartScroll(#slot0.itemList_)
	slot0:RefreshCollectNum(slot1)
end

function slot0.UpdateToggleData(slot0)
	slot0.toggleList_ = {
		GetTips("ALL")
	}
	slot0.raceList_ = {}

	for slot5, slot6 in pairs(WeaponServantCfg.get_id_list_by_race) do
		table.insert(slot0.raceList_, slot5)
	end

	function slot5(slot0, slot1)
		return slot0 < slot1
	end

	table.sort(slot0.raceList_, slot5)

	for slot5, slot6 in ipairs(slot0.raceList_) do
		table.insert(slot0.toggleList_, RaceEffectCfg[slot6].name)
	end
end

function slot0.UpdateItemData(slot0, slot1)
	slot0.itemList_ = {}
	slot0.maxNum_ = 0

	if slot1 == 1 then
		for slot5, slot6 in ipairs(WeaponServantCfg.all) do
			slot7 = IllustratedData:GetServantInfo()[slot6]

			if not ServantTools.GetIsHide(slot6) and (slot7 or WeaponServantCfg[slot6].display_type ~= 1) then
				table.insert(slot0.itemList_, {
					name = ItemCfg[slot6].name,
					id = slot6,
					isUnlock = slot7
				})

				slot0.maxNum_ = slot0.maxNum_ + 1
			end
		end
	else
		for slot6, slot7 in ipairs(WeaponServantCfg.get_id_list_by_race[slot0.raceList_[slot1 - 1]]) do
			slot8 = IllustratedData:GetServantInfo()[slot7]

			if not ServantTools.GetIsHide(slot7) and (slot8 or WeaponServantCfg[slot7].display_type ~= 1) then
				table.insert(slot0.itemList_, {
					name = ItemCfg[slot7].name,
					id = slot7,
					isUnlock = slot8
				})

				slot0.maxNum_ = slot0.maxNum_ + 1
			end
		end
	end

	table.sort(slot0.itemList_, function (slot0, slot1)
		if slot0.isUnlock and not slot1.isUnlock then
			return true
		end

		if slot1.isUnlock and not slot0.isUnlock then
			return false
		end

		if ItemCfg[slot0.id].rare ~= ItemCfg[slot1.id].rare then
			return ItemCfg[slot1.id].rare < ItemCfg[slot0.id].rare
		end

		return slot1.id < slot0.id
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.itemList_[slot1])
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
	slot0:ShowDefaultBar()

	slot0.selectIndex_ = slot0.params_.index or 1
	slot0.params_.index = slot0.selectIndex_

	slot0.tree_:SelectGroup(slot0.selectIndex_)

	if slot0.params_.scrollPos_ then
		slot0.itemScroll_:StartScrollByPosition(#slot0.itemList_, slot0.params_.scrollPos_)
	end
end

function slot0.RefreshCollectNum(slot0, slot1)
	slot2 = #slot0.itemList_
	slot3 = 0

	if slot1 == 1 then
		slot3 = table.length(IllustratedData:GetServantInfo())
	else
		for slot8, slot9 in ipairs(WeaponServantCfg.get_id_list_by_race[slot0.raceList_[slot1 - 1]]) do
			if IllustratedData:GetServantInfo()[slot9] then
				slot3 = slot3 + 1
			end
		end
	end

	slot0.collectnumText_.text = slot3 .. "/" .. slot0.maxNum_
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.params_.scrollPos_ = slot0.itemScroll_:GetScrolledPosition()
end

function slot0.Dispose(slot0)
	slot0.itemScroll_:Dispose()
	slot0.tree_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
