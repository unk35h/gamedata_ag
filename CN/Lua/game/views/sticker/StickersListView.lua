slot0 = class("StickersListView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/Sticker/StickersListUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.medalList_ = {}
	slot0.medalScrollHelper_ = LuaList.New(handler(slot0, slot0.MedalRenderer), slot0.listGo_, MedalItem)
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
	for slot5, slot6 in ipairs(PlayerData:GetStickerList()) do
		slot8 = PlayerData:GetSticker(slot6)

		if ItemCfg[slot6].sub_type ~= 1302 or slot8.unlock ~= 0 then
			table.insert(slot0.medalList_, slot8)
		end
	end

	table.sort(slot0.medalList_, function (slot0, slot1)
		if slot0.unlock ~= slot1.unlock then
			return slot1.unlock < slot0.unlock
		end

		return slot0.id < slot1.id
	end)
	slot0.medalScrollHelper_:StartScroll(#slot0.medalList_)
end

function slot0.MedalRenderer(slot0, slot1, slot2)
	slot2:RefreshItem(slot0.medalList_[slot1])
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	slot0.medalList_ = {}

	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.medalScrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
