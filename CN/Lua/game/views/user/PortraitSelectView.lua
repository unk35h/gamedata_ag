slot0 = class("PortraitSelectView", ReduxView)
slot1 = import("game.tools.HeroTools")

function slot0.UIName(slot0)
	return "UI/ShowHeroSelectUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.selector_ = createStructuredSelector({
		sortList = function (slot0)
			return uv0.Sort(slot0.herolist)
		end,
		portrait = function (slot0)
			return PlayerData:GetPlayerInfo().portrait
		end
	})
end

function slot0.InitUI(slot0)
	slot0.show_ = slot0:FindGo("btn_show")
	slot0.hide_ = slot0:FindGo("btn_hide")
	slot0.list_ = slot0:FindTrs("list/Grid")
	slot0.listGo_ = slot0:FindGo("list")
	slot0.itemPrefeb = Asset.Load("UI/Common/HeroItemUI")
	slot0.itemPool_ = Pool.New(slot0.itemPrefeb, slot0.list_, 0)
	slot0.scrollHelper = GridScrollHelper.New(handler(slot0, slot0.indexItem), slot0.listGo_, slot0.list_)

	SetActive(slot0.hide_, false)
end

function slot0.indexItem(slot0, slot1)
	if slot1 < 0 or slot1 > #slot0.model_.sortList then
		return nil
	end

	slot2, slot4.recycleIndex = slot0.itemPool_:GetCanUsingObj()

	SetActive(slot2, true)

	slot4 = CommonHeroItem.New(slot0, slot2, slot0.model_.sortList[slot1])

	slot4:RegistCallBack(handler(slot0, slot0.OnListBtnClick))

	slot4.pools = slot0.itemPool_

	return slot4
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale("btn_return", nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListenerScale("btn_last", nil, function ()
		uv0:Go("/home")
	end)
	slot0:AddBtnListener("up", nil, "MoveList", -440)
	slot0:AddBtnListener("down", nil, "MoveList", 440)
	slot0:AddBtnListenerScale("btn_show", nil, function ()
		uv0:OnPageBtnClick()
	end)
end

function slot0.OnPageBtnClick(slot0)
	slot2 = ActionCreators.ChangePortrait(slot0.clickedId_)

	slot2:next(function (slot0)
		if isSuccess(slot0.result) then
			ActionCreators.PlayerProtraitChange(uv0)
			uv1:Back()
		end
	end)
end

function slot0.OnListBtnClick(slot0, slot1)
	if slot0.clickedId_ == slot1 then
		return
	end

	slot4 = slot0.scrollHelper
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemS(slot6)) do
		if slot0.clickedId_ == slot6:GetItemId() then
			slot6:ShowIsSelect(false)
		end

		if slot1 == slot6:GetItemId() then
			slot6:ShowIsSelect(true)
		end
	end

	slot0.clickedId_ = tonumber(slot1)

	if slot0.clickedId_ ~= slot0.model_.portrait ~= slot0.isShowBtn_ then
		SetActive(slot0.show_, slot3)
	end

	slot0.isShowBtn_ = slot3
end

function slot0.Render(slot0)
	if slot0.model_.sortList ~= slot0.selector_.compute(gameStore.getState()).sortList then
		slot0:RefreshUI(slot1.sortList, slot1.portrait)

		slot0.model_.sortList = slot1.sortList
	end
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot6 = #slot0.model_.sortList

	slot0.scrollHelper:StartScroll(slot6)

	slot5 = slot0.scrollHelper
	slot7 = slot5

	for slot6, slot7 in ipairs(slot5.GetItemS(slot7)) do
		if slot7:GetItemId() == slot2 then
			slot7:ShowMiddleText(GetTips("CURRENT_SHOW"))
		else
			slot7:ShowMiddleText("")
		end
	end
end

function slot0.MoveList(slot0, slot1)
	slot2 = slot0.list_.transform.localPosition
	slot0.list_.transform.localPosition = Vector3(slot2.x, math.floor((slot2.y + slot1) / 440) * 440 + 10, slot2.z)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0.model_ = slot0.selector_.compute(gameStore.getState())

	slot0:RefreshUI(slot0.model_.sortList, slot0.model_.portrait)
	slot0:OnListBtnClick(slot0.model_.sortList[1])

	slot0.unsubscribeFun = gameStore.subscribe(function (slot0)
		uv0:Render()
	end)
end

function slot0.OnExit(slot0)
	slot0.unsubscribeFun()
end

function slot0.Dispose(slot0)
	slot0.clickedId_ = nil
	slot0.itemPrefeb = nil

	slot0.scrollHelper:Dispose()
	slot0.itemPool_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
