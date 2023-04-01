slot0 = class("SurveyView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/InvestigateUI"
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

	slot0.surveyList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, SurveyItem)
	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.UpdateData(slot0)
	slot0.itemList_ = {}

	for slot5, slot6 in pairs(SurveyData:GetSurveyList()) do
		if slot0.params_.type == slot6.type then
			table.insert(slot0.itemList_, slot6)
		end
	end

	table.sort(slot0.itemList_, function (slot0, slot1)
		function slot2(slot0)
			if slot0 == 1 then
				return 1
			end

			if slot0 == 2 then
				return 3
			end

			if slot0 == 0 then
				return 2
			end
		end

		if slot2(slot0.status) ~= slot2(slot1.status) then
			return slot3 < slot4
		end

		return slot1.id < slot0.id
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.itemList_[slot1])
end

function slot0.OnEnter(slot0)
	slot0:UpdateData()

	if #slot0.itemList_ <= 0 then
		slot0.controller_:SetSelectedState("false")
	else
		slot0.controller_:SetSelectedState("true")
		slot0.surveyList_:StartScroll(#slot0.itemList_)
	end
end

function slot0.OnExit(slot0)
end

function slot0.OnGetSurveyGift(slot0, slot1, slot2)
	slot0:UpdateData()
	slot0.surveyList_:StartScroll(#slot0.itemList_)

	slot4 = {}

	for slot8, slot9 in ipairs(SurveyData:GetSurveyList()[slot2.id].attachment_list) do
		table.insert(slot4, {
			slot9.id,
			slot9.num
		})
	end

	getReward(mergeReward(slot4))
end

function slot0.OnFinishSurvey(slot0)
	slot0:UpdateData()
	slot0.surveyList_:StartScroll(#slot0.itemList_)
end

function slot0.Dispose(slot0)
	slot0.surveyList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
