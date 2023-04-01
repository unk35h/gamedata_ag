slot0 = class("SkuldTravelShowPlotItem", ReduxView)

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

	slot0.statuController_ = ControllerUtil.GetController(slot0.transform_, "statu")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if SkuldTravelData:GetPlotIsGeted(uv0.poltid_) then
			JumpTools.OpenPageByJump("skuldTravelPlotView", {
				poltid = uv0.poltid_
			})
		else
			ShowTips(GetTips("NO_RECORD"))
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.poltid_ = slot1
	slot0.nametext_.text = TravelSkuldStoryCfg[slot1].story_name

	if SkuldTravelData:GetPlotIsGeted(slot1) then
		slot0.statuController_:SetSelectedState("get")
	else
		slot0.statuController_:SetSelectedState("lock")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
