slot0 = class("SkinExchangeCostItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		ShowPopItem(POP_SOURCE_ITEM, {
			uv0.id_
		})
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.info_ = slot1
	slot0.id_ = slot0.info_[1]
	slot0.need_ = slot0.info_[2]
	slot0.icon_.sprite = ItemTools.getItemLittleSprite(slot0.id_)
	slot0.text_.text = CurrencyData:GetCurrencyByID(slot0.id_).num .. "/" .. slot0.need_
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
end

return slot0
