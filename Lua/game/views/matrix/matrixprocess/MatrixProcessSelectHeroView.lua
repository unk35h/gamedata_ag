slot0 = class("MatrixProcessSelectHeroView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/Process/MatrixProcessSelectHeroUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, MatrixProcessSelectHeroItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_okBtn, nil, function ()
		if uv0.selectHeroId == 0 then
			ShowTips(GetTips("MATRIX_SELECT_HERO_PLZ"))

			return
		end

		uv0:Back()
		uv0:OnRewardAction()
	end)
	slot0:AddBtnListener(slot0.m_cancelBtn, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.id = slot0.params_.id

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot4 = {}

	if MatrixItemCfg[slot0.id].matrix_item_type == MatrixConst.ITEM_TYPE.EQUIP then
		for slot9, slot10 in pairs(slot0:GetMatrixHeroTeam()) do
			table.insert(slot4, {
				heroId = slot10,
				canSelect = not table.indexof(slot0:GetHeroData(slot10):GetEquipList(), slot1)
			})
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == slot3 then
		for slot9, slot10 in pairs(slot0:GetMatrixHeroTeam()) do
			slot12 = slot0:GetHeroData(slot10):GetWeaponServant()
			slot15 = false

			if HeroCfg[slot10].race == WeaponServantCfg[slot2.params[1]].race and (slot12 == 0 or MatrixTools.GetWeaponSpecHero(MatrixItemCfg[slot12].params[1]) == 0) then
				slot15 = true
			end

			table.insert(slot4, {
				heroId = slot10,
				canSelect = slot15
			})
		end
	end

	slot0.selectHeroId = 0
	slot0.selectableList = slot4

	slot0.list_:StartScroll(#slot0.selectableList)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.selectableList[slot1]
	slot4 = slot3.heroId

	slot2:Refresh(slot4, slot3.canSelect)
	slot2:SetSelected(slot0.selectHeroId == slot4)
	slot2:RegistCallBack(handler(slot0, slot0.OnItemClick))
end

function slot0.OnItemClick(slot0, slot1)
	if slot1 ~= slot0.selectHeroId then
		slot0.selectHeroId = slot1

		for slot6, slot7 in pairs(slot0.list_:GetItemList()) do
			slot7:SetSelected(slot7:GetHeroId() == slot0.selectHeroId)
		end
	end
end

function slot0.OnRewardAction(slot0)
	slot2 = slot0.selectHeroId

	if not (slot0.id and MatrixItemCfg[slot1] or nil) then
		return
	end

	if MatrixConst.ITEM_TYPE.EQUIP == slot3.matrix_item_type then
		if slot0:GetHeroEquipMaxCount() <= #slot0:GetHeroData(slot2):GetEquipList() then
			JumpTools.OpenPageByJump("matrixProcessEquipReplace", {
				heroId = slot2,
				equipId = slot1,
				callback = function (slot0)
					MatrixAction.QueryNextProgress({
						uv0,
						slot0,
						uv1:GetStandardId()
					})
				end
			})
		else
			MatrixAction.QueryNextProgress({
				slot1,
				0,
				slot5:GetStandardId()
			})
		end

		return
	end

	if MatrixConst.ITEM_TYPE.WEAPON_SERVANT == slot4 then
		if slot0:GetHeroData(slot2):GetWeaponServant() ~= 0 then
			JumpTools.OpenPageByJump("matrixProcessWeaponReplace", {
				heroId = slot2,
				weaponId = slot1,
				callback = function ()
					MatrixAction.QueryNextProgress({
						uv0,
						uv1,
						uv2:GetStandardId()
					})
				end
			})
		else
			MatrixAction.QueryNextProgress({
				slot1,
				0,
				slot5:GetStandardId()
			})
		end
	else
		MatrixAction.QueryNextProgress({
			slot1,
			0,
			slot0:GetHeroData(slot2):GetStandardId()
		})
	end
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

function slot0.GetMatrixHeroTeam(slot0)
	return MatrixData:GetMatrixHeroTeam()
end

function slot0.GetHeroEquipMaxCount(slot0)
	return MatrixData:GetHeroEquipMaxCount()
end

return slot0
