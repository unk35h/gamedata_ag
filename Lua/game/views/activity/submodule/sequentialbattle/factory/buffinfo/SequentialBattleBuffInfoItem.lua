slot0 = class("SequentialBattleBuffInfoItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.enabledController_ = ControllerUtil.GetController(slot0.transform_, "equiped")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		manager.notify:Invoke(SEQUENTIAL_BATTLE_BUFF, uv0.buffID_)
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.buffID_ = slot1

	if slot2 then
		slot0.enabledController_:SetSelectedState("on")
	else
		slot0.enabledController_:SetSelectedState("off")
	end

	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/BuffIcon/maedukAffix/" .. PublicBuffCfg[AffixTypeCfg[SequentialBattleBuffCfg[slot1].affix_id].affix_buff_id].icon)
end

function slot0.RefreshSelect(slot0, slot1)
	if slot0.buffID_ == slot1 then
		slot0.selectController_:SetSelectedState("on")
	else
		slot0.selectController_:SetSelectedState("off")
	end
end

return slot0
