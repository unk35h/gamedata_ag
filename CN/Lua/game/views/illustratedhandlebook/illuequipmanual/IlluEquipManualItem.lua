slot0 = class("IlluEquipManualItem", ReduxView)

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

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "lock")
end

function slot0.RefreshUI(slot0, slot1)
	slot0.id_ = slot1.id
	slot0.nameText_.text = EquipSuitCfg[slot0.id_].name
	slot0.iconImg_.sprite = getSpriteViaConfig("EquipIcon", EquipSuitCfg[slot0.id_].icon)
	slot0.shadowImg_.sprite = getSpriteViaConfig("EquipIcon", EquipSuitCfg[slot0.id_].icon)
	slot0.have_ = IllustratedData:GetEquipInfo()[slot0.id_]

	if slot0.have_ then
		slot0.controller_:SetSelectedState("true")

		slot0.numText_.text = IlluTools.GetEquipHaveNum(slot0.id_) .. "/6"
		slot0.view_ = IllustratedData:GetIsView(slot0.id_, 4)

		manager.redPoint:SetRedPointIndependent(slot0.transform_, slot0.view_ == 0)
	else
		slot0.controller_:SetSelectedState("false")

		slot0.numText_.text = "0/6"

		manager.redPoint:SetRedPointIndependent(slot0.transform_, false)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		if uv0.have_ and uv0.view_ == 0 then
			IllustratedAction.ViewIllustration(uv0.id_, CollectConst.EQUIP)
		end

		uv0:Go("/equipArchive", {
			equipID = uv0.id_
		})
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
