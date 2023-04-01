slot0 = class("HeroEquipInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.heroInfo_ = slot2
	slot0.extra_ = slot3
	slot0.isForeign_ = slot3 and slot3.isForeign
	slot0.isTemp_ = slot3 and slot3.isTemp
	slot0.isPolyhedron_ = slot3 and slot3.isPolyhedron

	slot0:RefreshUI()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemSGo_ = {}
	slot0.itemS_ = {}

	for slot4 = 1, 6 do
		slot0.itemSGo_[slot4] = slot0[string.format("item%dGo_", slot4)]
		slot0.itemS_[slot4] = HeroEquipItem.New(slot0, slot0.itemSGo_[slot4])
	end
end

function slot0.IgnoreAdd(slot0)
	for slot4 = 1, 6 do
		slot0.itemS_[slot4]:IgnoreAdd()
	end
end

function slot0.AddUIListener(slot0)
	if slot0.changeBtn_ then
		slot0:AddBtnListener(slot0.changeBtn_, nil, function ()
			uv0:Go("/heroEquipBag", {
				isClearPos = true,
				suitPos = 0,
				isOpenInfo = true,
				heroId = uv0.heroInfo_.id
			})
		end)
	end
end

function slot0.RefreshUI(slot0, slot1)
	if not slot1 then
		slot0.equipInfo_ = slot0.heroInfo_.equip
	else
		slot0.equipInfo_ = slot1
	end

	if slot0.changeBtn_ then
		SetActive(slot0.changeBtn_.gameObject, not slot0.extra_)
	end

	for slot5, slot6 in ipairs(slot0.equipInfo_) do
		slot7 = slot6.equip_id

		if slot0.extra_ then
			if slot0.isForeign_ then
				if slot7 ~= 0 then
					slot0.itemS_[slot5]:RefreshData(slot0, ForeignInfoData:GetEquipInfo(slot0.heroInfo_.id, slot5))
				else
					slot0.itemS_[slot5]:RefreshData(slot0, {
						equip_id = 0,
						pos = slot5
					})
				end
			elseif slot0.isTemp_ then
				if slot7 ~= 0 then
					slot0.itemS_[slot5]:RefreshData(slot0, TempHeroData:GetEquipInfo(slot0.extra_.tempHeroList, slot0.heroInfo_.id, slot5))
				else
					slot0.itemS_[slot5]:RefreshData(slot0, {
						equip_id = 0,
						pos = slot5
					})
				end
			elseif slot0.isPolyhedron_ then
				if slot7 ~= 0 then
					slot0.itemS_[slot5]:RefreshData(slot0, EquipTools.GetConstructVirtualEquips(PolyhedronHeroCfg[slot0.heroInfo_.id].standard_id)[slot5])
				else
					slot0.itemS_[slot5]:RefreshData(slot0, {
						equip_id = 0,
						pos = slot5
					})
				end
			end
		elseif slot7 ~= 0 then
			slot0.itemS_[slot5]:RefreshData(slot0, EquipData:GetEquipData(slot7))
		else
			slot0.itemS_[slot5]:RefreshData(slot0, {
				equip_id = 0,
				pos = slot5
			})
		end
	end
end

function slot0.RefreshItem(slot0, slot1)
	slot0.equipInfo_ = slot0.heroInfo_.equip

	if slot0.equipInfo_[slot1].equip_id and slot3 ~= 0 then
		slot0.itemS_[slot1]:RefreshData(slot0, EquipData:GetEquipData(slot3))
	else
		slot0.itemS_[slot1]:RefreshData(slot0, {
			equip_id = 0,
			pos = slot1
		})
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.HideSelect(slot0)
	for slot4, slot5 in ipairs(slot0.itemS_) do
		slot5:ShowSelect(false)
	end
end

function slot0.GetItem(slot0, slot1)
	return slot0.itemS_[slot1]
end

function slot0.RegistCallBack(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.itemS_) do
		slot6:RegistCallBack(slot1)
	end
end

function slot0.Dispose(slot0)
	if slot0.itemS_ then
		for slot4, slot5 in ipairs(slot0.itemS_) do
			slot5:Dispose()
		end
	end

	slot0.itemSGo_ = nil
	slot0.itemS_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
