ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")
slot0 = class("SpringFestivalGreetingSubmoduleItem", ActivitySubmoduleItem)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.updateModelHandler_ = handler(slot0, slot0.LoadModel)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.notify:RegistListener(SPRING_FESTIVAL_GREETING_UPDATE, slot0.updateModelHandler_)
	slot0:LoadModel()
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(SPRING_FESTIVAL_GREETING_UPDATE, slot0.updateModelHandler_)
	uv0.super.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.updateModelHandler_ = nil

	slot0:UnLoadModel()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		ActivityTools.JumpToSubmodulePage(uv0.activityId_)
	end)
	slot0:AddBtnListener(slot0.greetingBtn_, nil, function ()
		JumpTools.OpenPageByJump("springFestivalGreetingLetter")
	end)
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.iconTf_, string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, slot0.activityId_))
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.iconTf_, string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, slot0.activityId_))
end

function slot0.LoadModel(slot0)
	slot1 = slot0.activityId_

	if SpringFestivalGreetingData:GetUnlockCnt(slot1) > #ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[slot1] then
		slot2 = #slot3
	end

	if slot0.lastModelID_ ~= SkinCfg[ActivitySpringFestivalGreetingCfg[slot3[slot2]].story_name].picture_id then
		if slot0.model_ then
			slot0:UnLoadModel()
		end

		slot0.lastModelID_ = slot6
		slot0.model_ = Object.Instantiate(Asset.Load("UIChar/" .. slot6), slot0.charTf_)
	end
end

function slot0.UnLoadModel(slot0)
	if slot0.model_ then
		Object.Destroy(slot0.model_)

		slot0.model_ = nil
		slot0.lastModelID_ = nil
	end
end

return slot0
