slot0 = class("MatrixAffixGroup", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.GetContainer(slot0)
	return slot0.transform_
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.items = {}
end

function slot0.Refresh(slot0, slot1, slot2, slot3)
	slot0.id = slot1.id
	slot0.list = slot1.list
	slot0.m_name.text = getAffixName({
		slot0.id
	})

	for slot8 = 1, #slot0.list do
		if not slot0.items[slot8] then
			slot0.items[slot8] = MatrixSelectAffixItem.New(Object.Instantiate(slot0.m_item, slot0.m_content))
		end

		slot10 = 0

		slot0.items[slot8]:Refresh(slot9, table.indexof(slot2, slot0.list[slot8]) and 2 or table.indexof(slot3, slot9) and 1 or 0)
	end

	while #slot0.items > #slot0.list do
		slot5 = slot0.items[#slot0.items]

		SetActive(slot5.gameObject_, false)
		slot5:Dispose()
		table.remove(slot0.items, #slot0.items)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

function slot0.RegistCallBack(slot0, slot1)
	for slot5, slot6 in pairs(slot0.items) do
		slot6:RegistCallBack(slot1)
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.items then
		for slot4, slot5 in ipairs(slot0.items) do
			slot5:Dispose()
		end

		slot0.items = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
