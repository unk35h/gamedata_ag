slot0 = class("NewHeroTransitionItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.index_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.chipCon_ = ControllerUtil.GetController(slot0.number_, "chip")
	slot0.selectCon_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_(uv0.isEffect_)
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.chipCon_:SetSelectedState((slot2 and "on" or "off") .. #slot1)

	slot0.isEffect_ = slot2

	for slot8 = 1, slot3 do
		slot0["affix_" .. slot8].sprite = getEquipSkillSprite(slot1[slot8].skill_id)
	end
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectCon_:SetSelectedState(slot1 == slot0.index_ and "Select" or "notSelect")
end

function slot0.RegistClickFunc(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
