slot0 = class("WindowMaterialItem", import("game.extend.ReduxView"))

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.materialType_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:InitUI()
	slot0:AddListeners()

	slot0.typeSet_ = {
		"black",
		"hyaline"
	}

	slot0:RefreshText()
	slot0:InitIcon()

	slot0.isCanAdd_ = true
	slot0.isCanClick_ = false
	slot0.type_ = "black"

	slot0:AddBtnListener(nil, , "OnClick")
	slot0:RegistEventListener(MATERIAL_MODIFY, handler(slot0, slot0.UpdateMaterial))

	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.UpdateMaterial(slot0, slot1)
	if slot1 == slot0.materialType_ then
		slot0:RefreshText()
	end
end

function slot0.OnClick(slot0)
	if slot0.isCanAdd_ or slot0.isCanClick_ then
		OperationRecorder.Record(gameContext:GetLastOpenPage() .. "_" .. slot0.class.__cname, string.format("%d", slot0.materialType_))
		ShowPopItem(POP_SOURCE_ITEM, {
			slot0.materialType_
		})
	end
end

function slot0.CloseOther(slot0)
	slot2 = false

	for slot6, slot7 in ipairs(gameContext:GetAllOpenRoute()) do
		if slot7 == "currencyBuyGold" or slot7 == "diamondExchange" or slot7 == "currencyBuyFatigue" then
			slot2 = true
		end
	end

	if slot2 then
		JumpTools.Back()
	end
end

function slot0.UnBindListener(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	slot0:RemoveAllListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.text_ = slot0:FindCom(typeof(Text), "Text")
	slot0.icon_ = slot0:FindCom(typeof(Image), "icon")
	slot0.add_ = slot0:FindGo("image")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonIcon_, nil, function ()
		manager.notify:Invoke(WINDOW_BAR_INFO, uv0.materialType_, uv0.gameObject_)
	end)
end

function slot0.RemoveListeners(slot0)
end

function slot0.SetCanAdd(slot0, slot1)
	if slot0.isCanAdd_ == slot1 then
		return
	end

	slot0.isCanAdd_ = slot1

	SetActive(slot0.add_, slot1)
end

function slot0.SetType(slot0, slot1)
	if table.indexof(slot0.typeSet_, slot1) then
		slot0.type_ = slot1

		slot0.typeCon_:SetSelectedState(slot0.type_)
	end
end

function slot0.SetCanClick(slot0, slot1)
	slot0.isCanClick_ = slot1
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0:RegistEventListener(MATERIAL_MODIFY, handler(slot0, slot0.UpdateMaterial))
		slot0:RefreshText()
		slot0.transform_:SetAsLastSibling()
	end
end

function slot0.RefreshText(slot0)
	slot0.text_.text = NumberTools.RetractNumberForWindBar(slot0:GetCnt())
end

function slot0.InitIcon(slot0)
	slot0.icon_.sprite = ItemTools.getItemLittleSprite(slot0.materialType_)
end

function slot0.GetCnt(slot0)
	if slot0.materialType_ == CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A then
		return CommunityData:GetCurrenyA()
	end

	if MaterialData:GetMaterialList()[slot1] then
		return slot2.num
	end

	return 0
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
