slot0 = class("HeadIconChangeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/AvatarSystemUI"
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

	slot0.pageS_ = {
		[1.0] = "portrait",
		[2.0] = "frame"
	}
	slot0.toggleS_ = {
		slot0.iconTgl_,
		slot0.frameTgl_
	}
	slot0.lockCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "lock")
	slot0.pageCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "pageCon")
	slot0.scrollList_ = LuaList.New(handler(slot0, slot0.Renderer), slot0.listGo_, UserHeadItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		if uv0.curPage_ == "portrait" then
			PlayerAction.ChangePortrait(uv0.curID_)
		elseif uv0.curPage_ == "frame" then
			PlayerAction.ChangeFrameIcon(uv0.curID_)
		end

		ShowTips("SUCCESS_CHANGE")
	end)

	slot4 = slot0.bgBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		uv0:Back()
	end)

	for slot4, slot5 in ipairs(slot0.toggleS_) do
		slot6 = slot5.onValueChanged

		slot6:AddListener(function (slot0)
			if slot0 then
				uv0.curPage_ = uv0.pageS_[uv1]

				uv0:RefreshUI()
				uv0.scrollList_:StartScroll(#uv0.curList_)
			end
		end)
	end
end

function slot0.OnEnter(slot0)
	slot1 = PlayerData

	slot1:RefreshFrameList(function ()
		PlayerData:DealOverdueFrame()

		uv0.curList_ = {}
		uv0.portraitList_ = {}
		uv0.frameList_ = {}
		uv0.curPage_ = "portrait"
		uv0.toggleS_[1].isOn = true

		uv0:GetPortraitList()
		uv0:GetFrameList()
		uv0:RefreshUI()
		uv0.scrollList_:StartScroll(#uv0.curList_)
	end)
end

function slot0.Renderer(slot0, slot1, slot2)
	slot3 = slot0.curList_[slot1].id

	slot2:RefreshItem(slot3, slot0.curPage_)
	slot2:SetUsed(slot0:IsUsed(slot3))
	slot2:SetSelected(slot0.curID_ == slot3)
	slot2:RegisterClickListener(function ()
		uv0:SetCurID(uv1)
	end)

	if slot0.curPage_ == "frame" then
		slot2:SetLastTime(PlayerData:GetFrame(slot3).lasted_time - manager.time:GetServerTime() < 0 and GetTips("TIP_EXPIRED") or slot0:GetTimeText(slot6))
	end

	slot2:SetTimer()
end

function slot0.GetPortraitList(slot0)
	slot2 = HideInfoData:GetHeadIconHideList()

	for slot6, slot7 in ipairs(PlayerData:GetPortraitList()) do
		if not slot2[slot7] then
			table.insert(slot0.portraitList_, PlayerData:GetPortrait(slot7))
		end
	end

	table.sort(slot0.portraitList_, function (slot0, slot1)
		if slot0.unlock ~= slot1.unlock then
			return slot1.unlock < slot0.unlock
		end

		return slot0.id < slot1.id
	end)
end

function slot0.GetFrameList(slot0)
	slot2, slot3 = nil

	for slot7, slot8 in ipairs(PlayerData:GetFrameList()) do
		slot3 = PlayerData:GetFrame(slot8)

		if ItemCfg[slot8].sub_type == 1202 then
			if slot3.unlock == 1 or slot3.lasted_time > 0 then
				table.insert(slot0.frameList_, slot3)
			end
		else
			table.insert(slot0.frameList_, slot3)
		end
	end

	table.sort(slot0.frameList_, function (slot0, slot1)
		if slot0.unlock ~= slot1.unlock then
			return slot1.unlock < slot0.unlock
		end

		return slot0.id < slot1.id
	end)
end

function slot0.RefreshUI(slot0)
	slot0.portraitID_ = PlayerData:GetCurPortrait()
	slot0.frameID_ = PlayerData:GetCurFrame()
	slot0.icon_.sprite = ItemTools.getItemSprite(slot0.portraitID_)
	slot0.frameIcon_.sprite = ItemTools.getItemSprite(slot0.frameID_)

	slot0.pageCon_:SetSelectedState(slot0.curPage_)

	if slot0.curPage_ == "portrait" then
		slot0.curList_ = slot0.portraitList_

		slot0:SetCurID(slot0.portraitID_)
	elseif slot0.curPage_ == "frame" then
		slot0.curList_ = slot0.frameList_

		slot0:SetCurID(slot0.frameID_)
	end

	slot0:RefreshTimer()
end

function slot0.SetCurID(slot0, slot1)
	slot0.curID_ = slot1
	slot2, slot3 = nil

	if slot0.curPage_ == "portrait" then
		slot3 = PlayerData:GetPortrait(slot0.curID_)
		slot0.icon_.sprite = ItemTools.getItemSprite(slot0.curID_)

		slot0.icon_:SetNativeSize()
	elseif slot0.curPage_ == "frame" then
		slot0.frameIcon_.sprite = ItemTools.getItemSprite(slot0.curID_)

		slot0.frameIcon_:SetNativeSize()

		if PlayerData:GetFrame(slot0.curID_).lasted_time > 0 then
			slot0.timeCntText_.text = manager.time:STimeDescS(slot3.lasted_time, "!%Y/%m/%d %H:%M")

			SetActive(slot0.timeCntGo_, true)
		else
			SetActive(slot0.timeCntGo_, false)
		end
	end

	if slot0:IsUsed(slot0.curID_) then
		slot0.useBtn_.interactable = false
		slot0.btnTxt_.text = GetTips("TIP_USING")
	else
		slot0.useBtn_.interactable = true
		slot0.btnTxt_.text = GetTips("TIP_USE")
	end

	slot0.lockCon_:SetSelectedState((slot3.unlock == 0 and true or false) and "lock" or "default")

	slot0.itemCfg_ = ItemCfg[slot0.curID_]
	slot0.nameTxt_.text = slot0.itemCfg_.name
	slot0.descTxt_.text = slot0.itemCfg_.desc
	slot0.wayTxt_.text = slot0.itemCfg_.desc_source

	slot0:RefreshList()
end

function slot0.IsUsed(slot0, slot1)
	return slot1 == slot0.portraitID_ or slot1 == slot0.frameID_
end

function slot0.RefreshList(slot0)
	slot3 = slot0.scrollList_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:SetSelected(slot5.itemID_ == slot0.curID_)
		slot5:SetUsed(slot0:IsUsed(slot5.itemID_))
	end
end

function slot0.RefreshTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.curPage_ ~= "portrait" then
		slot0.timer_ = Timer.New(function ()
			slot0, slot1, slot2 = nil
			slot3 = manager.time:GetServerTime()
			slot6 = uv0.scrollList_
			slot8 = slot6

			for slot7, slot8 in pairs(slot6.GetItemList(slot8)) do
				if PlayerData:GetFrame(slot8.itemID_).lasted_time > 0 then
					if slot1.lasted_time - slot3 >= 0 then
						slot8:SetLastTime(uv0:GetTimeText(slot2))
					else
						slot8:SetLastTime(GetTips("TIP_EXPIRED"))

						if slot1.unlock == 1 then
							uv0.timer_:Stop()

							uv0.timer_ = nil

							if uv0.frameID_ == slot0 then
								PlayerData:RefreshFrameList(function ()
									uv0.scrollList_:StartScroll(#uv0.curList_)
								end)
							else
								PlayerData:RefreshFrameList(function ()
									uv0.frameList_ = {}

									uv0:GetFrameList()
									uv0:RefreshUI()
									uv0.scrollList_:StartScroll(#uv0.curList_)
								end)
							end

							return
						end
					end
				end
			end

			slot1 = PlayerData:GetFrame(uv0.curID_)
			slot2 = slot1.lasted_time - slot3

			if slot1.lasted_time > 0 and slot2 < 0 and slot1.unlock == 1 then
				uv0.timer_:Stop()

				uv0.timer_ = nil

				if uv0.frameID_ == slot0 then
					PlayerData:RefreshFrameList(function ()
						uv0.scrollList_:StartScroll(#uv0.curList_)
					end)
				else
					PlayerData:RefreshFrameList(function ()
						uv0.frameList_ = {}

						uv0:GetFrameList()
						uv0:RefreshUI()
						uv0.scrollList_:StartScroll(#uv0.curList_)
					end)
				end
			end
		end, 1, -1)

		slot0.timer_:Start()
	end
end

function slot0.GetTimeText(slot0, slot1)
	slot2 = ""

	return slot1 / 86400 >= 1 and math.ceil(slot1 / 86400) .. GetTips("DAY") or slot1 / 3600 >= 1 and math.ceil(slot1 / 3600) .. GetTips("HOUR") or slot1 / 60 >= 1 and math.ceil(slot1 / 60) .. GetTips("MINUTE") or 1 .. GetTips("MINUTE")
end

function slot0.OnChangePortrait(slot0)
	slot0:RefreshUI()
end

function slot0.OnChangeFrame(slot0)
	slot0.frameList_ = {}

	slot0:GetFrameList()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
