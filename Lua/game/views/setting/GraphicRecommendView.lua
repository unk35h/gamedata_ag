slot0 = class("GraphicRecommendView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Setting/GraphicRecommendUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.qualityIdList_ = {
		3,
		4,
		5
	}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.defaultQualityController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "defaultQuality")
	slot0.toggles_ = {
		slot0.lowToggle_,
		slot0.middleToggle_,
		slot0.highToggle_
	}
	slot0.recommendIconGos_ = {
		slot0.lowRecommendIconGo_,
		slot0.middleRecommendIconGo_,
		slot0.highRecommendIconGo_
	}
	slot0.recommendTips_ = {
		GetTips("GRAPHIC_RECOMMEND_3"),
		GetTips("GRAPHIC_RECOMMEND_2"),
		GetTips("GRAPHIC_RECOMMEND_1")
	}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		for slot3, slot4 in ipairs(uv0.toggles_) do
			if slot4.isOn then
				slot5 = uv0.qualityIdList_[slot3]

				if uv0.params_.callback ~= nil then
					uv0.params_.callback(slot3, slot5)
				end

				return
			end
		end
	end)
end

function slot0.OnEnter(slot0)
	if table.indexof(slot0.qualityIdList_, SettingData:GetDefaultSetting()) then
		SetActive(slot0.recommendIconGos_[slot2], true)

		slot0.toggles_[slot2].isOn = true
		slot0.recommendText_.text = slot0.recommendTips_[slot2]
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
