slot0 = class("TowerGamePlaneView", ReduxView)
slot1 = {
	b = 1,
	a = 0
}

function slot0.UIName(slot0)
	return "UI/MardukUI/snakeactive/MardukSnakedroneUI"
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

	slot0.statu_ = uv0.a
	slot0.APlaneBtnList_ = {}
	slot0.BPlaneBtnList_ = {}

	for slot4 = 1, slot0.atrans_.childCount do
		slot0.APlaneBtnList_[slot4] = slot0.atrans_:GetChild(slot4 - 1):GetComponent(typeof(Button))
	end

	for slot4 = 1, slot0.btrans_.childCount do
		slot0.BPlaneBtnList_[slot4] = slot0.btrans_:GetChild(slot4 - 1):GetComponent(typeof(Button))
	end

	slot0.list_ = LuaList.New(handler(slot0, slot0.ItemRenderler), slot0.listgo_, TowerGamePlaneItem)
	slot0.controller_ = ControllerUtil.GetController(slot0.controllertrans_, "statu")
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.abtn_, nil, function ()
		uv0.statu_ = uv1.a

		uv0.controller_:SetSelectedState("a")
		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(slot0.bbtn_, nil, function ()
		uv0.statu_ = uv1.b

		uv0.controller_:SetSelectedState("b")
		uv0:RefreshUI()
	end)

	if slot0.APlaneBtnList_ then
		for slot4, slot5 in pairs(slot0.APlaneBtnList_) do
			slot0:AddBtnListener(slot5, nil, function ()
				uv0.list_:ScrollToIndex(uv1, false, true)
			end)
		end
	end

	if slot0.BPlaneBtnList_ then
		for slot4, slot5 in pairs(slot0.BPlaneBtnList_) do
			slot0:AddBtnListener(slot5, nil, function ()
				uv0.list_:ScrollToIndex(uv1, false, true)
			end)
		end
	end
end

function slot0.RefreshUI(slot0)
	if slot0.statu_ == uv0.a then
		slot0.list_:StartScroll(TowerGameData:GetATypePlaneNum())
	else
		slot0.list_:StartScroll(TowerGameData:GetBTypePlaneNum())
	end
end

function slot0.ItemRenderler(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.statu_)
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end
end

return slot0
