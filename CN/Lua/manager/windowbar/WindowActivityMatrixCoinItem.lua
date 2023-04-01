slot0 = class("WindowActivityMatrixCoinItem", import("game.extend.ReduxView"))

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.currencyType_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
	slot0:RefreshUI()

	slot0.isCanAdd_ = true
	slot0.isCanClick_ = false
	slot0.type_ = "black"
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeSet_ = {
		"black",
		"hyaline"
	}
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(nil, , "OnClick")
	slot0:AddBtnListener(slot0.buttonIcon_, nil, function ()
		manager.notify:Invoke(WINDOW_BAR_INFO, uv0.currencyType_, uv0.gameObject_)
		uv0:OnClick()
	end)
end

function slot0.OnClick(slot0)
	if slot0.materialType_ then
		ShowPopItem(POP_SOURCE_ITEM, {
			slot0.materialType_
		})
	end
end

function slot0.SetCanAdd(slot0, slot1)
	if slot0.isCanAdd_ == slot1 then
		return
	end

	slot0.isCanAdd_ = slot1

	SetActive(slot0.add_, slot1)
end

function slot0.SetCanClick(slot0, slot1)
	slot0.isCanClick_ = slot1
end

function slot0.SetType(slot0, slot1)
	if table.indexof(slot0.typeSet_, slot1) then
		slot0.type_ = slot1

		slot0.typeCon_:SetSelectedState(slot0.type_)
	end
end

function slot0.RefreshUI(slot0)
	slot0.materialType_ = nil

	if slot0.activity_id and ActivityCfg[slot0.activity_id] then
		if ActivityTools.GetActivityType(slot0.activity_id) == ActivityTemplateConst.SUB_SINGLE_MATRIX then
			slot2 = ActivityMatrixTools.GetCoinItem(slot0.activity_id)
			slot0.icon_.sprite = ItemTools.getItemLittleSprite(slot2)
			slot0.text_.text = ActivityMatrixData:GetMatrixCoint(slot0.activity_id)
			slot0.materialType_ = slot2

			return
		elseif slot1 == ActivityTemplateConst.STRATEGY_MATRIX then
			slot2 = StrategyMatrixTools.GetCoinItem(slot0.activity_id)
			slot0.icon_.sprite = ItemTools.getItemLittleSprite(slot2)
			slot0.text_.text = StrategyMatrixData:GetMatrixCoint(slot0.activity_id)
			slot0.materialType_ = slot2

			return
		end
	end

	slot0.icon_.sprite = nil
	slot0.text_.text = ""
end

function slot0.SetActivityId(slot0, slot1)
	slot0.activity_id = slot1

	slot0:RefreshUI()
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0:RegistEventListener(ACTIVITY_MATRIX_PROCESS_CHANGE, handler(slot0, slot0.RefreshUI))
		slot0:RefreshUI()
		slot0.transform_:SetAsLastSibling()
	else
		slot0:RemoveAllEventListener()
	end
end

function slot0.UnBindListener(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
