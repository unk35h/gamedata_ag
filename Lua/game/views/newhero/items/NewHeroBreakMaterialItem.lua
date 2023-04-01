slot0 = class("NewHeroBreakMaterialItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.enoughController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "enough")
	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.commonItem_

	slot1:RegistCallBack(function (slot0)
		ShowPopItem(POP_SOURCE_ITEM, {
			uv0.materialId_,
			uv0.count_
		})
	end)
end

function slot0.SetInfo(slot0, slot1, slot2)
	slot0.materialId_ = slot1
	slot0.count_ = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.commonItem_:RefreshData({
		id = slot0.materialId_,
		number = slot0.count_
	})

	slot1 = 0

	if MaterialData:GetMaterialList()[slot0.materialId_] then
		slot1 = MaterialData:GetMaterialList()[slot0.materialId_].num
	end

	slot2 = nil

	slot0.commonItem_:SetBottomText(((slot1 >= slot0.count_ or string.format("<color=#FF0000>%d</color>", slot1)) and tostring(slot1)) .. "/" .. slot0.count_)
end

function slot0.IsEnough(slot0)
	slot1 = 0

	if MaterialData:GetMaterialList()[slot0.materialId_] then
		slot1 = MaterialData:GetMaterialList()[slot0.materialId_].num
	end

	return slot0.count_ <= slot1
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.GetMaterialId(slot0)
	return slot0.materialId_
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
