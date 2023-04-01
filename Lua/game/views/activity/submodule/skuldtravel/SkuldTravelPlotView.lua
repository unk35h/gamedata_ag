slot0 = class("SkuldTravelPlotView", ReduxView)
slot1 = "Textures/EmptyDream/travel/item/"

function slot0.UIName(slot0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelDetails"
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

	slot0.skuldSpine_ = slot0.skuldGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	slot0.skuldidle_ = true
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgbtn_, nil, function ()
		if uv0.params_.poltid then
			JumpTools.Back()
		else
			gameContext:Go("/skuldTravelView")
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()

	if not slot0.params_.poltid then
		SkuldTravelAction:ReadTravelResult()
	end

	slot0.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)

	slot0.skuldidle_ = true

	slot0:CreatTiemrAndStart()
end

function slot0.CreatTiemrAndStart(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			if uv0.skuldidle_ then
				uv0.skuldSpine_.AnimationState:SetAnimation(0, "camera", true)
				manager.audio:PlayEffect("minigame_activity_1_6", "minigame_activity_1_6_camera", "")

				uv0.skuldidle_ = false
			else
				uv0.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)

				uv0.skuldidle_ = true
			end
		end, 4, -1)

		slot0.timer_:Start()
	end
end

function slot0.RefreshUI(slot0)
	slot1 = nil
	slot1 = (not slot0.params_.poltid or TravelSkuldStoryCfg[slot0.params_.poltid]) and TravelSkuldStoryCfg[SkuldTravelData:GetCurPlotId()]
	slot0.nametext_.text = slot1.story_name
	slot0.stroytext_.text = slot1.story_word
	slot0.itemnametext_.text = TravelSkuldItemCfg[slot1.item_id].name
	slot0.itemimage_.sprite = getSpriteWithoutAtlas(uv0 .. TravelSkuldItemCfg[slot1.item_id].icon)
end

function slot0.OnExit(slot0)
	manager.audio:StopEffect()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.super.Dispose(slot0)
end

return slot0
