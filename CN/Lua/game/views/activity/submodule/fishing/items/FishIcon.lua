slot0 = class("FishIcon", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.iconController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "icon")
	slot0.showNumController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "showNum")
	slot0.showHaveController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "showHave")
	slot0.selectedController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "selected")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.iconBtn_, nil, function ()
		if uv0.clickListener_ ~= nil then
			uv0.clickListener_(uv0.id_)
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.icon_.raycastTarget = true
	slot0.clickListener_ = slot1
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectedController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.SetId(slot0, slot1, slot2, slot3)
	slot0.id_ = slot1
	slot0.haveNum_ = slot3 or -1
	slot0.num_ = slot2 or -1

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	if slot0.needUpdateHave_ then
		slot0:UpdateHaveBg()
	end

	slot0.icon_.sprite = getSpriteWithoutAtlas(string.format("Textures/Fishing/RareFishIcon/%d", slot0.id_))

	if slot0.num_ == -1 then
		slot0.showNumController_:SetSelectedState("false")
	else
		slot0.showNumController_:SetSelectedState("true")

		slot0.numLabel_.text = tostring(slot0.num_)
	end

	if slot0.haveNum_ == -1 then
		slot0.showHaveController_:SetSelectedState("false")
	else
		slot0.showHaveController_:SetSelectedState("true")

		slot0.haveNumLabel_.text = tostring(slot0.haveNum_)
	end
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.SetNeedUpdateHave(slot0, slot1)
	slot0.needUpdateHave_ = slot1
end

function slot0.UpdateHaveBg(slot0)
	slot1 = 0

	if FishingData:GetFish(slot0.id_) ~= nil then
		slot1 = slot2.num
	end

	if slot1 > 0 then
		slot0.iconController_:SetSelectedState("have")
	else
		slot0.iconController_:SetSelectedState("not")
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0.clickListener_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
