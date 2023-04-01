slot0 = class("CanteenLevelInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamCanteenDetailsPop"
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

	slot0.awardListScroll_ = LuaList.New(handler(slot0, slot0.indexAwardItem), slot0.awarduilistUilist_, CommonItem)
	slot0.activiteID_ = ActivityConst.SPRING_CANTEEN
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activiteID_).stopTime
	slot0.emptyController_ = ControllerUtil.GetController(slot0.awarduilistGo_.transform, "empty")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.indexAwardItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.awardList[slot1][1],
		number = slot0.awardList[slot1][2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id
		})
	end)
end

function slot0.UpdataView(slot0)
	slot1 = CanteenData:GetInfoCanteenLevel()
	slot0.nowleveltextText_.text = slot1

	if slot1 == BackHomeFestivalCanteenLevel.all[#BackHomeFestivalCanteenLevel.all] then
		slot0.expprogressbarSlr_.value = 0
		slot0.exptextText_.text = string.format("<size=28><color=#767878>%s</color></size>", GetTips("TEXT_LEVEL_MAX"))
		slot0.awardList = {}

		slot0.awardListScroll_:StartScroll(#slot0.awardList)
		slot0.emptyController_:SetSelectedState("false")
	else
		slot0.awardList = BackHomeFestivalCanteenLevel[slot1 + 1].gift
		slot2 = CanteenData:CalculateCurLevelNum()
		slot3 = BackHomeFestivalCanteenLevel[slot1].need
		slot0.exptextText_.text = string.format("%d<size=28><color=#767878>/%d</color></size>", slot2, slot3)
		slot0.expprogressbarSlr_.value = slot2 / slot3

		slot0.awardListScroll_:StartScroll(#slot0.awardList)
	end

	slot0.popnumText_.text = CanteenData:GetPopularityNum()
	slot0.poptextText_.text = GetTips("CANTEEN_HOT_DESC")

	if slot1 == BackHomeFestivalCanteenLevel.all[#BackHomeFestivalCanteenLevel.all] then
		slot0.leveluptitleGo_:SetActive(false)
	else
		slot0.leveluptitleText_.text = string.format(GetTips("CANTEEN_LEVEL_PREVIEW"), slot1 + 1)
	end

	slot0.lasttimeText_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
end

function slot0.OnEnter(slot0)
	slot0:UpdataView()
end

function slot0.Dispose(slot0)
	if slot0.awardListScroll_ then
		slot0.awardListScroll_:Dispose()

		slot0.awardListScroll_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
