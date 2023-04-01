slot0 = class("DormChooseRoomView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dorm/DormEntranceUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot5 = DromPrivateRoomItem
	slot0.roomItemScroll = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, slot5)
	slot0.toggleGropu = {}
	slot0.scrollRect_ = slot0.uilistGo_:GetComponent("ScrollRectEx")

	for slot5 = 1, GameDisplayCfg.dorm_area_layer_num.value[1] do
		slot0.toggleGropu[slot5] = slot0["floor" .. slot5 .. "Tgl_"]
	end

	slot0.bgAni = slot0.bg1Go_:GetComponent("Animation")
	slot0.floorAniamtion = {}

	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0:RefreshRoomItem()

	if not slot0.floor then
		slot0.floor = DormitoryData:GetFloor() or 1
	end

	slot0.toggleGropu[slot0.floor].isOn = true
	slot4 = DormConst.DORM_FLOOR_MAX + 1 - slot0.floor

	slot0.roomItemScroll:ScrollToIndex(slot4, false, false)

	for slot4 = 1, GameDisplayCfg.dorm_area_layer_num.value[1] do
		slot0["text" .. slot4 .. "Text_"].text = slot4 .. "F"
	end

	slot0.moveFlag = false
	slot0.lastVtc = 0

	slot0:RegisterEvent()
end

function slot0.OnTop(slot0)
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(DORM_PRIVATE_LEVEL_UP, function ()
		uv0:RefreshRoomLevel()
	end)
	slot0:RegistEventListener(DORM_HERO_OCCUPY, function ()
		uv0.roomItemScroll:Refresh()
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.roomItemScroll

	slot1:SetPageChangeHandler(handler(slot0, slot0.OnPageChange))

	slot4 = slot0.buttonreturnBtn_

	slot0:AddBtnListenerScale(slot4, nil, function ()
		JumpTools.OpenPageByJump("/dorm")
	end)

	for slot4 = 1, DormConst.DORM_FLOOR_MAX do
		slot0:AddToggleListener(slot0["floor" .. slot4 .. "Tgl_"], function (slot0)
			if slot0 then
				uv0.floor = uv1

				uv0.roomItemScroll:ScrollToIndex(DormConst.DORM_FLOOR_MAX + 1 - uv0.floor, true, true, 0.5)

				uv0.toggleGropu[uv0.floor].isOn = true

				DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.ChangeFloor)
			end
		end)
	end

	slot0:AddBtnListenerScale(slot0.visitBtn_, nil, function ()
		JumpTools.OpenPageByJump("/dormVisitView")
	end)
	slot0:AddBtnListenerScale(slot0.btnupBtn_, nil, function ()
		if uv0.floor < DormConst.DORM_FLOOR_MAX then
			uv0.floor = uv0.floor + 1

			uv0.roomItemScroll:ScrollToIndex(DormConst.DORM_FLOOR_MAX + 1 - uv0.floor, true, true, 0.5)

			uv0.toggleGropu[uv0.floor].isOn = true

			DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.ChangeFloor)
		end
	end)
	slot0:AddBtnListenerScale(slot0.btnunderBtn_, nil, function ()
		if uv0.floor > 1 then
			uv0.floor = uv0.floor - 1

			uv0.roomItemScroll:ScrollToIndex(DormConst.DORM_FLOOR_MAX + 1 - uv0.floor, true, true, 0.5)

			uv0.toggleGropu[uv0.floor].isOn = true

			DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.ChangeFloor)
		end
	end)

	slot1 = slot0.scrollRect_.onValueChanged

	slot1:AddListener(function (slot0)
		if slot0.y > 0.05 and slot0.y < 0.94 and uv0.lastVtc < slot0.y and not uv0.moveFlag then
			uv0.moveFlag = true
			slot4 = "DormEntranceUI_bg_loop_jing_cx"

			uv0.bgAni:Play(slot4)

			for slot4 = 1, DormConst.DORM_FLOOR_MAX do
				if uv0.floorAniamtion[slot4] then
					uv0.floorAniamtion[slot4]:Play("DormEntranceUI_bg06_cx")
				end
			end
		end

		if slot0.y > 0.95 and uv0.lastVtc < slot0.y and uv0.moveFlag then
			uv0.moveFlag = false
			slot4 = "DormEntranceUI_bg_loop_jing_xs"

			uv0.bgAni:Play(slot4)

			for slot4 = 1, DormConst.DORM_FLOOR_MAX do
				if uv0.floorAniamtion[slot4] then
					uv0.floorAniamtion[slot4]:Play("DormEntranceUI_bg06_xs")
				end
			end
		end

		if slot0.y < 0.05 and slot0.y < uv0.lastVtc and uv0.moveFlag then
			uv0.moveFlag = false
			slot4 = "DormEntranceUI_bg_loop_jing_xs"

			uv0.bgAni:Play(slot4)

			for slot4 = 1, DormConst.DORM_FLOOR_MAX do
				if uv0.floorAniamtion[slot4] then
					uv0.floorAniamtion[slot4]:Play("DormEntranceUI_bg06_xs")
				end
			end
		end

		if slot0.y < 0.95 and slot0.y > 0.06 and slot0.y < uv0.lastVtc and not uv0.moveFlag then
			uv0.moveFlag = true
			slot4 = "DormEntranceUI_bg_loop_jing_cx"

			uv0.bgAni:Play(slot4)

			for slot4 = 1, DormConst.DORM_FLOOR_MAX do
				if uv0.floorAniamtion[slot4] then
					uv0.floorAniamtion[slot4]:Play("DormEntranceUI_bg06_cx")
				end
			end
		end

		uv0.lastVtc = slot0.y
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RegisterAnimation(function (slot0, slot1)
		uv0.floorAniamtion[slot0] = slot1
	end)
	slot2:RefreshUI(slot0.floorList[slot1])
end

function slot0.OnPageChange(slot0, slot1)
	if slot1 < 1 or DormConst.DORM_FLOOR_MAX < slot1 then
		return
	end

	slot0.floor = DormConst.DORM_FLOOR_MAX + 1 - slot1
	slot0.toggleGropu[slot0.floor].isOn = true
end

function slot0.RefreshRoomItem(slot0)
	slot0.floorList = {}

	for slot5 = DormConst.DORM_FLOOR_MAX, 1, -1 do
		table.insert(slot0.floorList, slot5)
	end

	slot0.roomItemScroll:StartScroll(#slot0.floorList)

	slot0.itemGo = {}
end

function slot0.Dispose(slot0)
	if slot0.roomItemScroll then
		slot0.roomItemScroll:Dispose()
	end

	DormitoryData:SetFloor(slot0.floor)
	uv0.super.Dispose(slot0)
end

return slot0
