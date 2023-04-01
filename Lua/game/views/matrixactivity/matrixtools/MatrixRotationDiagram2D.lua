slot0 = class("MatrixRotationDiagram2D", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.particle = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemSize = Vector2.New(650, 700)
	slot0.itemOffset = 350
	slot0.itemCount = 6

	slot0:CalulateDataStatic()
	slot0:CreatItem()
end

function slot0.SetData(slot0, slot1)
	slot0:Change(slot1, true)
end

function slot0.CreatItem(slot0)
	slot0.itemList = {}

	for slot4 = 1, slot0.itemCount do
		slot5 = MatrixRotationDiagramItem.New(slot0.m_ratationItem, slot0.m_ratationContent)

		slot5:SetData(slot4)
		table.insert(slot0.itemList, slot5)
	end
end

function slot0.Change(slot0, slot1, slot2)
	slot3 = #slot0.itemList

	for slot7, slot8 in ipairs(slot0.itemList) do
		slot8:SetPosId((slot8:GetIndex() - slot1 + slot3) % slot3 + 1)
	end

	function slot7(slot0, slot1)
		return uv0.itemPosList[slot0:GetPosId()].order < uv0.itemPosList[slot1:GetPosId()].order
	end

	table.sort(slot0.itemList, slot7)

	for slot7, slot8 in ipairs(slot0.itemList) do
		slot10 = slot0.itemPosList[slot8:GetPosId()]

		if slot2 then
			SetActive(slot0.particle, true)
			slot8:InitPosData(slot10)
		else
			SetActive(slot0.particle, false)
			TimeTools.StartAfterSeconds(0.5, function ()
				if uv0.particle then
					SetActive(uv0.particle, true)
				end
			end, {})
			slot8:SetPosData(slot10)
		end
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.CalulateDataStatic(slot0)
	slot0.itemPosList = {
		{
			scale = 1,
			order = 6,
			pos = Vector3.New(0, -100, 0),
			color = Color.New(1, 1, 1)
		},
		{
			scale = 0.7,
			order = 5,
			pos = Vector3.New(500, -30, 0),
			color = Color.New(0.3325, 0.3613, 0.4433)
		},
		{
			scale = 0.53,
			order = 3,
			pos = Vector3.New(325, 40, 0),
			color = Color.New(0.2448, 0.2448, 0.3962)
		},
		{
			scale = 0.375,
			order = 1,
			pos = Vector3.New(0, 100, 0),
			color = Color.New(0.2314, 0.2314, 0.3207)
		},
		{
			scale = 0.53,
			order = 2,
			pos = Vector3.New(-325, 40, 0),
			color = Color.New(0.2448, 0.2448, 0.3962)
		},
		{
			scale = 0.7,
			order = 4,
			pos = Vector3.New(-500, -30, 0),
			color = Color.New(0.3325, 0.3613, 0.4433)
		}
	}
end

return slot0
