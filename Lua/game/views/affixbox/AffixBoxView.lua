slot0 = class("AffixBoxView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Common/MessageBox4"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMessage.transform
end

function slot0.OnCtor(slot0)
	slot0.itemView_ = {}
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	for slot4, slot5 in ipairs(slot0.params_.affixList) do
		slot0.itemView_[slot4] = slot0.itemView_[slot4] or AffixBoxItem.New(slot0.item_, slot0.itemParent_)

		slot0.itemView_[slot4]:SetData(slot5)
	end

	for slot4 = #slot0.params_.affixList + 1, #slot0.itemView_ do
		slot0.itemView_[slot4]:SetActive(false)
	end

	slot0.listScrollRect_.verticalNormalizedPosition = 1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	for slot4, slot5 in pairs(slot0.itemView_) do
		slot5:Dispose()
	end

	slot0.itemView_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.backBtn_ = slot0:FindCom(typeof(Button), "mask")
	slot0.item_ = slot0:FindGo("panel/bg/affixList/Viewport/Content/Item")
	slot0.itemParent_ = slot0:FindGo("panel/bg/affixList/Viewport/Content")
	slot0.listScrollRect_ = slot0:FindCom(typeof(ScrollRect), "panel/bg/affixList")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.backBtn_.onClick:RemoveAllListeners()
end

return slot0
