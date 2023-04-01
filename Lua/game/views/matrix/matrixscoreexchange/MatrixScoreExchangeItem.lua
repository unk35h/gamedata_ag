slot0 = class("MatrixScoreExchangeItem", ReduxView)

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

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.lockController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "lock")
	slot0.bonusLuaList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.bonusListGo_, CommonItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.bonusList_[slot1].item_id,
		number = slot0.bonusList_[slot1].item_num
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		MatrixAction.GetBonus({
			rank = uv0.rank_,
			reward = uv0.bonusList_
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.index_ = slot1
	slot0.rank_ = slot2
	slot0.score_ = MatrixPointRankCfg[slot2].point
	slot0.bonusList_ = slot3
	slot0.haveGetBonus_ = slot4
	slot0.needLevel = slot5

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.scoreText_.text = string.format("%d", slot0.score_)

	slot0.bonusLuaList_:StartScroll(#slot0.bonusList_)

	if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_MATRIX_PT) < slot0.score_ then
		slot0.statusController_:SetSelectedState("cannotGet")
	elseif slot0.haveGetBonus_ == 1 then
		slot0.statusController_:SetSelectedState("haveGet")
	else
		slot0.statusController_:SetSelectedState("canGet")
	end

	if MatrixData:GetTerminalLevel() < slot0.needLevel then
		slot0.lockController_:SetSelectedIndex(1)

		slot0.lockTip_.text = string.format(GetTips("MATRIX_TERMINAL_LEVEL_UNLOCK"), slot0.needLevel)

		slot0.statusController_:SetSelectedState("cannotGet")
	else
		slot0.lockController_:SetSelectedIndex(0)
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.bonusLuaList_ then
		slot0.bonusLuaList_:Dispose()

		slot0.bonusLuaList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
