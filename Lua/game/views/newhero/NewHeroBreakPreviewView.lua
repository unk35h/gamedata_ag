slot0 = class("NewHeroBreakPreviewView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroPromotion/HeroBreakPreviewUI"
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

	slot0.breakLevelController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "breakLevel")
	slot0.needList_ = LuaList.New(handler(slot0, slot0.indexNeedItem), slot0.needListGo_, CommonItem)
end

function slot0.indexNeedItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.breakCfg_.cost[slot1][1],
		number = slot0.breakCfg_.cost[slot1][2]
	})

	if (MaterialData:GetMaterialList()[slot0.breakCfg_.cost[slot1][1]] ~= nil and slot3.num or 0) < slot0.breakCfg_.cost[slot1][2] then
		slot2:SetBottomText(string.format("<color=#F76866>%d</color>", slot0.breakCfg_.cost[slot1][2]))
	end

	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_SOURCE_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.prevBtn_, nil, function ()
		uv0:SwitchBreakLevel(uv0.curBreakIndex_ - 1)
	end)
	slot0:AddBtnListener(slot0.nextBtn_, nil, function ()
		uv0:SwitchBreakLevel(uv0.curBreakIndex_ + 1)
	end)
end

function slot0.InitData(slot0)
	slot0.heroInfo_ = slot0.params_.heroInfo
	slot0.heroCfg_ = HeroCfg[slot0.heroInfo_.id]
	slot0.breakIdList_ = HeroBreakCfg.get_id_list_by_race[slot0.heroCfg_.race]
	slot0.curBreakId_ = HeroTools.GetHeroBreakConfig(slot0.heroCfg_.race, slot0.heroInfo_.break_level or 0).id

	for slot4 = 1, #slot0.breakIdList_ do
		if HeroBreakCfg[slot0.breakIdList_[slot4]].cost_gold == 0 then
			table.remove(slot0.breakIdList_, slot4)

			break
		end
	end

	slot0.curBreakIndex_ = table.indexof(slot0.breakIdList_, slot0.curBreakId_)
end

function slot0.SwitchBreakLevel(slot0, slot1)
	slot0.curBreakIndex_ = slot1
	slot0.curBreakId_ = slot0.breakIdList_[slot1]

	slot0.breakLevelController_:SetSelectedState(string.format("%d", slot1))

	slot0.breakCfg_ = HeroBreakCfg[slot0.curBreakId_]
	slot0.nextBreakCfg_ = HeroTools.GetHeroBreakConfig(slot0.heroCfg_.race, slot0.breakCfg_.break_times + 1 or 0)
	slot0.upLevelText_.text = GetTips("LEVEL") .. slot0.nextBreakCfg_.max_level

	if #slot0.breakCfg_.cost <= 4 then
		slot0.needListGo_:GetComponent(typeof(ScrollRect)).movementType = ScrollRect.MovementType.Clamped

		slot0.needList_:SetOrientation(1)
	else
		slot0.needListGo_:GetComponent(typeof(ScrollRect)).movementType = ScrollRect.MovementType.Elastic

		slot0.needList_:SetOrientation(0)
	end

	slot0.needList_:StartScroll(#slot0.breakCfg_.cost)

	if slot0.breakCfg_.user_level <= PlayerData:GetPlayerInfo().userLevel then
		slot0.conditionLabel_.text = string.format(GetTips("UPGRADE_LIMIT_LEVEL"), slot0.breakCfg_.user_level)
	else
		slot0.conditionLabel_.text = string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), slot0.breakCfg_.user_level)
	end

	if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot0.breakCfg_.cost_gold then
		slot0.needCountLabel_.text = string.format("<color=#F76866>%d</color>", slot0.breakCfg_.cost_gold)
	else
		slot0.needCountLabel_.text = tostring(slot0.breakCfg_.cost_gold)
	end

	SetActive(slot0.prevBtn_.gameObject, slot1 > 1)
	SetActive(slot0.nextBtn_.gameObject, slot1 < #slot0.breakIdList_)
end

function slot0.OnEnter(slot0)
	slot0:InitData()
	slot0:SwitchBreakLevel(slot0.curBreakIndex_)
end

function slot0.OnTop(slot0)
	slot0:SwitchBreakLevel(slot0.curBreakIndex_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.needList_ then
		slot0.needList_:Dispose()

		slot0.needList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
