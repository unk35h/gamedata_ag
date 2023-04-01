slot0 = class("ItemBuyView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/ItemExchangeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.itemCon_ = ControllerUtil.GetController(slot0.transform_, "itemNum")
	slot0.textCon_ = ControllerUtil.GetController(slot0.transform_, "text")
end

function slot0.OnEnter(slot0)
	slot0.selectNum_ = 1

	if slot0.params_.item3.id then
		slot0.itemCon_:SetSelectedState("2")
	else
		slot0.itemCon_:SetSelectedState("1")
	end

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if uv0.params_.OkCallback then
			uv0.params_.OkCallback()
		end
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RefreshUI(slot0)
	slot0.item1nameText_.text = ItemCfg[slot0.params_.item1.id].name
	slot0.item1iconImg_.sprite = ItemTools.getItemLittleSprite(slot0.params_.item1.id)
	slot0.item1numText_.text = slot0.params_.item1.num
	slot0.item2nameText_.text = ItemCfg[slot0.params_.item2.id].name
	slot0.item2iconImg_.sprite = ItemTools.getItemLittleSprite(slot0.params_.item2.id)
	slot0.item2numText_.text = slot0.params_.item2.num

	if slot0.params_.item3.id then
		slot0.item3nameText_.text = ItemCfg[slot0.params_.item3.id].name
		slot0.item3iconImg_.sprite = ItemTools.getItemLittleSprite(slot0.params_.item3.id)
		slot0.item3numText_.text = slot0.params_.item3.num
		slot0.textText_.text = System.String.Format(GetTips("RECHARGE_DIAMOND_AND_DIAMOND_EXCHANGE_DRAWCARD"), tonumber(slot0.params_.item3.num), tonumber(slot0.params_.item2.num), tonumber(slot0.params_.item1.num), GetI18NText(ItemCfg[slot0.params_.item1.id].name))
	else
		slot0.textText_.text = System.String.Format(GetTips("RECHARGE_DIAMOND_OR_DIAMOND_EXCHANGE_DRAWCARD"), tonumber(slot0.params_.item2.num), GetI18NText(ItemCfg[slot0.params_.item2.id].name), tonumber(slot0.params_.item1.num), GetI18NText(ItemCfg[slot0.params_.item1.id].name))
	end
end

return slot0
