slot0 = class("WeaponModuleConditionItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
	slot0:AddUIListener()
end

function slot0.Init(slot0)
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "condition")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.jumpBtn_, nil, function ()
		JumpTools.JumpToPage(uv0.source_)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.desText_.text = ConditionCfg[slot1].desc

	if IsConditionAchieved(slot1, {
		heroId = slot2
	}) then
		slot0.controller_:SetSelectedState("clear")
		SetActive(slot0.jumpBtn_.gameObject, false)
	else
		slot0.controller_:SetSelectedState("notClear")

		if slot3 and slot3[1] then
			slot0.source_ = slot3

			SetActive(slot0.jumpBtn_.gameObject, true)
		else
			SetActive(slot0.jumpBtn_.gameObject, false)
		end
	end
end

function slot0.SetIsShow(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
