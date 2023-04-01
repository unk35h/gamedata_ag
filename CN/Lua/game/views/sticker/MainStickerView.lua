slot0 = class("MainStickerView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/StickerNEW/StickerMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.viewType_ = {
		FOREIGN = 3,
		EDITOR = 2,
		SHOW = 1
	}
	slot0.toggle_ = {
		slot0.toggle1_,
		slot0.toggle2_,
		slot0.toggle3_
	}
	slot0.stickerViewItem_ = {}
	slot0.viewCon_ = ControllerUtil.GetController(slot0.transform_, "view")
	slot0.toggleCon_ = ControllerUtil.GetController(slot0.transform_, "toggle")
end

function slot0.AddUIListeners(slot0)
	for slot4, slot5 in ipairs(slot0.toggle_) do
		slot0:AddBtnListener(slot5, nil, function ()
			if uv0.curIndex_ == uv1 then
				return
			end

			uv0:RefreshUI(uv1)
		end)
	end

	slot0:AddBtnListener(slot0.showBtn_, nil, function ()
		SetActive(uv0.btnView_, true)
		uv0:AddClickTimer()
	end)
	slot0:AddBtnListener(slot0.listBtn_, nil, function ()
		JumpTools.GoToSystem("/stickersList")
	end)
	slot0:AddBtnListener(slot0.editBtn_, nil, function ()
		uv0.curType_ = uv0.viewType_.EDITOR
		uv0.params_.tempInfo = {
			stickerBg = uv0.stickerBg_,
			info = uv0.stickerInfo_
		}

		uv0:RefreshState()
	end)
	slot0:AddBtnListener(slot0.chooseBtn_, nil, function ()
		JumpTools.OpenPageByJump("/chooseStickerTemplate", {
			chooseID = uv0.stickerInfo_[uv0.curIndex_].viewID,
			index = uv0.curIndex_,
			temp = uv0.params_.tempInfo
		})
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		JumpTools.OpenPageByJump("/chooseStickerBg", {
			chooseID = uv0.stickerBg_,
			temp = uv0.params_.tempInfo
		})
	end)
	slot0:AddBtnListener(slot0.exitBtn_, nil, function ()
		uv0.curType_ = uv0.viewType_.SHOW

		uv0.stickerViewItem_[uv0.stickerInfo_[uv0.curIndex_].viewID]:Show(false)

		uv0.stickerBg_ = uv0.params_.stickerBg
		uv0.stickerInfo_ = deepClone(uv0.params_.oldInfo or {})

		uv0:RefreshUI(uv0.curIndex_)
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		PlayerAction.ChangeStickerList(uv0.params_.tempInfo)
	end)
end

function slot0.OnEnter(slot0)
	slot0.curType_ = slot0.params_.type or slot0.viewType_.SHOW

	if slot0.curType_ == slot0.viewType_.EDITOR then
		slot0.stickerBg_ = slot0.params_.tempInfo.stickerBg
		slot0.stickerInfo_ = slot0.params_.tempInfo.info
	else
		slot0.params_.oldInfo = deepClone(slot0.params_.stickerInfo or {})
		slot0.stickerBg_ = slot0.params_.stickerBg
		slot0.stickerInfo_ = deepClone(slot0.params_.oldInfo or {})
	end

	slot0:BindRedPoint()
	slot0:RefreshUI(slot0.params_.index or 1)
end

function slot0.RefreshUI(slot0, slot1)
	slot0:RefreshView(slot1)
	slot0:RefreshState()
end

function slot0.RefreshView(slot0, slot1)
	if slot0.curIndex_ and slot0.curIndex_ ~= slot1 and slot0.stickerInfo_[slot0.curIndex_] and slot0.stickerViewItem_[slot0.stickerInfo_[slot0.curIndex_].viewID] then
		slot0.stickerViewItem_[slot0.stickerInfo_[slot0.curIndex_].viewID]:Show(false)
	end

	slot0.curIndex_ = slot1
	slot0.params_.index = slot1
	slot0.showText_.text = GetTips("TIP_DISPLAY") .. slot0.curIndex_

	if not slot0.stickerBg_ or slot0.stickerBg_ == 0 then
		slot0.stickerBg_ = GameSetting.sticker_background_default.value[1]
	end

	slot0.bg_.sprite = getSpriteWithoutAtlas("Textures/Sticker/stickerBtn/Sticker_big_" .. slot0.stickerBg_)

	if not slot0.stickerInfo_[slot0.curIndex_] then
		slot2 = {}

		for slot8, slot9 in ipairs(StickViewTemplateCfg[GameSetting.profile_sticker_template.value[1]].range_list) do
			slot2[slot8] = {
				stickerID = 0,
				size = slot9[2][1]
			}
		end

		slot0.stickerInfo_[slot0.curIndex_] = {
			index = slot0.curIndex_,
			viewID = slot3,
			sticker = slot2
		}
	end

	if not slot0.stickerViewItem_[slot0.stickerInfo_[slot0.curIndex_].viewID] then
		slot0.stickerViewItem_[slot2] = StickerView.New(slot0, Object.Instantiate(Asset.Load("UI/Main/StickerNEW/StickerTemplate" .. slot2), slot0.pageContainer_), slot2)
		slot4 = slot0.stickerViewItem_[slot2]

		slot4:RegistClickFunc(function (slot0, slot1)
			if uv0.curType_ ~= uv0.viewType_.EDITOR then
				ShowPopItem(POP_SOURCE_DES_ITEM, {
					slot0.stickerID
				}, {
					isForeign = uv0.curType_ == uv0.viewType_.FOREIGN
				})
			else
				JumpTools.OpenPageByJump("chooseStickers", {
					list = uv0.stickerInfo_[uv0.curIndex_].sticker,
					info = slot0,
					site = slot1,
					viewID = uv1
				})
			end
		end)
	end

	slot0.stickerViewItem_[slot0.stickerInfo_[slot0.curIndex_].viewID]:Show(true)

	for slot7 = #slot0.stickerInfo_[slot0.curIndex_].sticker + 1, #StickViewTemplateCfg[slot2].range_list do
		slot0.stickerInfo_[slot0.curIndex_].sticker[slot7] = {
			stickerID = 0,
			size = slot3.range_list[slot7][2][1]
		}
	end

	if slot0.params_.resetSize then
		slot7 = slot0.curIndex_

		for slot7, slot8 in ipairs(slot0.stickerInfo_[slot7].sticker) do
			if slot3.range_list[slot7] then
				slot8.size = slot3.range_list[slot7][2][1]
			end
		end

		slot0.params_.resetSize = false
	end

	slot0.stickerViewItem_[slot2]:SetData(slot0.stickerInfo_[slot0.curIndex_].sticker)
end

function slot0.RefreshState(slot0)
	slot0.viewCon_:SetSelectedState(slot0.curType_)
	slot0.stickerViewItem_[slot0.stickerInfo_[slot0.curIndex_].viewID]:RefreshUI(slot0.curType_ == slot0.viewType_.EDITOR)
end

function slot0.AddClickTimer(slot0)
	slot0:StopTimer()

	slot0.buttonUp_ = 0
	slot1 = FuncTimerManager.inst
	slot0.clickTimer_ = slot1:CreateFuncFrameTimer(function ()
		if Input.GetMouseButtonUp(0) then
			uv0.buttonUp_ = uv0.buttonUp_ + 1

			if uv0.buttonUp_ >= 2 then
				uv0:HidePop()
				FuncTimerManager.inst:RemoveFuncTimer(uv0.clickTimer_)

				uv0.clickTimer_ = nil
			end
		end
	end, -1, true)
end

function slot0.StopTimer(slot0)
	if slot0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.clickTimer_)

		slot0.clickTimer_ = nil
	end
end

function slot0.HidePop(slot0)
	SetActive(slot0.btnView_, false)
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.editBtn_.transform, RedPointConst.STICKER_BG)
	manager.redPoint:bindUIandKey(slot0.bgBtn_.transform, RedPointConst.STICKER_BG)
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.editBtn_.transform, RedPointConst.STICKER_BG)
	manager.redPoint:unbindUIandKey(slot0.bgBtn_.transform, RedPointConst.STICKER_BG)
end

function slot0.OnChangeSticker(slot0, slot1, slot2, slot3)
	slot4 = slot0.stickerInfo_[slot0.curIndex_].sticker[slot1].stickerID

	if slot2 ~= 0 then
		slot8 = slot0.curIndex_

		for slot8, slot9 in ipairs(slot0.stickerInfo_[slot8].sticker) do
			if slot9 and slot9.stickerID == slot2 then
				slot0.stickerInfo_[slot0.curIndex_].sticker[slot8].stickerID = slot4

				break
			end
		end
	end

	slot0.stickerInfo_[slot0.curIndex_].sticker[slot1] = {
		stickerID = slot2,
		size = slot3
	}

	slot0.stickerViewItem_[slot0.stickerInfo_[slot0.curIndex_].viewID]:RefreshUI(slot0.curType_ == slot0.viewType_.EDITOR)
end

function slot0.OnChangeStickerSize(slot0, slot1, slot2, slot3)
	slot0.stickerInfo_[slot0.curIndex_].sticker[slot1].size = slot3

	slot0.stickerViewItem_[slot0.stickerInfo_[slot0.curIndex_].viewID]:RefreshUI(slot0.curType_ == slot0.viewType_.EDITOR)
end

function slot0.OnChangeStickerList(slot0, slot1, slot2)
	slot0.curType_ = slot0.viewType_.SHOW
	slot0.params_.oldInfo = slot1
	slot0.params_.stickerInfo = slot1
	slot0.params_.stickerBg = slot2
	slot0.stickerBg_ = slot2
	slot0.stickerInfo_ = deepClone(slot0.params_.oldInfo)

	slot0:RefreshUI(slot0.curIndex_)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	slot0:UnBindRedPoint()
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.stickerViewItem_) do
		slot5:OnExit()
	end

	slot0.params_.type = nil
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in pairs(slot0.stickerViewItem_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
