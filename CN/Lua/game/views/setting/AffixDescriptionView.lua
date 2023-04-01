slot0 = class("AffixDescriptionView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.transform_ = slot2.transform
	slot0.gameObject_ = slot2
	slot0.data = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:OnEnter()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = slot0.listGo_:GetComponent("UIList")

	slot0.uiList_:SetItemRenderer(handler(slot0, slot0.ItemRenderer))
	slot0.uiList_:SetItemRecycleHandler(handler(slot0, slot0.ItemRecycleHandler))
	slot0.uiList_:SetNumItems(table.length(slot0.data))
end

function slot0.ItemRenderer(slot0, slot1, slot2)
	slot2:GetComponent("UIList")

	slot2.transform:Find("icon"):GetComponent("Image").sprite = getAffixSprite(slot0.data[slot1 + 1])
	slot2.transform:Find("name"):GetComponent("Text").text = getAffixName(slot0.data[slot1 + 1])
	slot2.transform:Find("text"):GetComponent("Text").text = getAffixDesc(slot0.data[slot1 + 1])
end

function slot0.ItemRecycleHandler(slot0, slot1, slot2)
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.uiList_ then
		slot0.uiList_:RecycleAllItems()
		slot0.uiList_:SetItemRenderer(nil)
		slot0.uiList_:SetItemRecycleHandler(nil)
	end

	slot0.hander_ = nil
	slot0.data = nil
end

return slot0
