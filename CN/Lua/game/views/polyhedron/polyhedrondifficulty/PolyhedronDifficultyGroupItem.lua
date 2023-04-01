slot0 = class("polyhedronDifficultyGroupItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.id = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemList = {}

	for slot5, slot6 in ipairs(PolyhedronDifficultyCfg[slot0.id].params) do
		slot7 = Object.Instantiate(slot0.m_item, slot0.m_content)

		SetActive(slot7, true)
		table.insert(slot0.itemList, PolyhedronDifficultyItem.New(slot7, slot6))
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content)

	slot0.transform_.sizeDelta = Vector2.New(slot0.transform_.rect.width, slot0.m_content.rect.height + 50)
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.m_lvLab.text = slot0.id
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.id)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	if slot1 < PolyhedronDifficultyCfg[slot0.id].unlock_difficulty then
		slot0.stateController:SetSelectedIndex(1)
	elseif slot0.id <= slot2 then
		slot0.stateController:SetSelectedIndex(2)
	else
		slot0.stateController:SetSelectedIndex(0)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5:Dispose()
	end

	slot0.itemList = {}

	uv0.super.Dispose(slot0)
end

return slot0
