slot0 = class("GuildHeadIconSelect", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubSelect"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.headIconList_ = {}

	for slot4, slot5 in ipairs(ClubHeadIconCfg.all) do
		slot0.headIconList_[slot5] = GuildHeadIconItem.New(slot0.goHeadIcon_, slot0.transformHeadIcon_, slot5)
	end

	slot0.selectHeadIconHandler_ = handler(slot0, slot0.SelectHeadIcon)
end

function slot0.OnEnter(slot0)
	slot0.selectID_ = slot0.params_.selectID

	slot0:RefreshHeadIcon()
	manager.notify:RegistListener(GUILD_SELECT_HEAD_ICON, slot0.selectHeadIconHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(GUILD_SELECT_HEAD_ICON, slot0.selectHeadIconHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.selectHeadIconHandler_ = nil

	for slot4, slot5 in pairs(slot0.headIconList_) do
		slot5:Dispose()
	end

	slot0.headIconList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonCancel_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonOk_, nil, function ()
		manager.notify:Invoke(GUILD_SWITCH_HEAD_ICON, uv0.selectID_)
		uv0:Back()
	end)
end

function slot0.SelectHeadIcon(slot0, slot1)
	slot0.selectID_ = slot1

	slot0:RefreshHeadIcon()
end

function slot0.RefreshHeadIcon(slot0)
	for slot4, slot5 in pairs(slot0.headIconList_) do
		slot5:SetSelect(slot4 == slot0.selectID_)
	end
end

return slot0
