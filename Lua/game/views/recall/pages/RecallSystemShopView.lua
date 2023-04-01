slot1 = class("RecallSystemShopView", import("game.views.recall.pages.RecallPageBase"))

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, RecallSystemShopItem)

	slot0:RegistEventListener(SHOP_ITEM_UPDATE, function (slot0, slot1)
		uv0:UpdateView(slot0, slot1)
	end)
	slot0:RegistEventListener(MATERIAL_MODIFY, function (slot0)
		uv0:UpdateView()
	end)

	slot0.shopID = ActivityRecallData:GetDataByPara("shopID")
end

function slot1.OnShopClick(slot0, slot1)
	if ItemCfg[getShopCfg(slot1.id).give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		if ShopTools.HaveSkin(slot2.give_id) then
			return
		end
	elseif slot2.limit_num then
		if slot2.limit_num ~= -1 and slot2.limit_num <= slot1.buyTime then
			return
		end

		slot4, slot5 = ShopTools.JudgeIsLvLimit(slot2.level_limit)

		if slot4 then
			return
		end
	end

	JumpTools.OpenPopUp("shopBuy", {
		goodInfo = slot1
	})
end

function slot1.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.shopData[slot1])
	slot2:RegistCallBack(handler(slot0, slot0.OnShopClick))
end

function slot1.OnTop(slot0)
end

function slot1.UpdateView(slot0)
	ActivityRecallData:UpdateShopData()

	slot0.shopID = ActivityRecallData:GetDataByPara("shopID")
	slot0.shopData = ActivityRecallData:GetDataByPara("shopData")

	slot0.list_:StartScroll(#slot0.shopData)

	slot0.activityTimeTxt_.text = ActivityRecallData:GetDataByPara("shopTime")
end

function slot1.OnEnter(slot0)
	slot0:UpdateView()
	slot0:OnTop()
end

function slot1.OnExit(slot0)
end

function slot1.Hide(slot0)
	uv0.super.Hide(slot0)
end

function slot1.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
