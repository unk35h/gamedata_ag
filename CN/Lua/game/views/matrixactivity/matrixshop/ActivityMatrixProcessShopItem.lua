slot0 = class("ActivityMatrixProcessShopItem", MatrixProcessShopItem)

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItem = ActivityMatrixProcessRewardItem.New(slot0.m_reward)
	slot0.discountController = ControllerUtil.GetController(slot0.transform_, "discount")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_priceBtn, nil, function ()
		if ActivityMatrixData:GetMatrixCoint(uv0.matrix_activity_id) < uv0.priceNum then
			ShowTips("LACK_CURRENCY")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_SHOP_BUY_CONFIRM"),
			OkCallback = function ()
				uv0:OnRewardAction()
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.SetMatrixActivityId(slot0, slot1)
	slot0.rewardItem:SetMatrixActivityId(slot1)

	slot0.matrix_activity_id = slot1
end

function slot0.OnRewardAction(slot0)
	if not MatrixItemCfg[slot0.id] then
		print("MatrixItemCfg cant find item by id :" .. slot1)

		return
	end

	if MatrixConst.ITEM_TYPE.ASTROLABE == slot2.matrix_item_type then
		slot5 = slot0:GetHeroData(math.floor(slot2.params[1] / 1000))
		slot6 = slot5:GetAstrolabeList()

		if slot5:GetAstrolabeNum(slot2.params[1]) >= 3 then
			ShowTips(GetTips("MATRIX_NOT_GET_ASTROLABEL"))

			return
		end

		if slot0:GetAstrolabeMaxCount() <= #slot6 then
			JumpTools.OpenPageByJump("activityMatrixProcessAstrolabeReplace", {
				matrix_activity_id = slot0.matrix_activity_id,
				heroId = slot4,
				astrolabeId = slot1,
				callback = function (slot0)
					ActivityMatrixAction.BuyShopItem(uv0.matrix_activity_id, uv0.shopIndex, uv1:GetStandardId(), slot0)
				end
			})
		else
			ActivityMatrixAction.BuyShopItem(slot0.matrix_activity_id, slot0.shopIndex, slot5:GetStandardId(), 0)
		end

		return
	end

	if MatrixConst.ITEM_TYPE.EQUIP == slot3 then
		JumpTools.OpenPageByJump("activityMatrixProcessShopSelectHero", {
			matrix_activity_id = slot0.matrix_activity_id,
			index = slot0.shopIndex,
			id = slot1
		})
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == slot3 then
		if MatrixTools.GetWeaponSpecHero(slot2.params[1]) == 0 then
			JumpTools.OpenPageByJump("activityMatrixProcessShopSelectHero", {
				matrix_activity_id = slot0.matrix_activity_id,
				index = slot0.shopIndex,
				id = slot1
			})
		elseif slot0:GetHeroData(slot4):GetWeaponServant() ~= 0 then
			JumpTools.OpenPageByJump("activityMatrixProcessWeaponReplace", {
				matrix_activity_id = slot0.matrix_activity_id,
				heroId = slot4,
				weaponId = slot1,
				callback = function ()
					ActivityMatrixAction.BuyShopItem(uv0.matrix_activity_id, uv0.shopIndex, uv1:GetStandardId(), uv2)
				end
			})
		else
			ActivityMatrixAction.BuyShopItem(slot0.matrix_activity_id, slot0.shopIndex, slot5:GetStandardId(), 0)
		end
	else
		ActivityMatrixAction.BuyShopItem(slot0.matrix_activity_id, slot0.shopIndex, 0, 0)
	end
end

function slot0.GetHeroData(slot0, slot1)
	return ActivityMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

function slot0.GetAstrolabeMaxCount(slot0)
	return ActivityMatrixData:GetAstrolabeMaxCount(slot0.matrix_activity_id)
end

function slot0.GetSwitchItemIcon(slot0, slot1)
	if slot1 == 26 then
		return ActivityMatrixTools.GetCoinItem(slot0.matrix_activity_id)
	end

	return slot1
end

return slot0
