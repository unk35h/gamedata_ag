slot0 = class("PolyhedronSetTerminalGroup", ReduxView)

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

	slot0.itemList = {}
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot6 = slot1
	slot0.m_title.text = PolyhedronTools.GetPolyhedronTerminalClassifyDes(slot6)
	slot0.group = slot2

	for slot6, slot7 in ipairs(slot0.group) do
		if not slot0.itemList[slot6] then
			table.insert(slot0.itemList, PolyhedronSetTerminalItem.New(Object.Instantiate(slot0.m_item, slot0.m_content)))
		end

		slot0.itemList[slot6]:SetActive(true)
		slot0.itemList[slot6]:SetData(slot7)
	end

	for slot7 = #slot0.group + 1, #slot0.itemList do
		slot0.itemList[slot7]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5:Dispose()
	end

	slot0.itemList = nil

	uv0.super.Dispose(slot0)
end

function slot0.RegistCallBack(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.itemList) do
		slot6:RegistCallBack(slot1)
	end
end

return slot0
