slot0 = class("SkuldTravelFinalResultItem", ReduxView)
slot1 = "Textures/EmptyDream/travel/image/"

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.raskController_ = {}

	for slot4 = 1, 3 do
		slot0.raskController_[slot4] = ControllerUtil.GetController(slot0["rasktrans_" .. slot4], "statu")
	end

	slot0.statucontroller_ = ControllerUtil.GetController(slot0.transform_, "statu")
	slot0.isshowtaskController_ = ControllerUtil.GetController(slot0.transform_, "isshowtask")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.index_ > 3 then
			if SkuldTravelData:GetEndingIsOpened(uv0.endingid_) then
				BattleController.GetInstance():LaunchStoryBattle(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, GameSetting.travel_skuld_new_ending_stage_id.value[1], 0)
			else
				SkuldTravelAction:OpenEnding(uv0.endingid_)
			end
		elseif SkuldTravelData:GetEndingIsOpened(uv0.endingid_) then
			JumpTools.OpenPageByJump("skuldTravelFinalPlotView", {
				endingid = uv0.endingid_
			})
		elseif SkuldTravelData:GetEndingIsCanOpen(uv0.endingid_) then
			SkuldTravelAction:OpenEnding(uv0.endingid_)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.index_ = slot1
	slot0.endingid_ = TravelSkuldEndingCfg.all[slot1]
	slot0.cfg_ = TravelSkuldEndingCfg[slot0.endingid_]
	slot0.endingname_.text = slot0.cfg_.story_name
	slot2 = uv0
	slot0.itemimage_.sprite = getSpriteWithoutAtlas(SkuldTravelData:GetSkuldBtnIsBreach() and slot2 .. TravelSkuldEndingCfg[slot0.endingid_].destroy_picture or slot2 .. TravelSkuldEndingCfg[slot0.endingid_].picture)

	if slot1 > 3 then
		slot0.isshowtaskController_:SetSelectedState("false")

		if SkuldTravelData:GetEndingIsOpened(slot0.endingid_) then
			slot0.statucontroller_:SetSelectedState("get")
		else
			slot0.statucontroller_:SetSelectedState("canopen")
		end
	else
		slot0.isshowtaskController_:SetSelectedState("true")

		slot6 = SkuldTravelData
		slot8 = slot6
		slot9 = slot0.endingid_

		slot0.statucontroller_:SetSelectedState(slot6.GetEndingStatu(slot8, slot9))

		slot3 = 1
		slot4 = SkuldTravelData:GetAttrib()

		for slot8, slot9 in pairs(slot0.cfg_.unlock_attrib) do
			if slot9 > 0 then
				if slot9 <= slot4[slot8] then
					slot0.raskController_[slot3]:SetSelectedState("finish")
				else
					slot0.raskController_[slot3]:SetSelectedState("unfinish")
				end

				slot0["rasktext_" .. slot3].text = SkuldTravelData:AttribIndexToString(slot8) .. "≥" .. slot9
				slot3 = slot3 + 1
			end
		end

		for slot8, slot9 in pairs(slot0.cfg_.unlock_story_collect) do
			slot0["rasktext_" .. slot3].text = string.format(GetTips("TRAVEL_SKULD_STORY_GET_INFINAL"), TravelSkuldStoryCfg[slot9].story_name)

			if SkuldTravelData:GetPlotIsGeted(slot9) then
				slot0.raskController_[slot3]:SetSelectedState("finish")
			else
				slot0.raskController_[slot3]:SetSelectedState("unfinish")
			end
		end
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
