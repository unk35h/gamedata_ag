slot0 = class("MatrixOverEvaluateView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/MatrixAssessPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.evaluateItemList_ = {}
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.sureBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	for slot5, slot6 in ipairs(MatrixData:GetEvaluateList()) do
		if not slot0.evaluateItemList_[slot5] then
			slot0.evaluateItemList_[slot5] = MatrixOverEvaluateItem.New(slot0.evaluateItem_, slot0.evaluateParent_)
		end

		slot0.evaluateItemList_[slot5]:SetEvaluateID(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.evaluateItemList_ do
		slot0.evaluateItemList_[slot5]:Show(false)
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.evaluateItemList_) do
		slot5:Dispose()
	end

	slot0.evaluateItemList_ = nil
end

return slot0
