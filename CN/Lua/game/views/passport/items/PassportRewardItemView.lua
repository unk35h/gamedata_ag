slot0 = class("PassportRewardItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:AddEventListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.commonItem1_ = CommonItem.New(slot0.commonItemGo1_)
	slot0.commonItem2_ = CommonItem.New(slot0.commonItemGo2_)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GET_BONUS_SUCCESS, handler(slot0, slot0.OnGetBonus))
	slot0:RegistEventListener(PASSPORT_BUYED, handler(slot0, slot0.OnPassportBuyed))
end

function slot0.OnPassportBuyed(slot0)
	slot0:UpdateView()
end

function slot0.OnGetBonus(slot0, slot1)
	if slot1 == slot0.cfg_.id or slot1 == 0 then
		slot0:UpdateView()
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.cfg_ = BattlePassCfg[slot2]
	slot0.levelCfg_ = GameLevelSetting[slot0.index_]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.levelLabel_.text = string.format("%d", slot0.index_)
	slot0.bottomLabel_.text = string.format("%d", slot0.index_)

	slot0.commonItem1_:RefreshData({
		id = slot0.cfg_.reward_free[1][1],
		number = slot0.cfg_.reward_free[1][2]
	})
	slot0.commonItem2_:RefreshData({
		id = slot0.cfg_.reward_pay[1][1],
		number = slot0.cfg_.reward_pay[1][2]
	})
	slot0.statusController_:SetSelectedState(PassportData:GetRewardStatus(slot0.index_, slot0.cfg_.id))
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.commonItem1_

	slot1:RegistCallBack(function (slot0)
		uv0:OnItemClick(slot0.id, slot0.number, 1)
	end)

	slot1 = slot0.commonItem2_

	slot1:RegistCallBack(function (slot0)
		uv0:OnItemClick(slot0.id, slot0.number, 2)
	end)
end

function slot0.OnItemClick(slot0, slot1, slot2, slot3)
	if slot3 == 1 and slot0.statusController_:GetSelectedState() ~= "freeCanGet" and slot0.statusController_:GetSelectedState() ~= "payCanGet" then
		if slot1 ~= 0 and slot2 ~= 0 then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				slot2
			})
		end

		return
	end

	if slot3 == 2 and slot0.statusController_:GetSelectedState() ~= "payCanGet" and slot0.statusController_:GetSelectedState() ~= "payHalfCanGet" then
		if slot1 ~= 0 and slot2 ~= 0 then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				slot2
			})
		end

		return
	end

	PassportAction.RequestGetBonus(slot0.cfg_.id, PassportData:GetPayLevel() > 0 and 1 or 0)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	if slot0.commonItem1_ then
		slot0.commonItem1_:Dispose()

		slot0.commonItem1_ = nil
	end

	if slot0.commonItem2_ then
		slot0.commonItem2_:Dispose()

		slot0.commonItem2_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
