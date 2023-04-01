slot0 = class("CurrencyBuyFatigueMaterialItem", ReduxView)

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

	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.commonItem_

	slot1:RegistCallBack(function (slot0)
		if uv0:GetNumber() <= 0 then
			return
		end

		uv0.toggle_.isOn = true
	end)
end

function slot0.SetMaterialId(slot0, slot1)
	slot0.matId_ = slot1

	slot0:UpdateView()
end

function slot0.GetMaterialId(slot0)
	return slot0.matId_
end

function slot0.UpdateView(slot0)
	slot1 = slot0:GetNumber()

	slot0.commonItem_:RefreshData({
		id = slot0.matId_,
		number = slot1
	})
	slot0.commonItem_:SetSelectType("equip")

	if slot1 > 0 then
		slot0.toggle_.enabled = true
	else
		slot0.toggle_.enabled = false
		slot0.toggle_.isOn = false
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.GetNumber(slot0)
	slot1 = 0

	if MaterialData:GetMaterialList()[slot0.matId_] then
		slot1 = MaterialData:GetMaterialList()[slot0.matId_].num
	end

	return slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
