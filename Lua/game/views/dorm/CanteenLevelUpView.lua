slot0 = class("CanteenLevelUpView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamCanteenLvUpPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.chooseTasteItemScroll = LuaList.New(handler(slot0, slot0.refreshItem), slot0.awarduilistUilist_, FoodMenuItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.refreshItem(slot0, slot1, slot2)
	slot2:RefreshItem(slot0.materialItemList_[slot1][1], DormEnum.MenuType.levelAward, slot0.materialItemList_[slot1][2])
	slot2:RegisterClickCallBack(function (slot0, slot1)
		ShowPopItem(POP_ITEM, {
			slot0
		})
	end)
end

function slot0.OnEnter(slot0)
	manager.audio:PlayEffect("ui_system", "hero_levelup", "")
	slot0:UpdataView()
end

function slot0.UpdataView(slot0)
	slot0.materialItemList_ = slot0.params_.awardList
	slot0.lvText_.text = CanteenData:GetInfoCanteenLevel()

	if slot0.materialItemList_ then
		slot0.chooseTasteItemScroll:StartScroll(#slot0.materialItemList_)
	end
end

function slot0.Dispose(slot0)
	if slot0.chooseTasteItemScroll then
		slot0.chooseTasteItemScroll:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
