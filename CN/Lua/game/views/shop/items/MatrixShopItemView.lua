slot0 = class("MatrixShopItemView", ReduxView)

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

	slot0.qualityController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "quality")
	slot0.starController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "star")
	slot0.canvasGroup_ = slot0.nonullGo_:GetComponent(typeof(CanvasGroup))
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, , "OnClick")
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.terminalId_)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.SetData(slot0, slot1)
	slot0.terminalId_ = slot1
	slot0.matrixItem_ = MatrixItemCfg[slot1]
	slot0.terminalCfg_ = MatrixTerminalCfg[slot1]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameText_.text = string.format("%s x%d", GetI18NText(slot0.terminalCfg_.name), 1)

	slot0.icon_:SetNativeSize()
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.GetHave(slot0)
	if ItemCfg[getShopCfg(slot0.data_.id).cost_id].type == ItemConst.ITEM_TYPE.CURRENCY then
		return CurrencyData:GetCurrencyNum(slot1.cost_id)
	elseif (slot2.type == ItemConst.ITEM_TYPE.MATERIAL or slot2.type == ItemConst.ITEM_TYPE.PROPS) and MaterialData:GetMaterialList()[slot1.cost_id] then
		return slot3.num
	end

	return 0
end

function slot0.GetItemInfo(slot0)
	return slot0.data_
end

function slot0.Dispose(slot0)
	slot0.clickFunc = nil

	uv0.super.Dispose(slot0)
end

return slot0
