slot0 = class("EquipBreakThroughtMaterialModeItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "chooseItem")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.chooseHandler_ = handler(slot0, slot0.ChooseMode)

	manager.notify:RegistListener(CHALLENGE_CHOOSE_MODE, slot0.chooseHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(CHALLENGE_CHOOSE_MODE, slot0.chooseHandler_)

	slot0.chooseHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if table.keyof(EquipBreakThroughMaterialData:GetOpenModeList(), uv0.index_) == nil then
			ShowTips(string.format(GetTips("EQUIP_BREAK_THROUGH_MODE_UNLOCK"), EquipBreakThroughMaterialDifficultyCfg[EquipBreakThroughMaterialDifficultyCfg[slot1].unlock_condition[2]].name))

			return
		end

		manager.notify:Invoke(CHALLENGE_CHOOSE_MODE, uv0.index_)
	end)
end

function slot0.ChooseMode(slot0, slot1)
	if slot0.index_ == slot1 then
		slot0.selectController_:SetSelectedState("on")
	else
		slot0.selectController_:SetSelectedState("off")
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot3 = slot1

	SetSpriteWithoutAtlasAsync(slot0.bgImage_, SpritePathCfg.ChapterPaint.path .. EquipBreakThroughMaterialDifficultyCfg[slot3].bg)

	if table.keyof(EquipBreakThroughMaterialData:GetOpenModeList(), slot3) then
		slot0.lockController_:SetSelectedState("off")
	else
		slot0.lockController_:SetSelectedState("on")
	end

	slot0.difficultyImage_.sprite = getSprite("Atlas/Switch", string.format("bg_n%s", slot1))

	slot0:ChooseMode(slot2)
end

return slot0
