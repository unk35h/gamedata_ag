slot0 = class("RestaurantJobView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dining/DiningSelectHeroUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.sceneID = DormConst.CANTEEN_ID
	slot0.jobScroll = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, RestaurantJobItem)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0:RefreshView()
end

function slot0.OnExit(slot0)
	slot0.selJobID = nil
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.jobList[slot1])
	slot2:ChangeJobCallBack(function (slot0, slot1)
		JumpTools.OpenPageByJump("/restaurantJobSetView", {
			jobType = slot1
		})
	end)
	slot2:ClickItemCallBack(function (slot0)
		uv0.selJobID = slot0
	end)
end

function slot0.RefreshView(slot0)
	slot0.jobList = {}

	for slot5, slot6 in pairs(DormData:GetCanteenJobList()) do
		slot7 = {
			jobID = slot5
		}

		if slot6 then
			slot7.heroID = slot6.heroID
		end

		table.insert(slot0.jobList, slot7)
	end

	slot0.jobScroll:StartScroll(#slot0.jobList, slot0.selJobID)
end

function slot0.Dispose(slot0)
	if slot0.jobScroll then
		slot0.jobScroll:Dispose()
	end

	if slot0.heroSkillScroll then
		slot0.heroSkillScroll:Dispose()

		slot0.heroSkillScroll = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
