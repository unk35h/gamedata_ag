slot0 = class("DrawAllHeroSelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Draw/SelectPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.confirmEnabledController_ = ControllerUtil.GetController(slot0.btnrenewalBtn_.gameObject.transform, "conName")
	slot0.limitController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "limit")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, NewHeroHead)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RegisterClickListener(handler(slot0, slot0.OnHeroClick))
	slot2:SetHeroId(slot0.idList_[slot1], {
		isPreview = true
	})
	slot2:SetRedPointEnable(false)

	slot2.nameText_.text = HeroCfg[slot0.idList_[slot1]].name
	slot2.nameText_.text = string.format("%s·%s", HeroCfg[slot0.idList_[slot1]].name, HeroCfg[slot0.idList_[slot1]].suffix)

	if slot0.idList_[slot1] == slot0.curHeroId_ then
		slot2:SetSelected(true)
	else
		slot2:SetSelected(false)
	end

	slot2:SetUnlockDisplay(false)
end

function slot0.OnHeroClick(slot0, slot1)
	slot0.curHeroId_ = slot1

	slot0.uiList_:Refresh()
	slot0:UpdateBtn()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnrenewalBtn_, nil, function ()
		if uv0.curHeroId_ == nil or uv0.curHeroId_ == 0 then
			return
		end

		if uv0.curHeroId_ == uv0.params_.heroId then
			uv0:Back()
		else
			if uv0.params_.isFirst then
				slot0 = DrawPoolCfg[uv0.params_.poolId]

				DrawAction.SetPollUpID(uv0.params_.poolId, slot0.optional_lists[table.indexof(slot0.optional_detail, uv0.curHeroId_)])

				return
			end

			slot3 = DrawData

			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("DRAW_SWITCH_LIMIT_CONFIRM_TIP"),
				SecondTip = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), ""),
				SecondValue = slot3:GetUpRemainTime(uv0.params_.poolId),
				OkCallback = function ()
					slot0 = DrawPoolCfg[uv0.params_.poolId]

					DrawAction.SetPollUpID(uv0.params_.poolId, slot0.optional_lists[table.indexof(slot0.optional_detail, uv0.curHeroId_)])
				end,
				CancelCallback = function ()
				end
			})
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnSetPollUpID(slot0, slot1, slot2)
	slot0:Back()
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	if slot0.params_.isFirst then
		manager.windowBar:HideBar()
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.curHeroId_ = slot0.params_.heroId or 0

	slot0:UpdateList()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.UpdateList(slot0)
	slot0.idList_ = slot0.params_.heroIdList

	slot0.uiList_:StartScroll(#slot0.idList_)

	if DrawPoolCfg[slot0.params_.poolId].pool_change == 0 or slot0.params_.isFirst then
		slot0.limitController_:SetSelectedState("false")
	else
		slot0.limitController_:SetSelectedState("true")

		slot0.timesText_.text = DrawData:GetUpRemainTime(slot0.params_.poolId)
	end

	slot0:UpdateBtn()
end

function slot0.UpdateBtn(slot0)
	if slot0.curHeroId_ == 0 then
		slot0.confirmEnabledController_:SetSelectedState("black")
	else
		slot0.confirmEnabledController_:SetSelectedState("yellow")
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
