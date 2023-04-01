slot0 = class("MythicFinalRankHeroView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Mythic/MythicRankHeroPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bgbtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listgo_, MythicFinalRankHeroItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.params_.herolist[slot1], slot0.userID_)
end

function slot0.OnEnter(slot0)
	slot0.userID_ = slot0.params_.userID
	slot0.nametext_.text = slot0.params_.name

	slot0.list_:StartScroll(#slot0.params_.herolist)
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
