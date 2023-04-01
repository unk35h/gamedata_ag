slot0 = class("BulletinSwitchView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Bulletin/BulletinUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:AddEventListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.contentView_ = BulletinContentView.New(slot0.mainContent_)
	slot0.titleItems_ = {
		slot0.titleItem1_:GetComponent(typeof(Toggle)),
		slot0.titleItem2_:GetComponent(typeof(Toggle)),
		slot0.titleItem3_:GetComponent(typeof(Toggle))
	}
	slot0.toggles_ = {
		slot0.toggle1_,
		slot0.toggle2_,
		slot0.toggle3_
	}
end

function slot0.AddUIListener(slot0)
	slot4 = slot0.bgBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		uv0:Back()
	end)

	for slot4, slot5 in ipairs(slot0.toggles_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				OperationRecorder.Record("bulletin", "changeType")

				slot1 = nil

				if uv0 == 1 then
					slot1 = BulletinData.GetBulletinIDList()[101]

					SDKTools.SendMessageToSDK("announcement_touch", {
						touch_times_activity = 1,
						touch_times_game = 0
					})
				elseif uv0 == 2 then
					slot1 = BulletinData.GetBulletinIDList()[102]

					SDKTools.SendMessageToSDK("announcement_touch", {
						touch_times_game = 1,
						touch_times_activity = 0
					})
				else
					slot1 = BulletinData.GetBulletinIDList()[104]
				end

				for slot5, slot6 in pairs(slot1) do
					uv1:SelectItem(BulletinData.GetBulletinPageList()[slot6])

					break
				end

				uv1:UpdateLayout()
			end
		end)
	end
end

function slot0.AddEventListener(slot0)
	slot0:RegistEventListener(BULLETIN_LIST_UPDATE, handler(slot0, slot0.OnBulletinListUpdate))
	slot0:RegistEventListener(RED_POINT_UPDATE, handler(slot0, slot0.RedPointUpdate))
end

function slot0.OnBulletinListUpdate(slot0)
	slot0:UpdateBtnItems()
end

function slot0.OnBulletinDelete(slot0, slot1)
	slot0:UpdateBtnItems()

	if slot0.currentItem_ ~= nil and slot0.currentItem_.data_ ~= nil and slot0.currentItem_.data_.id == slot1.id then
		if slot0:FindFirstBulletin(slot1) then
			slot0:SelectItem(slot2)
		else
			slot0:Back()
		end
	end
end

function slot0.OnSubscribe(slot0)
end

function slot0.RedPointUpdate(slot0, slot1)
	if slot1 == RedPointConst.BULLETIN_UNREAD_101 then
		SetActive(slot0.notice1_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_101) > 0)
	elseif slot1 == RedPointConst.BULLETIN_UNREAD_102 then
		SetActive(slot0.notice2_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_102) > 0)
	elseif slot1 == RedPointConst.BULLETIN_UNREAD_104 then
		SetActive(slot0.notice3_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_104) > 0)
	end
end

function slot0.UpdateTimer(slot0)
	slot0:RemoveAllUpdateTimer()

	slot0.updateTimers_ = {}

	for slot4, slot5 in pairs(BulletinData.GetBulletinPageList()) do
		slot7 = Timer.New(function ()
			uv0.updateTimers_[uv1]:Stop()

			uv0.updateTimers_[uv1] = nil

			BulletinAction.BulletinDelete(uv1)
			uv0:UpdateBtnItems()

			if uv0:GetViewProp("bulletinID") == uv1 then
				if uv0:FindFirstBulletin(uv2) then
					uv0:SelectItem(slot0)
				else
					uv0:Back()
				end
			end
		end, slot5.endTime - manager.time:GetServerTime(), 1)

		slot7:Start()

		slot0.updateTimers_[slot5.id] = slot7
	end
end

function slot0.RemoveAllUpdateTimer(slot0)
	slot1 = pairs
	slot3 = slot0.updateTimers_ or {}

	for slot4, slot5 in slot1(slot3) do
		slot5:Stop()
	end

	slot0.updateTimers_ = nil
end

function slot0.FindFirstBulletin(slot0, slot1)
	if #BulletinData.GetBulletinIDList()[slot1.type] > 0 then
		for slot7, slot8 in pairs(slot3) do
			return BulletinData.GetBulletinPageList()[slot8]
		end
	end

	for slot7, slot8 in pairs(slot2) do
		if #slot8 > 0 then
			for slot12, slot13 in pairs(slot8) do
				return BulletinData.GetBulletinPageList()[slot13]
			end
		end
	end

	return nil
end

function slot0.OnEnter(slot0)
	slot0.treeScrollRect_.verticalNormalizedPosition = 1
	slot0.enteredBtnItems_ = {}

	slot0:UpdateBtnItems()

	slot5 = slot0.params_.bulletinID

	slot0:SetViewProp("bulletinID", slot5)

	slot4 = slot0.GetViewProp

	slot0.contentView_:SetBulletInId(slot4(slot0, "bulletinID"))

	for slot4, slot5 in pairs(BulletinData.GetBulletinPageList()) do
		if slot5.id == slot0.params_.bulletinID then
			slot0:SelectItem(slot5)

			break
		end
	end

	for slot4, slot5 in pairs(slot0.activityBtnItems_) do
		slot0:CheckItemEnter(slot5)
	end

	for slot4, slot5 in pairs(slot0.gameBtnItems_) do
		slot0:CheckItemEnter(slot5)
	end

	SetActive(slot0.notice1_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_101) > 0)
	SetActive(slot0.notice2_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_102) > 0)
	SetActive(slot0.notice3_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_104) > 0)
end

function slot0.CheckItemEnter(slot0, slot1)
	if not slot0.enteredBtnItems_[slot1.data_.id] then
		slot1:OnEnter()

		slot0.enteredBtnItems_[slot1.data_.id] = true
	end
end

function slot0.ClearBtnItems(slot0)
	if slot0.activityBtnItems_ then
		for slot4, slot5 in ipairs(slot0.activityBtnItems_) do
			slot5:Dispose()
		end

		slot0.activityBtnItems_ = nil
	end

	if slot0.gameBtnItems_ then
		for slot4, slot5 in ipairs(slot0.gameBtnItems_) do
			slot5:Dispose()
		end

		slot0.gameBtnItems_ = nil
	end

	if slot0.infoBtnItems_ then
		for slot4, slot5 in pairs(slot0.infoBtnItems_) do
			slot5:Dispose()
		end

		slot0.infoBtnItems_ = nil
	end
end

function slot0.UpdateBtnItems(slot0)
	if not slot0.activityBtnItems_ then
		slot0.activityBtnItems_ = {}
	end

	if not slot0.gameBtnItems_ then
		slot0.gameBtnItems_ = {}
	end

	if not slot0.infoBtnItems_ then
		slot0.infoBtnItems_ = {}
	end

	slot1 = BulletinData.GetBulletinIDList()[101] or {}

	slot0:UpdateBtnItemByList(slot0.activityBtnItems_, slot1, slot0.activityContainer_)
	slot0:UpdateBtnItemByList(slot0.gameBtnItems_, BulletinData.GetBulletinIDList()[102] or {}, slot0.gameContainer_)
	slot0:UpdateBtnItemByList(slot0.infoBtnItems_, BulletinData.GetBulletinIDList()[104] or {}, slot0.infoContainer_)

	if #slot1 ~= 0 then
		SetActive(slot0.titleItem1_, true)
	else
		SetActive(slot0.titleItem1_, false)
	end

	if #slot2 ~= 0 then
		SetActive(slot0.titleItem2_, true)
	else
		SetActive(slot0.titleItem2_, false)
	end

	if #slot3 ~= 0 then
		SetActive(slot0.titleItem3_, true)
	else
		SetActive(slot0.titleItem3_, false)
	end

	slot0:UpdateLayout()
end

function slot0.UpdateLayout(slot0)
	slot2 = BulletinData.GetBulletinIDList()[102] or {}
	slot3 = BulletinData.GetBulletinIDList()[104] or {}

	if #(BulletinData.GetBulletinIDList()[101] or {}) ~= 0 then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.activityContainer_)
	end

	if #slot2 ~= 0 then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.gameContainer_)
	end

	if #slot3 ~= 0 then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.infoContainer_)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.treeContainer_)
end

function slot0.UpdateBtnItemByList(slot0, slot1, slot2, slot3)
	slot4 = 0

	for slot8, slot9 in pairs(slot2) do
		slot10 = BulletinData.GetBulletinPageList()[slot9]

		if slot4 + 1 <= #slot1 then
			slot1[slot4]:SetData(slot10)
		else
			slot11 = Object.Instantiate(slot0.btnItemPrefab_, slot3)

			SetActive(slot11, true)

			slot12 = BulletinBtnItem.New(handler(slot0, slot0.OnClickBtnItem), slot11)

			slot12:SetData(slot10)
			slot0:CheckItemEnter(slot12)
			table.insert(slot1, slot12)
		end

		if slot1[slot4] then
			if slot0.currentId_ and slot0.currentId_ == slot9 then
				slot0.currentItem_ = slot11

				slot11:SetSelected(true)
			else
				slot11:SetSelected(false)
			end
		end
	end

	slot5 = 0

	for slot9, slot10 in pairs(slot2) do
		slot5 = slot5 + 1
	end

	while slot5 < #slot1 do
		slot1[#slot1]:Dispose()
		table.remove(slot1, #slot1)
	end
end

function slot0.OnClickBtnItem(slot0, slot1)
	slot0:SelectItem(slot1)
end

function slot0.SelectItem(slot0, slot1)
	if slot0.currentItem_ then
		slot0.currentItem_:SetSelected(false)
	end

	slot0.contentView_:SwitchBulletinPage(slot1.id)

	if getData("bulletin", "bulletin_" .. slot1.id) ~= "true" then
		BulletinAction.BulletinRead(slot1.id)
	end

	slot2 = nil
	slot3 = false
	slot4 = false
	slot5 = false

	if slot1.type == 101 then
		slot2 = slot0.activityBtnItems_
		slot3 = true
	elseif slot1.type == 102 then
		slot2 = slot0.gameBtnItems_
		slot4 = true
	elseif slot1.type == 104 then
		slot2 = slot0.infoBtnItems_
		slot5 = true
	end

	slot0.titleItems_[1].isOn = slot3
	slot0.titleItems_[2].isOn = slot4
	slot0.titleItems_[3].isOn = slot5

	for slot9, slot10 in ipairs(slot2) do
		if slot10.data_.id == slot1.id then
			slot0.currentItem_ = slot10

			slot10:SetSelected(true)

			slot0.currentId_ = slot10.data_.id

			break
		end
	end
end

function slot0.GetFirstBulletin(slot0)
	slot1 = manager.time:GetServerTime()

	for slot6, slot7 in ipairs({
		101,
		102,
		104
	}) do
		if BulletinData.GetBulletinIDList()[slot7] then
			for slot12, slot13 in pairs(slot8) do
				if slot1 < BulletinData.GetBulletinPageList()[slot13].endTime then
					return slot14
				end
			end
		end
	end

	return false
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.activityBtnItems_) do
		slot5:OnExit()
	end

	for slot4, slot5 in pairs(slot0.gameBtnItems_) do
		slot5:OnExit()
	end

	for slot4, slot5 in pairs(slot0.infoBtnItems_) do
		slot5:OnExit()
	end

	slot0:RemoveAllUpdateTimer()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()

	if slot0.contentView_ then
		slot0.contentView_:Dispose()

		slot0.contentView_ = nil
	end

	slot0:ClearBtnItems()
	uv0.super.Dispose(slot0)
end

return slot0
