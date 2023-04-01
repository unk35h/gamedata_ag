slot0 = class("PolyhedronShopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PolyhedronBattle/PolyhedronShopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.shopList = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_shopList, PolyhedronShopItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_refreshBtn, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					uv0.coinId,
					uv0.refreshCost
				},
				GetTips("MATRIX_SHOP_REFRESH")
			},
			OkCallback = function ()
				PolyhedronAction.QueryRefreshShop()
			end
		})
	end)
	slot0:AddBtnListener(slot0.m_addBloodBtn, nil, function ()
		PolyhedronAction.QueryShopBloodReturn()
	end)
	slot0:AddBtnListener(slot0.m_back, nil, function ()
		gameContext:Go("/polyhedronBlank/polyhedronBattle")
	end)
end

function slot0.OnTop(slot0)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.RefreshUI(slot0, slot1)
	slot2 = PolyhedronData:GetPolyhedronInfo()
	slot0.polyhedronInfo = slot2
	slot0.shops = slot2:GetShopItemList()

	if slot1 then
		slot0.shopList:StartScrollByPosition(#slot0.shops, slot1)
	else
		slot0.shopList:StartScroll(#slot0.shops)
	end

	slot0.refreshCount = slot2:GetShopRefreshTimes()
	slot4 = slot2:GetShopFressRefreshTimes()
	slot0.coinId = slot2:GetPolyhedronCoinId()

	if slot0.refreshCount < slot2:GetShopMaxRefreshTimes() then
		SetActive(slot0.m_refreshContent, true)

		slot0.refreshCost = 0
		slot0.m_refreshCount.text = string.format("%d/%d", slot0.refreshCount, slot3)

		if slot4 <= slot0.refreshCount then
			slot0.refreshCost = slot2:GetShopRefreshCost(slot0.refreshCount - slot4 + 1)
		else
			slot0.refreshCost = 0
		end

		slot0.m_refreshIcon.sprite = ItemTools.getItemLittleSprite(slot0.coinId)
		slot0.m_refreshCost.text = slot0.refreshCost
	else
		SetActive(slot0.m_refreshContent, false)
	end

	slot0.recoverCount = slot2:GetShopRecoverTimes()

	if slot0.recoverCount < slot2:GetShopRecoverMaxTimes() then
		SetActive(slot0.m_recoverContent, true)
	else
		SetActive(slot0.m_recoverContent, false)
	end

	slot0.m_addBloodDes.text = PolyhedronEffectCfg[PolyhedronSettingCfg[PolyhedronConst.POLYHEDRON_SETTING_ID.SHOP_RECOVER].value[1]].params[1] / 10 .. "%"
	slot0.coinId = slot2:GetPolyhedronCoinId()
	slot0.m_coinIcon.sprite = ItemTools.getItemLittleSprite(slot0.coinId)
	slot0.m_coinLab.text = slot2:GetCoinCount()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.polyhedronInfo, slot0.shops[slot1])
end

function slot0.Dispose(slot0)
	slot0.shopList:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnPolyhedronGameUpdate(slot0)
	slot0:RefreshUI(slot0.shopList:GetScrolledPosition())
end

function slot0.OnPolyhedronProcessUpdate(slot0)
	slot0:RefreshUI(slot0.shopList:GetScrolledPosition())
end

return slot0
